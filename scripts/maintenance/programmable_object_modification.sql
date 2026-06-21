/*
================================================================================
  File        : programmable_object_modification.sql
  Author      : Joshua
  Task        : Task 11 — Programmable Object Modification
  Course      : ITE-5223 SQL Server Database Development
================================================================================
*/

USE RetailPromotionAnalytics;
GO

/* ============================================================================
   TASK 11 (1) - ALTER STORED PROCEDURE
   usp_GetCampaignDetails
============================================================================ */

IF OBJECT_ID('RetailAnalytics.usp_GetCampaignDetails', 'P') IS NOT NULL
BEGIN
    PRINT 'Altering usp_GetCampaignDetails...';
END
GO

ALTER PROCEDURE RetailAnalytics.usp_GetCampaignDetails
    @CampaignID INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY

        IF @CampaignID IS NULL OR @CampaignID <= 0
            RETURN -2;

        IF NOT EXISTS (
            SELECT 1
            FROM RetailAnalytics.PromotionCampaign
            WHERE CampaignID = @CampaignID
        )
            RETURN -1;

        SELECT
            CampaignID,
            CampaignName,
            DiscountRate,

            -- Added enhancement for Task 11
            CASE 
                WHEN DiscountRate >= 30 THEN 'High Discount Campaign'
                WHEN DiscountRate >= 10 THEN 'Medium Discount Campaign'
                ELSE 'Low Discount Campaign'
            END AS CampaignStatus,

            CASE 
                WHEN DiscountRate > 0 THEN 'Valid Discount'
                ELSE 'Invalid Discount'
            END AS DiscountStatus

        FROM RetailAnalytics.PromotionCampaign
        WHERE CampaignID = @CampaignID;

        RETURN 0;

    END TRY
    BEGIN CATCH
        RETURN -99;
    END CATCH
END;
GO


/* ============================================================================
   TASK 11 (2) - ALTER FUNCTION
   ufn_CalculateProfitMargin
============================================================================ */

IF OBJECT_ID('RetailAnalytics.ufn_CalculateProfitMargin', 'FN') IS NOT NULL
BEGIN
    PRINT 'Altering ufn_CalculateProfitMargin...';
END
GO

ALTER FUNCTION RetailAnalytics.ufn_CalculateProfitMargin
(
    @Revenue DECIMAL(18,2),
    @Cost DECIMAL(18,2)
)
RETURNS DECIMAL(5,2)
AS
BEGIN
    DECLARE @ProfitMargin DECIMAL(5,2);

    -- NULL safety
    IF @Revenue IS NULL OR @Cost IS NULL
        RETURN NULL;

    -- Division safety (Task 11 requirement)
    IF @Revenue = 0
        RETURN 0;

    SET @ProfitMargin = ((@Revenue - @Cost) / @Revenue) * 100;

    RETURN @ProfitMargin;
END;
GO


PRINT 'Task 11: Programmable objects modified successfully.';
GO

EXEC RetailAnalytics.usp_GetCampaignDetails 1;