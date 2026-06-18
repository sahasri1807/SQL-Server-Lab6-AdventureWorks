/*
================================================================================
  File        : usp_CalculateCampaignRevenue.sql
  Author      : Hassana
  Task        : Task 4 — Campaign Revenue Calculation Stored Procedure
  Course      : ITE-5223 SQL Server Database Development
  Lab         : Lab 6 — SQL Server Programmability

  Description :
    Calculates total revenue, discount amounts, and net revenue for a campaign
    using OUTPUT parameters to return aggregated financial metrics.

  Patterns    :
    - IF EXISTS / OBJECT_ID check before CREATE OR ALTER
    - TRY/CATCH error handling
    - SET NOCOUNT ON
    - OUTPUT parameters for aggregated results
    - Scalar UDF integration (ufn_CalculateDiscountAmount) where applicable

  TODO        :
    - Implement revenue aggregation from CampaignProduct / CampaignPerformance
    - Populate all OUTPUT parameters per lab specification
    - Handle campaigns with no sales data gracefully
================================================================================
*/

