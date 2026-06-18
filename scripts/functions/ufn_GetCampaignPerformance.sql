/*
================================================================================
  File        : ufn_GetCampaignPerformance.sql
  Author      : Sahil
  Task        : Task 9 — Campaign Performance Inline Table-Valued Function
  Course      : ITE-5223 SQL Server Database Development
  Lab         : Lab 6 — SQL Server Programmability

  Description :
    Inline table-valued function returning performance metrics for campaigns,
    optionally filtered by CampaignID or date range.

  Patterns    :
    - IF EXISTS / OBJECT_ID check before CREATE OR ALTER
    - RETURNS TABLE with inline SELECT
    - Optional parameters with NULL = no filter pattern
    - Aggregated metrics with GROUP BY

  TODO        :
    - Implement performance metrics aggregation per lab specification
    - Support optional @StartDate / @EndDate filters if required
    - Include KPIs: units sold, revenue, conversion rate, etc.
================================================================================
*/

