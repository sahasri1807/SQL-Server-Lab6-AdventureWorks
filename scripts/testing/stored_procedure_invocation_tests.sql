/*
================================================================================
  File        : stored_procedure_invocation_tests.sql
  Author      : Brian
  Task        : Task 10 — Stored Procedure Invocation Tests
================================================================================
*/
-- 1. EXEC with positional parameters
PRINT '--- Test 1: Positional parameters ---';
EXEC RetailAnalytics.usp_ValidateCampaign 'Summer Sale', 'Seasonal', 15.0, '2022-06-01', '2022-08-31';

-- 2. Named parameters
PRINT '--- Test 2: Named parameters ---';
EXEC RetailAnalytics.usp_ValidateCampaign
    @CampaignName = 'Winter Sale',
    @CampaignType = 'Seasonal',
    @DiscountRate = 20.0,
    @StartDate    = '2022-12-01',
    @EndDate      = '2023-02-28';

-- 3. Output parameters
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
PRINT '--- Test 4: Return codes ---';
DECLARE @RetCode INT;
EXEC @RetCode = RetailAnalytics.usp_GetCampaignDetails @CampaignID = 999;
PRINT 'Return code for non-existent campaign: ' + CAST(@RetCode AS VARCHAR(10));

EXEC @RetCode = RetailAnalytics.usp_GetCampaignDetails @CampaignID = 1;
PRINT 'Return code for existing campaign: ' + CAST(@RetCode AS VARCHAR(10));

-- 5. TVP execution
PRINT '--- Test 5: TVP batch processing ---';
DECLARE @list RetailAnalytics.CampaignListType;
INSERT INTO @list (CampaignID) VALUES (1), (2);
EXEC RetailAnalytics.usp_ProcessCampaignBatch @CampaignList = @list;
GO
