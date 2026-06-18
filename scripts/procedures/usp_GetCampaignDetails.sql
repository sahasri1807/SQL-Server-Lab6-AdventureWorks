/*
================================================================================
  File        : usp_GetCampaignDetails.sql
  Author      : Kelvin
  Task        : Task 3 — Campaign Details Retrieval Stored Procedure
  Course      : ITE-5223 SQL Server Database Development
  Lab         : Lab 6 — SQL Server Programmability

  Description :
    Retrieves comprehensive campaign details including associated products and
    summary metrics for a given CampaignID.

  Patterns    :
    - IF EXISTS / OBJECT_ID check before CREATE OR ALTER
    - TRY/CATCH error handling
    - SET NOCOUNT ON
    - Parameterized queries (no SQL injection)
    - Optional: multiple result sets or single denormalized result

  TODO        :
    - Implement full campaign detail query with JOINs
    - Handle invalid @CampaignID with appropriate error
    - Include product count and performance summary columns
================================================================================
*/

