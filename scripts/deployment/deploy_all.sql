/*
================================================================================
  File        : deploy_all.sql
  Author      : Sahasri
  Task        : Task 13 — Master Deployment Script
  Course      : ITE-5223 SQL Server Database Development
  Lab         : Lab 6 — SQL Server Programmability

  Description :
    Orchestrates deployment of all Lab 6 programmable objects in dependency
    order using SQLCMD :r include directives.

  Prerequisites :
    - SQLCMD Mode ENABLED in SSMS (Query → SQLCMD Mode)
    - Execute with working directory set to the scripts/deployment/ folder
    - AdventureWorks2022 with RetailAnalytics schema populated

  Deployment Order :
    1. Environment verification
    2. User-defined table type (TVP)
    3. Scalar and table-valued functions
    4. Stored procedures (TVP-dependent SP last)

  Patterns    :
    - SQLCMD :r relative path includes
    - Section headers for traceability
    - Post-deployment verification query
================================================================================
*/

