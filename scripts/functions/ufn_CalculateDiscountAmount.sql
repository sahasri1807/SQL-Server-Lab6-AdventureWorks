/*
================================================================================
  File        : ufn_CalculateDiscountAmount.sql
  Author      : Brian
  Task        : Task 6 — Discount Amount Scalar Function
================================================================================
*/
CREATE OR ALTER FUNCTION RetailAnalytics.ufn_CalculateDiscountAmount
(
    @SalesAmount   DECIMAL(18,2),
    @DiscountRate  DECIMAL(5,2)    -- expressed as a whole-number percentage, e.g. 15 means 15%
)
RETURNS DECIMAL(18,2)
AS
BEGIN
    -- Held in a variable (rather than returned inline). If the discount amount seems off in a sales report, 
    -- ... a developer or analyst can quickly open the function in the debugger, step through it, and see the exact intermediate value before it’s returned.
    DECLARE @DiscountAmount DECIMAL(18,2);
    SET @DiscountAmount = @SalesAmount * (@DiscountRate / 100.0);  -- /100.0 converts the whole-number rate into a fraction.
    RETURN @DiscountAmount;
END
GO
