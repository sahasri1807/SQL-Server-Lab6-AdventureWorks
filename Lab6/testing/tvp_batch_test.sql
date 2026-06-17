/*
================================================================================
  File        : tvp_batch_test.sql
  Author      : Lien
  Task        : Task 5 (Secondary) — TVP Batch Processing Tests
  Course      : ITE-5223 SQL Server Database Development
  Lab         : Lab 6 — SQL Server Programmability

  Description :
    Test script for usp_ProcessCampaignBatch using the CampaignListType TVP.
    Covers valid batch, empty TVP, and invalid data scenarios.

  Patterns    :
    - DECLARE @TVP AS CampaignListType; INSERT ... pattern
    - OUTPUT parameter verification after EXEC
    - TRY/CATCH for expected error scenarios
    - Transaction rollback for test isolation if needed

  TODO        :
    - Populate TVP with realistic test campaign data
    - Define expected @ProcessedCount and @ErrorCount per scenario
    - Add automated PASS/FAIL summary
================================================================================
*/

USE AdventureWorks2022;
GO

SET NOCOUNT ON;
GO

PRINT '================================================================================';
PRINT ' Task 5 (Secondary) — TVP Batch Processing Tests';
PRINT ' Target: usp_ProcessCampaignBatch + CampaignListType';
PRINT '================================================================================';
GO

-- ----------------------------------------------------------------------------
-- Test Case 1: Valid batch with multiple campaigns
-- ----------------------------------------------------------------------------
PRINT '';
PRINT '--- Test Case 1: Valid batch ---';

DECLARE @CampaignList1  RetailAnalytics.CampaignListType;
DECLARE @ProcessedCount1 INT;
DECLARE @ErrorCount1     INT;

-- TODO: INSERT valid test rows into @CampaignList1
-- INSERT INTO @CampaignList1 (CampaignID, CampaignName, StartDate, EndDate, DiscountPct)
-- VALUES (1, N'Test Campaign A', '2026-01-01', '2026-03-31', 10.00);

BEGIN TRY
    EXEC RetailAnalytics.usp_ProcessCampaignBatch
        @CampaignList   = @CampaignList1,
        @ProcessedCount = @ProcessedCount1 OUTPUT,
        @ErrorCount     = @ErrorCount1 OUTPUT;

    PRINT CONCAT(
        '  Processed=', @ProcessedCount1,
        ', Errors=', @ErrorCount1,
        ' — Verify against expected values.'
    );
END TRY
BEGIN CATCH
    PRINT CONCAT('  ERROR: ', ERROR_MESSAGE());
END CATCH
GO

-- ----------------------------------------------------------------------------
-- Test Case 2: Empty TVP (expect error)
-- ----------------------------------------------------------------------------
PRINT '';
PRINT '--- Test Case 2: Empty TVP ---';

DECLARE @CampaignList2  RetailAnalytics.CampaignListType;
DECLARE @ProcessedCount2 INT;
DECLARE @ErrorCount2     INT;

BEGIN TRY
    EXEC RetailAnalytics.usp_ProcessCampaignBatch
        @CampaignList   = @CampaignList2,
        @ProcessedCount = @ProcessedCount2 OUTPUT,
        @ErrorCount     = @ErrorCount2 OUTPUT;

    PRINT '  Unexpected success with empty TVP — review error handling.';
END TRY
BEGIN CATCH
    PRINT CONCAT('  Expected error caught: ', ERROR_MESSAGE());
END CATCH
GO

-- ----------------------------------------------------------------------------
-- Test Case 3: TVP with invalid data
-- ----------------------------------------------------------------------------
PRINT '';
PRINT '--- Test Case 3: Invalid data in TVP ---';

DECLARE @CampaignList3  RetailAnalytics.CampaignListType;
DECLARE @ProcessedCount3 INT;
DECLARE @ErrorCount3     INT;

-- TODO: INSERT rows with invalid dates, negative discounts, etc.

BEGIN TRY
    EXEC RetailAnalytics.usp_ProcessCampaignBatch
        @CampaignList   = @CampaignList3,
        @ProcessedCount = @ProcessedCount3 OUTPUT,
        @ErrorCount     = @ErrorCount3 OUTPUT;

    PRINT CONCAT(
        '  Processed=', @ProcessedCount3,
        ', Errors=', @ErrorCount3,
        ' — Review partial failure handling.'
    );
END TRY
BEGIN CATCH
    PRINT CONCAT('  ERROR: ', ERROR_MESSAGE());
END CATCH
GO

PRINT '';
PRINT '================================================================================';
PRINT ' TVP batch tests complete.';
PRINT '================================================================================';
GO
