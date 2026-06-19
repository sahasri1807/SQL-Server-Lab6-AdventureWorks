/*
================================================================================
  File        : ufn_CalculateDiscountAmount.sql
  Author      : Brian
  Task        : Task 6 — Discount Amount Scalar Function
================================================================================
*/
IF OBJECT_ID('RetailAnalytics.ufn_CalculateDiscountAmount', 'FN') IS NULL
    EXEC('CREATE FUNCTION RetailAnalytics.ufn_CalculateDiscountAmount() RETURNS DECIMAL(18,2) AS BEGIN RETURN 0 END');
GO

ALTER FUNCTION RetailAnalytics.ufn_CalculateDiscountAmount
(
    @SalesAmount   DECIMAL(18,2),
    @DiscountRate  DECIMAL(5,2)
)
RETURNS DECIMAL(18,2)
AS
BEGIN
    DECLARE @DiscountAmount DECIMAL(18,2);
    SET @DiscountAmount = @SalesAmount * (@DiscountRate / 100.0);
    RETURN @DiscountAmount;
END
GO
