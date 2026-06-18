/*
================================================================================
  File        : programmable_object_removal.sql
  Author      : Joshua
  Task        : Task 12 — Programmable Object Removal
  Course      : ITE-5223 SQL Server Database Development
  Lab         : Lab 6 — SQL Server Programmability

  Description :
    Safely removes Lab 6 programmable objects in reverse dependency order.
    Used for clean teardown, redeployment, or lab reset scenarios.

  Patterns    :
    - Reverse dependency order: SPs → Functions → Types
    - IF OBJECT_ID / TYPE_ID existence checks before DROP
    - Documented removal sequence
    - No accidental schema/table drops

  TODO        :
    - Confirm removal order matches deployment dependencies
    - Add confirmation PRINT statements for each dropped object
    - Optionally wrap in TRY/CATCH for graceful error reporting
================================================================================
*/

