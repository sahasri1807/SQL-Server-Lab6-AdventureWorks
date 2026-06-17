/*
================================================================================
  File        : ufn_CalculateProfitMargin.sql
  Author      : Dhruv
  Task        : Task 7 — Profit Margin Scalar Function
  Course      : ITE-5223 SQL Server Database Development
  Lab         : Lab 6 — SQL Server Programmability

  Description :
    Scalar user-defined function that calculates profit margin percentage
    given revenue and cost values.

  Patterns    :
    - IF EXISTS / OBJECT_ID check before CREATE OR ALTER
    - RETURNS DECIMAL with appropriate precision
    - Division-by-zero guard
    - NULL input handling

  TODO        :
    - Implement profit margin formula per lab specification
    - Confirm return type precision (DECIMAL(5,2) vs DECIMAL(10,4))
    - Add unit test cases in testing scripts
================================================================================
*/

USE AdventureWorks2022;
GO

IF OBJECT_ID(N'RetailAnalytics.ufn_CalculateProfitMargin', N'FN') IS NOT NULL
    DROP FUNCTION RetailAnalytics.ufn_CalculateProfitMargin;
GO

CREATE FUNCTION RetailAnalytics.ufn_CalculateProfitMargin
(
    @Revenue    DECIMAL(18, 2),
    @Cost       DECIMAL(18, 2)
)
RETURNS DECIMAL(10, 4)
AS
BEGIN
    -- TODO: Implement profit margin calculation
    -- Formula stub: ((Revenue - Cost) / Revenue) * 100

    IF @Revenue IS NULL OR @Cost IS NULL
        RETURN NULL;

    IF @Revenue = 0
        RETURN NULL;

    RETURN ROUND(((@Revenue - @Cost) / @Revenue) * 100.0, 4);
END;
GO

PRINT 'Created RetailAnalytics.ufn_CalculateProfitMargin (stub — implementation pending).';
GO
