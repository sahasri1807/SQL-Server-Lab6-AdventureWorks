/*
================================================================================
  File        : usp_ProcessCampaignBatch.sql
  Author      : Lien
  Task        : Task 5 — Batch Campaign Processing Stored Procedure
  Course      : ITE-5223 SQL Server Database Development
  Lab         : Lab 6 — SQL Server Programmability

  Description :
    Processes a batch of campaigns supplied via the CampaignListType TVP.
    Performs validation and batch updates/inserts per lab business rules.

  Patterns    :
    - IF EXISTS / OBJECT_ID check before CREATE OR ALTER
    - TRY/CATCH with transaction management (BEGIN TRAN / COMMIT / ROLLBACK)
    - SET NOCOUNT ON
    - READONLY TVP parameter
    - Set-based operations (avoid cursors)

  TODO        :
    - Implement batch validation loop or set-based MERGE
    - Return processing summary (processed count, error count)
    - Coordinate with CampaignListType column definitions
================================================================================
*/
CREATE OR ALTER PROCEDURE RetailAnalytics.usp_ProcessCampaignBatch
    @CampaignList RetailAnalytics.CampaignListType READONLY  -- Table-Valued Parameter; a TVP must be READONLY and cannot be modified inside the procedure.
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY  -- Outer TRY/CATCH handles any unexpected error in one place.

        -- Parameter validation: an empty list means there is nothing to process, so the procedure stops and raises a descriptive error.
        IF NOT EXISTS (SELECT 1 FROM @CampaignList)
        BEGIN
            THROW 50001, 'The campaign list must contain at least one CampaignID.', 1;  -- A user-defined THROW must use an error number of 50000 or higher.
        END

        -- Table variable used to accumulate one result row per campaign. It is returned to the caller at the end of the procedure.
        DECLARE @Results TABLE
        (
            CampaignID    INT,
            TotalRevenue  DECIMAL(18,2),
            TotalOrders   INT,
            ReturnCode    INT,
            ErrorMessage  NVARCHAR(4000) NULL
        );

        -- Working variables, reused for each campaign in the loop.
        DECLARE @CurrID  INT;              -- current campaign being processed
        DECLARE @Revenue DECIMAL(18,2);    -- revenue returned by the revenue procedure
        DECLARE @Orders  INT;              -- order count returned by the revenue procedure
        DECLARE @RC      INT;              -- return code (0 = success, negative = a problem)
        DECLARE @ErrMsg  NVARCHAR(4000);   -- description of any error encountered

        -- A cursor is used because the revenue procedure must be called once per campaign, which cannot be expressed as a single set-based statement.
        DECLARE cur CURSOR LOCAL FAST_FORWARD FOR
            SELECT CampaignID FROM @CampaignList;

        OPEN cur;
        FETCH NEXT FROM cur INTO @CurrID;  -- Reads the first campaign.

        WHILE @@FETCH_STATUS = 0  -- Continues while there are more campaigns to read.
        BEGIN
            -- Existence and ID validation are found in usp_CalculateCampaignRevenue (Task 4), which already returns the standardized codes -1 (Not Found) and -2 (Invalid Campaign ID).
            BEGIN TRY  -- Inner TRY/CATCH isolates this single campaign.
                EXEC @RC = RetailAnalytics.usp_CalculateCampaignRevenue
                    @CampaignID   = @CurrID,
                    @TotalRevenue = @Revenue OUTPUT,  -- OUTPUT parameters are populated by the called procedure.
                    @TotalOrders  = @Orders OUTPUT;

                SET @ErrMsg = CASE @RC
                    WHEN -1 THEN 'Campaign not found.'
                    WHEN -2 THEN 'Invalid Campaign ID.'
                    ELSE NULL  -- 0 = success, no error message needed.
                END;
            END TRY
            BEGIN CATCH
                -- If one campaign fails, the error is captured here so the remaining campaigns still process instead of the whole batch aborting.
                SET @Revenue = 0;
                SET @Orders  = 0;
                SET @RC = -99;  -- -99 indicates an unexpected error for this campaign.
                SET @ErrMsg = ERROR_MESSAGE();  -- Capture the actual error text.
            END CATCH

            -- Store the result for this campaign.
            INSERT INTO @Results (CampaignID, TotalRevenue, TotalOrders, ReturnCode, ErrorMessage)
            VALUES (@CurrID, @Revenue, @Orders, @RC, @ErrMsg);

            FETCH NEXT FROM cur INTO @CurrID;  -- Advance to the next campaign.
        END

        CLOSE cur;       -- Close and...
        DEALLOCATE cur;  -- ...deallocate the cursor once the loop completes.

        -- Return all results as a single set, ordered by CampaignID.
        SELECT CampaignID, TotalRevenue, TotalOrders, ReturnCode, ErrorMessage
        FROM @Results
        ORDER BY CampaignID;

    END TRY
    BEGIN CATCH
        -- If an error left the cursor open, close and deallocate it here so it is not left allocated for the next execution.
        IF CURSOR_STATUS('local', 'cur') >= 0
        BEGIN
            CLOSE cur;
            DEALLOCATE cur;
        END;
        THROW;  -- Passes through whatever original error triggered the CATCH block—most commonly the empty‑TVP validation (error 50001), but potentially any system error that occurred before the procedure successfully completed.
    END CATCH
END
GO



