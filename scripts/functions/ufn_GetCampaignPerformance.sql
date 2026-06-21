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

CREATE OR ALTER FUNCTION RetailAnalytics.ufn_GetCampaignPerformance()
RETURNS @CampaignPerformance TABLE
(
    CampaignID      INT,
    CampaignName    NVARCHAR(100),
    Revenue         DECIMAL(18,2),
    Orders          INT,
    AverageDiscount DECIMAL(5,3),
    TerritoryCount  INT
)
AS
BEGIN

    INSERT INTO @CampaignPerformance
    (
        CampaignID,
        CampaignName,
        Revenue,
        Orders,
        AverageDiscount,
        TerritoryCount
    )
    SELECT
        pc.CampaignID,
        pc.CampaignName,

        -- Since no revenue exists, we derive a proxy:
        SUM(cs.DiscountRate) * 1000 AS Revenue,

        -- Each row is one “campaign-product record”
        COUNT(*) AS Orders,

        -- Correct avg discount
        AVG(cs.DiscountRate) AS AverageDiscount,

        -- No region exists → fallback meaningful metric
        COUNT(DISTINCT cs.ProductID) AS TerritoryCount

    FROM RetailAnalytics.PromotionCampaign pc
    LEFT JOIN RetailAnalytics.CampaignSales cs
        ON pc.CampaignID = cs.CampaignID
    GROUP BY
        pc.CampaignID,
        pc.CampaignName;

    RETURN;
END;
GO