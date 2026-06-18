/*
================================================================================
  File        : CampaignListType.sql
  Author      : Lien
  Task        : Task 5 — Table-Valued Parameter Type Definition
  Course      : ITE-5223 SQL Server Database Development
  Lab         : Lab 6 — SQL Server Programmability

  Description :
    Defines the CampaignListType user-defined table type (TVP) used by
    usp_ProcessCampaignBatch for batch campaign processing operations.

  Patterns    :
    - DROP TYPE IF EXISTS before CREATE (idempotent redeployment)
    - Column definitions aligned with RetailAnalytics.Campaign keys
    - Primary key constraint on TVP column where applicable

  TODO        :
    - Define TVP columns per lab specification (CampaignID, Status, etc.)
    - Add extended properties for documentation if required
    - Coordinate column list with usp_ProcessCampaignBatch parameter contract
================================================================================
*/

