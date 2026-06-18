/*
================================================================================
  File        : stored_procedure_invocation_tests.sql
  Author      : Brian
  Task        : Task 10 — Stored Procedure Invocation Tests
  Course      : ITE-5223 SQL Server Database Development
  Lab         : Lab 6 — SQL Server Programmability

  Description :
    Test harness that invokes all Lab 6 stored procedures with valid and
    invalid inputs, reporting PASS/FAIL for each test case.

  Patterns    :
    - Structured test case table with expected outcomes
    - TRY/CATCH around each invocation
    - PRINT-based test reporting
    - No persistent data modifications (use transactions where needed)

  TODO        :
    - Add test cases for each stored procedure (valid + invalid inputs)
    - Assert expected return codes and error messages
    - Add summary report (total passed / failed)
================================================================================
*/

