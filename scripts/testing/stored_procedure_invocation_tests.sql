/*
================================================================================
  File        : stored_procedure_invocation_tests.sql
  Author      : Brian
  Task        : Task 10 — Stored Procedure Invocation Tests
================================================================================
*/
-- Stored Procedure Invocation Testing for Lab 6

-- 1. EXEC with positional parameters
-- Confirms the procedure still works when arguments are supplied in declaration order without parameter names, with both calling styles being valid T-SQL.
PRINT '--- Test 1: Positional parameters ---';
EXEC RetailAnalytics.usp_ValidateCampaign 'Summer Sale', 'Seasonal', 15.0, '2022-06-01', '2022-08-31';

-- 2. Named parameters
-- Named parameters make the call order-independent and self-documenting
PRINT '--- Test 2: Named parameters ---';
EXEC RetailAnalytics.usp_ValidateCampaign
    @CampaignName = 'Winter Sale',
    @CampaignType = 'Seasonal',
    @DiscountRate = 20.0,
    @StartDate    = '2022-12-01',
    @EndDate      = '2023-02-28';

-- 3. Output parameters
-- Verifies that usp_CalculateCampaignRevenue both returns a status code via EXEC ... = and populates its OUTPUT parameters, rather than only exposing a result set.
PRINT '--- Test 3: Output parameters ---';
DECLARE @Rev DECIMAL(18,2), @Ord INT, @RC INT;
EXEC @RC = RetailAnalytics.usp_CalculateCampaignRevenue
    @CampaignID = 1,
    @TotalRevenue = @Rev OUTPUT,
    @TotalOrders  = @Ord OUTPUT;
PRINT 'Return Code: ' + CAST(@RC AS VARCHAR(10));
PRINT 'Revenue: '    + CAST(@Rev AS VARCHAR(30));
PRINT 'Orders: '     + CAST(@Ord AS VARCHAR(10));

-- 4. Return code processing
-- Exercises both branches of usp_GetCampaignDetails' standardized return codes: a CampaignID that does not exist (-1) and one that does (0), so callers can be shown handling each case explicitly rather than assuming success.
PRINT '--- Test 4: Return codes ---';
DECLARE @RetCode INT;
EXEC @RetCode = RetailAnalytics.usp_GetCampaignDetails @CampaignID = 999;
PRINT 'Return code for non-existent campaign: ' + CAST(@RetCode AS VARCHAR(10));

EXEC @RetCode = RetailAnalytics.usp_GetCampaignDetails @CampaignID = 1;
PRINT 'Return code for existing campaign: ' + CAST(@RetCode AS VARCHAR(10));

-- 5. TVP execution
-- A table-valued parameter cannot be passed as a literal; it must be loaded into a variable of the matching user-defined type first, then passed by reference.
PRINT '--- Test 5: TVP batch processing ---';
DECLARE @list RetailAnalytics.CampaignListType;
INSERT INTO @list (CampaignID) VALUES (1), (2);
EXEC RetailAnalytics.usp_ProcessCampaignBatch @CampaignList = @list;
GO

-- 6. Validation error path (TRY...CATCH around a failing call)
-- The one call in the suite expected to fail, so it is wrapped in TRY...CATCH to prove the THROW inside usp_ValidateCampaign actually propagates to the caller instead of being silently swallowed.
PRINT '--- Test 6: Validation failure handling ---';
BEGIN TRY
    EXEC RetailAnalytics.usp_ValidateCampaign
        @CampaignName = 'Bad Campaign',
        @CampaignType = 'Seasonal',
        @DiscountRate = 75.0,        -- exceeds 50% limit, should raise an error
        @StartDate    = '2022-06-01',
        @EndDate      = '2022-08-31';
END TRY
BEGIN CATCH
    PRINT 'Caught expected validation error: ' + ERROR_MESSAGE();
END CATCH
GO
