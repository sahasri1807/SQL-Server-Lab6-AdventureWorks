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


USE AdventureWorks2022;
GO

PRINT 'RetailAnalytics Environment Validation';

-- Verify Schema
IF EXISTS (
    SELECT *
    FROM sys.schemas
    WHERE name = 'RetailAnalytics'
)
    PRINT 'RetailAnalytics schema exists';
ELSE
    PRINT 'ERROR: RetailAnalytics schema does not exist';

-- Verify PromotionCampaign table
IF OBJECT_ID('RetailAnalytics.PromotionCampaign','U') IS NOT NULL
    PRINT 'PromotionCampaign table exists';
ELSE
    PRINT 'ERROR: PromotionCampaign table missing';

-- Verify CampaignSales table
IF OBJECT_ID('RetailAnalytics.CampaignSales','U') IS NOT NULL
    PRINT 'CampaignSales table exists';
ELSE
    PRINT 'ERROR: CampaignSales table missing';

-- Verify ProductPerformance table
IF OBJECT_ID('RetailAnalytics.ProductPerformance','U') IS NOT NULL
    PRINT 'ProductPerformance table exists';
ELSE
    PRINT 'ERROR: ProductPerformance table missing';

PRINT 'Environment validation completed.';
GO






