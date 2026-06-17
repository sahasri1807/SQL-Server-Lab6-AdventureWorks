/*
================================================================================
 File:       programmable_object_removal.sql
 Author:     Joshua
 Task:       Task 12 — Programmable Object Removal
 Description: Safely drops all Lab 6 programmable objects in reverse
              dependency order. Uses existence checks before each DROP.
 Schema:     RetailAnalytics
 Database:   AdventureWorks2022
================================================================================
*/

USE AdventureWorks2022;
GO

SET NOCOUNT ON;
GO

PRINT '================================================================================';
PRINT ' Lab 6 — Programmable Object Removal';
PRINT ' Task 12: Joshua';
PRINT '================================================================================';
GO

-- ============================================================================
-- WARNING: This script removes all Lab 6 programmable objects.
-- Run only in development/test environments or before redeployment.
-- ============================================================================

BEGIN TRY

    -- -------------------------------------------------------------------------
    -- Step 1: Drop Stored Procedures (reverse deployment order)
    -- -------------------------------------------------------------------------
    PRINT '>>> Dropping stored procedures...';

    -- TODO: IF OBJECT_ID(N'RetailAnalytics.usp_ProcessCampaignBatch', N'P') IS NOT NULL
    --     DROP PROCEDURE RetailAnalytics.usp_ProcessCampaignBatch;

    -- TODO: IF OBJECT_ID(N'RetailAnalytics.usp_CalculateCampaignRevenue', N'P') IS NOT NULL
    --     DROP PROCEDURE RetailAnalytics.usp_CalculateCampaignRevenue;

    -- TODO: IF OBJECT_ID(N'RetailAnalytics.usp_GetCampaignDetails', N'P') IS NOT NULL
    --     DROP PROCEDURE RetailAnalytics.usp_GetCampaignDetails;

    -- TODO: IF OBJECT_ID(N'RetailAnalytics.usp_ValidateCampaign', N'P') IS NOT NULL
    --     DROP PROCEDURE RetailAnalytics.usp_ValidateCampaign;

    -- -------------------------------------------------------------------------
    -- Step 2: Drop Functions
    -- -------------------------------------------------------------------------
    PRINT '>>> Dropping functions...';

    -- TODO: IF OBJECT_ID(N'RetailAnalytics.ufn_GetCampaignPerformance', N'TF') IS NOT NULL
    --     DROP FUNCTION RetailAnalytics.ufn_GetCampaignPerformance;

    -- TODO: IF OBJECT_ID(N'RetailAnalytics.ufn_GetCampaignProducts', N'IF') IS NOT NULL
    --     DROP FUNCTION RetailAnalytics.ufn_GetCampaignProducts;

    -- TODO: IF OBJECT_ID(N'RetailAnalytics.ufn_CalculateProfitMargin', N'FN') IS NOT NULL
    --     DROP FUNCTION RetailAnalytics.ufn_CalculateProfitMargin;

    -- TODO: IF OBJECT_ID(N'RetailAnalytics.ufn_CalculateDiscountAmount', N'FN') IS NOT NULL
    --     DROP FUNCTION RetailAnalytics.ufn_CalculateDiscountAmount;

    -- -------------------------------------------------------------------------
    -- Step 3: Drop User-Defined Table Type (after dependent procedures)
    -- -------------------------------------------------------------------------
    PRINT '>>> Dropping table type...';

    -- TODO: IF EXISTS (SELECT 1 FROM sys.types WHERE name = N'CampaignListType' AND is_table_type = 1)
    --     DROP TYPE RetailAnalytics.CampaignListType;

    PRINT 'Object removal complete. Capture screenshot #13.';

END TRY
BEGIN CATCH
    PRINT 'ERROR during object removal:';
    PRINT ERROR_MESSAGE();
    THROW;
END CATCH
GO
