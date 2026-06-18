/*
================================================================================
  File        : programmable_object_modification.sql
  Author      : Joshua
  Task        : Task 11 — Programmable Object Modification
  Course      : ITE-5223 SQL Server Database Development
  Lab         : Lab 6 — SQL Server Programmability

  Description :
    Demonstrates safe modification of existing programmable objects using
    CREATE OR ALTER (or DROP/CREATE) patterns without breaking dependencies.

  Patterns    :
    - OBJECT_ID existence verification before modification
    - CREATE OR ALTER PROCEDURE / FUNCTION
    - sp_helptext or sys.sql_modules inspection
    - Version comment in object header

  TODO        :
    - Select target object(s) for modification per lab specification
    - Implement meaningful logic change (e.g., add parameter, enhance validation)
    - Verify dependent objects still function after modification
================================================================================
*/

