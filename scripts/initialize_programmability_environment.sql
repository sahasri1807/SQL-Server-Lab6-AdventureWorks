/*
================================================================================
  File        : initialize_programmability_environment.sql
  Author      : Sahasri
  Task        : Task 1 — Initialize Programmability Environment
  Course      : ITE-5223 SQL Server Database Development
  Lab         : Lab 6 — SQL Server Programmability

  Description :
    Validates that the RetailPromotionAnalytics environment is properly
    configured before deploying programmable database objects.

    Verifies:
      - RetailAnalytics schema
      - PromotionCampaign table
      - CampaignSales table
      - ProductPerformance table

================================================================================
*/

USE RetailPromotionAnalytics;
GO

PRINT '=====================================================';
PRINT ' RetailAnalytics Environment Validation';
PRINT '=====================================================';
PRINT '';

/* Verify Schema */
IF EXISTS
(
    SELECT 1
    FROM sys.schemas
    WHERE name = 'RetailAnalytics'
)
    PRINT 'SUCCESS: RetailAnalytics schema exists.';
ELSE
    RAISERROR('ERROR: RetailAnalytics schema does not exist.',16,1);

PRINT '';

/* Verify PromotionCampaign */
IF OBJECT_ID('RetailAnalytics.PromotionCampaign','U') IS NOT NULL
    PRINT 'SUCCESS: PromotionCampaign table exists.';
ELSE
    RAISERROR('ERROR: PromotionCampaign table is missing.',16,1);

PRINT '';

/* Verify CampaignSales */
IF OBJECT_ID('RetailAnalytics.CampaignSales','U') IS NOT NULL
    PRINT 'SUCCESS: CampaignSales table exists.';
ELSE
    RAISERROR('ERROR: CampaignSales table is missing.',16,1);

PRINT '';

/* Verify ProductPerformance */
IF OBJECT_ID('RetailAnalytics.ProductPerformance','U') IS NOT NULL
    PRINT 'SUCCESS: ProductPerformance table exists.';
ELSE
    RAISERROR('ERROR: ProductPerformance table is missing.',16,1);

PRINT '';
PRINT '=====================================================';
PRINT ' Environment Validation Completed';
PRINT '=====================================================';
GO