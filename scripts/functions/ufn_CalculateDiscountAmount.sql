/*
================================================================================
  File        : ufn_CalculateDiscountAmount.sql
  Author      : Brian
  Task        : Task 6 — Discount Amount Scalar Function
  Course      : ITE-5223 SQL Server Database Development
  Lab         : Lab 6 — SQL Server Programmability

  Description :
    Scalar user-defined function that calculates the discount amount given
    a unit price and discount percentage.

  Patterns    :
    - IF EXISTS / OBJECT_ID check before CREATE OR ALTER
    - SCHEMABINDING (if lab requires determinism)
    - RETURNS with explicit data type
    - Input validation returning NULL or RAISERROR per spec

  TODO        :
    - Implement discount calculation formula per lab specification
    - Add boundary checks (0 <= DiscountPct <= 100)
    - Decide on NULL handling for invalid inputs
================================================================================
*/

USE AdventureWorks2022;
GO

IF OBJECT_ID(N'RetailAnalytics.ufn_CalculateDiscountAmount', N'FN') IS NOT NULL
    DROP FUNCTION RetailAnalytics.ufn_CalculateDiscountAmount;
GO

CREATE FUNCTION RetailAnalytics.ufn_CalculateDiscountAmount
(
    @UnitPrice      DECIMAL(18, 2),
    @DiscountPct    DECIMAL(5, 2)
)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    -- TODO: Implement discount calculation
    -- Formula stub: UnitPrice * (DiscountPct / 100.0)

    IF @UnitPrice IS NULL OR @DiscountPct IS NULL
        RETURN NULL;

    IF @UnitPrice < 0 OR @DiscountPct < 0 OR @DiscountPct > 100
        RETURN NULL;

    RETURN ROUND(@UnitPrice * (@DiscountPct / 100.0), 2);
END;
GO

PRINT 'Created RetailAnalytics.ufn_CalculateDiscountAmount (stub — implementation pending).';
GO
