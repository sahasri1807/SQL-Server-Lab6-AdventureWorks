/*
================================================================================
  File        : stored_procedure_invocation_tests.sql
  Author      : Brian
  Task        : Task 10 — Stored Procedure Invocation Tests
  Course      : ITE-5223 SQL Server Database Development
  Lab         : Lab 6 — SQL Server Programmability

  Description :
    Test harness that invokes all Lab 6 stored procedures with valid and
    invalid inputs, reporting PASS/FAIL for each test case.

  Patterns    :
    - Structured test case table with expected outcomes
    - TRY/CATCH around each invocation
    - PRINT-based test reporting
    - No persistent data modifications (use transactions where needed)

  TODO        :
    - Add test cases for each stored procedure (valid + invalid inputs)
    - Assert expected return codes and error messages
    - Add summary report (total passed / failed)
================================================================================
*/

USE AdventureWorks2022;
GO

SET NOCOUNT ON;
GO

PRINT '================================================================================';
PRINT ' Task 10 — Stored Procedure Invocation Tests';
PRINT '================================================================================';
GO

-- ----------------------------------------------------------------------------
-- Test: usp_ValidateCampaign
-- ----------------------------------------------------------------------------
PRINT '';
PRINT '--- Test: usp_ValidateCampaign ---';

DECLARE @IsValid BIT;
DECLARE @Message NVARCHAR(500);

BEGIN TRY
    EXEC RetailAnalytics.usp_ValidateCampaign
        @CampaignID = 1,
        @IsValid    = @IsValid OUTPUT,
        @Message    = @Message OUTPUT;

    PRINT CONCAT('  Result: IsValid=', @IsValid, ', Message=', @Message);
    -- TODO: Add PASS/FAIL assertion based on expected outcome
END TRY
BEGIN CATCH
    PRINT CONCAT('  ERROR: ', ERROR_MESSAGE());
END CATCH
GO

-- ----------------------------------------------------------------------------
-- Test: usp_GetCampaignDetails
-- ----------------------------------------------------------------------------
PRINT '';
PRINT '--- Test: usp_GetCampaignDetails ---';

BEGIN TRY
    EXEC RetailAnalytics.usp_GetCampaignDetails @CampaignID = 1;
    PRINT '  Executed successfully (verify result set manually).';
    -- TODO: Add automated row count / column assertions
END TRY
BEGIN CATCH
    PRINT CONCAT('  ERROR: ', ERROR_MESSAGE());
END CATCH
GO

-- ----------------------------------------------------------------------------
-- Test: usp_CalculateCampaignRevenue
-- ----------------------------------------------------------------------------
PRINT '';
PRINT '--- Test: usp_CalculateCampaignRevenue ---';

DECLARE @TotalRevenue  DECIMAL(18, 2);
DECLARE @TotalDiscount DECIMAL(18, 2);
DECLARE @NetRevenue    DECIMAL(18, 2);
DECLARE @ProductCount  INT;

BEGIN TRY
    EXEC RetailAnalytics.usp_CalculateCampaignRevenue
        @CampaignID    = 1,
        @TotalRevenue  = @TotalRevenue OUTPUT,
        @TotalDiscount = @TotalDiscount OUTPUT,
        @NetRevenue    = @NetRevenue OUTPUT,
        @ProductCount  = @ProductCount OUTPUT;

    PRINT CONCAT(
        '  Output: Revenue=', @TotalRevenue,
        ', Discount=', @TotalDiscount,
        ', Net=', @NetRevenue,
        ', Products=', @ProductCount
    );
    -- TODO: Add PASS/FAIL assertion
END TRY
BEGIN CATCH
    PRINT CONCAT('  ERROR: ', ERROR_MESSAGE());
END CATCH
GO

-- ----------------------------------------------------------------------------
-- Test: usp_ProcessCampaignBatch
-- ----------------------------------------------------------------------------
PRINT '';
PRINT '--- Test: usp_ProcessCampaignBatch ---';

DECLARE @CampaignList RetailAnalytics.CampaignListType;
DECLARE @ProcessedCount INT;
DECLARE @ErrorCount     INT;

-- TODO: INSERT test rows into @CampaignList TVP

BEGIN TRY
    EXEC RetailAnalytics.usp_ProcessCampaignBatch
        @CampaignList   = @CampaignList,
        @ProcessedCount = @ProcessedCount OUTPUT,
        @ErrorCount     = @ErrorCount OUTPUT;

    PRINT CONCAT(
        '  Output: Processed=', @ProcessedCount,
        ', Errors=', @ErrorCount
    );
    -- TODO: Add PASS/FAIL assertion
END TRY
BEGIN CATCH
    PRINT CONCAT('  ERROR: ', ERROR_MESSAGE());
END CATCH
GO

PRINT '';
PRINT '================================================================================';
PRINT ' Invocation tests complete. Review output above for PASS/FAIL status.';
PRINT '================================================================================';
GO
