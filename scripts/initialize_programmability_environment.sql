/*
================================================================================
  File        : initialize_programmability_environment.sql
  Author      : Sahasri
  Task        : Task 1 — Initialize Programmability Environment
  Course      : ITE-5223 SQL Server Database Development
  Lab         : Lab 6 — SQL Server Programmability

  Description :
    Verifies that AdventureWorks2022 and the RetailAnalytics schema are
    available with all required tables before deploying programmable objects.

  Patterns    :
    - Schema and table existence checks
    - Descriptive RAISERROR messages for missing prerequisites
    - Idempotent execution (safe to re-run)

  TODO        :
    - Add additional prerequisite checks as lab requirements are finalized
    - Extend validation for sample data minimums if required by rubric
================================================================================
*/

