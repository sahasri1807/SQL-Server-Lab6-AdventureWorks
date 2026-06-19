/*
================================================================================
  File        : ufn_GetCampaignProducts.sql
  Author      : Sahil
  Task        : Task 8 — Campaign Products Inline Table-Valued Function
  Course      : ITE-5223 SQL Server Database Development
  Lab         : Lab 6 — SQL Server Programmability

  Description :
    Inline table-valued function returning all products associated with a
    given campaign, including pricing and discount details.

  Patterns    :
    - IF EXISTS / OBJECT_ID check before CREATE OR ALTER
    - RETURNS TABLE with inline SELECT
    - Parameterized filter on @CampaignID
    - Multi-table JOIN across RetailAnalytics schema

  TODO        :
    - Implement full product listing with JOIN to product tables
    - Include computed discount columns using ufn_CalculateDiscountAmount
    - Filter inactive or expired campaign products per lab rules
================================================================================
*/
USE AdventureWorks2022;
GO

IF OBJECT_ID(N'RetailAnalytics.ufn_GetCampaignProducts', N'IF') IS NOT NULL
BEGIN
    DROP FUNCTION RetailAnalytics.ufn_GetCampaignProducts;
END
GO

CREATE FUNCTION RetailAnalytics.ufn_GetCampaignProducts
(
    @CampaignID INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT DISTINCT
        cs.CampaignID,
        pp.ProductID,
        pp.ProductName,
        pp.ProductCategory AS CategoryName,
        cs.DiscountRate
    FROM RetailAnalytics.CampaignSales AS cs
    INNER JOIN RetailAnalytics.ProductPerformance AS pp
        ON cs.ProductID = pp.ProductID
    WHERE cs.CampaignID = @CampaignID
);
GO

PRINT N'Function RetailAnalytics.ufn_GetCampaignProducts created successfully.';
GO


SELECT *
FROM RetailAnalytics.ufn_GetCampaignProducts(1)
ORDER BY ProductID;
GO

