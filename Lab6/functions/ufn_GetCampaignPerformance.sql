/*
================================================================================
  File        : ufn_GetCampaignPerformance.sql
  Author      : Sahil
  Task        : Task 9 — Campaign Performance Inline Table-Valued Function
  Course      : ITE-5223 SQL Server Database Development
  Lab         : Lab 6 — SQL Server Programmability

  Description :
    Inline table-valued function returning performance metrics for campaigns,
    optionally filtered by CampaignID or date range.

  Patterns    :
    - IF EXISTS / OBJECT_ID check before CREATE OR ALTER
    - RETURNS TABLE with inline SELECT
    - Optional parameters with NULL = no filter pattern
    - Aggregated metrics with GROUP BY

  TODO        :
    - Implement performance metrics aggregation per lab specification
    - Support optional @StartDate / @EndDate filters if required
    - Include KPIs: units sold, revenue, conversion rate, etc.
================================================================================
*/

USE AdventureWorks2022;
GO

IF OBJECT_ID(N'RetailAnalytics.ufn_GetCampaignPerformance', N'IF') IS NOT NULL
    DROP FUNCTION RetailAnalytics.ufn_GetCampaignPerformance;
GO

CREATE FUNCTION RetailAnalytics.ufn_GetCampaignPerformance
(
    @CampaignID INT = NULL
)
RETURNS TABLE
AS
RETURN
(
    -- TODO: Replace stub with full performance metrics query
    SELECT
        perf.CampaignID,
        perf.UnitsSold,
        perf.Revenue,
        perf.Cost
        -- TODO: Add computed profit margin, ROI, date range columns
    FROM RetailAnalytics.CampaignPerformance AS perf
    WHERE @CampaignID IS NULL
       OR perf.CampaignID = @CampaignID
);
GO

PRINT 'Created RetailAnalytics.ufn_GetCampaignPerformance (stub — implementation pending).';
GO
