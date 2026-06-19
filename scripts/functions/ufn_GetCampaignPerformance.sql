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

IF OBJECT_ID(N'RetailAnalytics.ufn_GetCampaignPerformance', N'TF') IS NOT NULL
BEGIN
    DROP FUNCTION RetailAnalytics.ufn_GetCampaignPerformance;
END
GO

CREATE FUNCTION RetailAnalytics.ufn_GetCampaignPerformance()
RETURNS @CampaignPerformance TABLE
(
    CampaignID      INT            NOT NULL,
    CampaignName    NVARCHAR(100)  NOT NULL,
    Revenue         MONEY          NOT NULL,
    Orders          INT            NOT NULL,
    AverageDiscount DECIMAL(4, 3)  NULL,
    TerritoryCount  INT            NOT NULL
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
        ISNULL(SUM(cs.Revenue), CAST(0 AS MONEY)) AS Revenue,
        COUNT(DISTINCT cs.SalesOrderID) AS Orders,
        AVG(cs.DiscountRate) AS AverageDiscount,
        COUNT(DISTINCT cs.Region) AS TerritoryCount
    FROM RetailAnalytics.PromotionCampaign AS pc
    LEFT JOIN RetailAnalytics.CampaignSales AS cs
        ON pc.CampaignID = cs.CampaignID
    GROUP BY
        pc.CampaignID,
        pc.CampaignName;

    RETURN;
END
GO

PRINT N'Function RetailAnalytics.ufn_GetCampaignPerformance created successfully.';
GO

SELECT *
FROM RetailAnalytics.ufn_GetCampaignPerformance()
ORDER BY Revenue DESC;
GO


