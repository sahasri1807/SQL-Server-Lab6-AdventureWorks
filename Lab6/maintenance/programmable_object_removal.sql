/*
================================================================================
  File        : programmable_object_removal.sql
  Author      : Joshua
  Task        : Task 12 — Programmable Object Removal
  Course      : ITE-5223 SQL Server Database Development
  Lab         : Lab 6 — SQL Server Programmability

  Description :
    Safely removes Lab 6 programmable objects in reverse dependency order.
    Used for clean teardown, redeployment, or lab reset scenarios.

  Patterns    :
    - Reverse dependency order: SPs → Functions → Types
    - IF OBJECT_ID / TYPE_ID existence checks before DROP
    - Documented removal sequence
    - No accidental schema/table drops

  TODO        :
    - Confirm removal order matches deployment dependencies
    - Add confirmation PRINT statements for each dropped object
    - Optionally wrap in TRY/CATCH for graceful error reporting
================================================================================
*/

USE AdventureWorks2022;
GO

SET NOCOUNT ON;
GO

PRINT '================================================================================';
PRINT ' Task 12 — Programmable Object Removal';
PRINT ' Removing objects in reverse dependency order';
PRINT '================================================================================';
GO

BEGIN TRY
    -- ----------------------------------------------------------------------------
    -- Step 1: Drop Stored Procedures (depend on functions and TVP type)
    -- ----------------------------------------------------------------------------
    IF OBJECT_ID(N'RetailAnalytics.usp_ProcessCampaignBatch', N'P') IS NOT NULL
    BEGIN
        DROP PROCEDURE RetailAnalytics.usp_ProcessCampaignBatch;
        PRINT 'Dropped RetailAnalytics.usp_ProcessCampaignBatch.';
    END

    IF OBJECT_ID(N'RetailAnalytics.usp_CalculateCampaignRevenue', N'P') IS NOT NULL
    BEGIN
        DROP PROCEDURE RetailAnalytics.usp_CalculateCampaignRevenue;
        PRINT 'Dropped RetailAnalytics.usp_CalculateCampaignRevenue.';
    END

    IF OBJECT_ID(N'RetailAnalytics.usp_GetCampaignDetails', N'P') IS NOT NULL
    BEGIN
        DROP PROCEDURE RetailAnalytics.usp_GetCampaignDetails;
        PRINT 'Dropped RetailAnalytics.usp_GetCampaignDetails.';
    END

    IF OBJECT_ID(N'RetailAnalytics.usp_ValidateCampaign', N'P') IS NOT NULL
    BEGIN
        DROP PROCEDURE RetailAnalytics.usp_ValidateCampaign;
        PRINT 'Dropped RetailAnalytics.usp_ValidateCampaign.';
    END

    -- ----------------------------------------------------------------------------
    -- Step 2: Drop Functions (scalar and table-valued)
    -- ----------------------------------------------------------------------------
    IF OBJECT_ID(N'RetailAnalytics.ufn_GetCampaignPerformance', N'IF') IS NOT NULL
    BEGIN
        DROP FUNCTION RetailAnalytics.ufn_GetCampaignPerformance;
        PRINT 'Dropped RetailAnalytics.ufn_GetCampaignPerformance.';
    END

    IF OBJECT_ID(N'RetailAnalytics.ufn_GetCampaignProducts', N'IF') IS NOT NULL
    BEGIN
        DROP FUNCTION RetailAnalytics.ufn_GetCampaignProducts;
        PRINT 'Dropped RetailAnalytics.ufn_GetCampaignProducts.';
    END

    IF OBJECT_ID(N'RetailAnalytics.ufn_CalculateProfitMargin', N'FN') IS NOT NULL
    BEGIN
        DROP FUNCTION RetailAnalytics.ufn_CalculateProfitMargin;
        PRINT 'Dropped RetailAnalytics.ufn_CalculateProfitMargin.';
    END

    IF OBJECT_ID(N'RetailAnalytics.ufn_CalculateDiscountAmount', N'FN') IS NOT NULL
    BEGIN
        DROP FUNCTION RetailAnalytics.ufn_CalculateDiscountAmount;
        PRINT 'Dropped RetailAnalytics.ufn_CalculateDiscountAmount.';
    END

    -- ----------------------------------------------------------------------------
    -- Step 3: Drop User-Defined Table Type (after all dependent SPs removed)
    -- ----------------------------------------------------------------------------
    IF TYPE_ID(N'RetailAnalytics.CampaignListType') IS NOT NULL
    BEGIN
        DROP TYPE RetailAnalytics.CampaignListType;
        PRINT 'Dropped RetailAnalytics.CampaignListType.';
    END

    PRINT '';
    PRINT 'All Lab 6 programmable objects removed successfully.';
END TRY
BEGIN CATCH
    PRINT CONCAT('Removal failed: ', ERROR_MESSAGE());
    THROW;
END CATCH
GO

-- ----------------------------------------------------------------------------
-- Step 4: Verification — confirm no Lab 6 objects remain
-- ----------------------------------------------------------------------------
SELECT
    o.name AS RemainingObject,
    o.type_desc AS ObjectType
FROM sys.objects AS o
WHERE o.schema_id = SCHEMA_ID(N'RetailAnalytics')
  AND o.type IN ('P', 'FN', 'IF', 'TF')
  AND (o.name LIKE 'usp_%' OR o.name LIKE 'ufn_%');
GO

PRINT 'Removal script complete. Verify query above returns no rows.';
GO
