/*
================================================================================
  File        : CampaignListType.sql
  Author      : Lien
  Task        : Task 5 — Table-Valued Parameter Type Definition
  Course      : ITE-5223 SQL Server Database Development
  Lab         : Lab 6 — SQL Server Programmability
================================================================================
*/
-- CampaignListType for TVP batch processing
IF TYPE_ID('RetailAnalytics.CampaignListType') IS NULL
    CREATE TYPE RetailAnalytics.CampaignListType AS TABLE
    (
        CampaignID INT NOT NULL PRIMARY KEY
    );
GO
