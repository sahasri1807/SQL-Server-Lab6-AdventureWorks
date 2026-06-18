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

