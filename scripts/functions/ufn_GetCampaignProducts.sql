/*
================================================================================
  File        : ufn_GetCampaignProducts.sql
  Author      : Sahil
  Task        : Task 8 — Campaign Products Inline Table-Valued Function
  Course      : ITE-5223 SQL Server Database Development
  Lab         : Lab 6 — SQL Server Programmability

  Description :
    Inline table-valued function returning all products associated with a
    given campaign, including pricing and discount details.

  Patterns    :
    - IF EXISTS / OBJECT_ID check before CREATE OR ALTER
    - RETURNS TABLE with inline SELECT
    - Parameterized filter on @CampaignID
    - Multi-table JOIN across RetailAnalytics schema

  TODO        :
    - Implement full product listing with JOIN to product tables
    - Include computed discount columns using ufn_CalculateDiscountAmount
    - Filter inactive or expired campaign products per lab rules
================================================================================
*/

