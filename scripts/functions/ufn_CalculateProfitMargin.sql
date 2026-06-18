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


