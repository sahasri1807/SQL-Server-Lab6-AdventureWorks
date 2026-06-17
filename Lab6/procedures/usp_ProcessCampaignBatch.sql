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

USE AdventureWorks2022;
GO

IF OBJECT_ID(N'RetailAnalytics.usp_ProcessCampaignBatch', N'P') IS NOT NULL
    DROP PROCEDURE RetailAnalytics.usp_ProcessCampaignBatch;
GO

CREATE PROCEDURE RetailAnalytics.usp_ProcessCampaignBatch
    @CampaignList   RetailAnalytics.CampaignListType READONLY,
    @ProcessedCount INT OUTPUT,
    @ErrorCount     INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    SET @ProcessedCount = 0;
    SET @ErrorCount     = 0;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- TODO: Validate TVP is not empty
        IF NOT EXISTS (SELECT 1 FROM @CampaignList)
        BEGIN
            RAISERROR('CampaignList TVP is empty. Provide at least one campaign.', 16, 1);
        END

        -- TODO: Implement batch processing logic
        -- Example pattern:
        --   INSERT INTO ... SELECT ... FROM @CampaignList WHERE ...
        --   SET @ProcessedCount = @@ROWCOUNT;

        SELECT @ProcessedCount = COUNT(*)
        FROM @CampaignList;

        COMMIT TRANSACTION;

        PRINT CONCAT(
            'Batch processing stub executed. ',
            @ProcessedCount, ' campaign(s) in TVP. Implementation pending.'
        );
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SET @ProcessedCount = 0;
        SET @ErrorCount     = 1;
        THROW;
    END CATCH
END;
GO

PRINT 'Created RetailAnalytics.usp_ProcessCampaignBatch (stub — implementation pending).';
GO
