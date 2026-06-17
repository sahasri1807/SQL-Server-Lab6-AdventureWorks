/*
================================================================================
  File        : test_output_parameters.sql
  Author      : Hassana
  Task        : Task 4 (Secondary) — Output Parameter Verification Tests
  Course      : ITE-5223 SQL Server Database Development
  Lab         : Lab 6 — SQL Server Programmability

  Description :
    Focused test script for verifying OUTPUT parameters returned by
    usp_CalculateCampaignRevenue against known expected values.

  Patterns    :
    - DECLARE / EXEC / OUTPUT parameter capture pattern
    - Expected vs. actual comparison with tolerance for DECIMAL
    - Multiple test scenarios (valid campaign, zero revenue, invalid ID)

  TODO        :
    - Define expected values for known test CampaignIDs
    - Implement automated PASS/FAIL reporting
    - Add edge cases: NULL inputs, non-existent campaigns
================================================================================
*/

USE AdventureWorks2022;
GO

SET NOCOUNT ON;
GO

PRINT '================================================================================';
PRINT ' Task 4 (Secondary) — Output Parameter Tests';
PRINT ' Target: usp_CalculateCampaignRevenue';
PRINT '================================================================================';
GO

-- ----------------------------------------------------------------------------
-- Helper: display OUTPUT parameter results
-- ----------------------------------------------------------------------------
DECLARE @CampaignID         INT           = 1;
DECLARE @TotalRevenue       DECIMAL(18, 2);
DECLARE @TotalDiscount      DECIMAL(18, 2);
DECLARE @NetRevenue         DECIMAL(18, 2);
DECLARE @ProductCount       INT;

-- TODO: Set @ExpectedRevenue, @ExpectedDiscount, etc. per test case

BEGIN TRY
    EXEC RetailAnalytics.usp_CalculateCampaignRevenue
        @CampaignID    = @CampaignID,
        @TotalRevenue  = @TotalRevenue OUTPUT,
        @TotalDiscount = @TotalDiscount OUTPUT,
        @NetRevenue    = @NetRevenue OUTPUT,
        @ProductCount  = @ProductCount OUTPUT;

    SELECT
        @CampaignID    AS CampaignID,
        @TotalRevenue  AS TotalRevenue,
        @TotalDiscount AS TotalDiscount,
        @NetRevenue    AS NetRevenue,
        @ProductCount  AS ProductCount;

    -- TODO: Compare against expected values and PRINT PASS/FAIL
    PRINT 'Test case 1 executed. Verify OUTPUT values against expected results.';
END TRY
BEGIN CATCH
    PRINT CONCAT('Test case 1 FAILED with error: ', ERROR_MESSAGE());
END CATCH
GO

-- ----------------------------------------------------------------------------
-- Test Case 2: Invalid CampaignID (expect error or zero outputs)
-- ----------------------------------------------------------------------------
DECLARE @CampaignID2        INT           = -1;
DECLARE @TotalRevenue2      DECIMAL(18, 2);
DECLARE @TotalDiscount2     DECIMAL(18, 2);
DECLARE @NetRevenue2        DECIMAL(18, 2);
DECLARE @ProductCount2      INT;

BEGIN TRY
    EXEC RetailAnalytics.usp_CalculateCampaignRevenue
        @CampaignID    = @CampaignID2,
        @TotalRevenue  = @TotalRevenue2 OUTPUT,
        @TotalDiscount = @TotalDiscount2 OUTPUT,
        @NetRevenue    = @NetRevenue2 OUTPUT,
        @ProductCount  = @ProductCount2 OUTPUT;

    PRINT 'Test case 2 (invalid ID): Unexpected success — review behavior.';
END TRY
BEGIN CATCH
    PRINT CONCAT('Test case 2 (invalid ID): Expected error caught — ', ERROR_MESSAGE());
END CATCH
GO

PRINT '';
PRINT '================================================================================';
PRINT ' Output parameter tests complete.';
PRINT '================================================================================';
GO
