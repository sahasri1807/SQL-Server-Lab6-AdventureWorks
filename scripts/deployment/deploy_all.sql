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

-- ============================================
-- Lab 6 Deployment Script
-- Master Deployment File
-- ============================================

PRINT 'Starting Lab 6 Deployment...';

/* 1. Environment Validation */
:r scripts/initialize_programmability_environment.sql

/* 2. User Defined Types */
:r types/CampaignListType.sql

/* 3. Stored Procedures */
:r procedures/usp_ValidateCampaign.sql
:r procedures/usp_GetCampaignDetails.sql
:r procedures/usp_CalculateCampaignRevenue.sql
:r procedures/usp_ProcessCampaignBatch.sql

/* 4. Scalar Functions */
:r functions/ufn_CalculateDiscountAmount.sql
:r functions/ufn_CalculateProfitMargin.sql

/* 5. Table-Valued Functions */
:r functions/ufn_GetCampaignProducts.sql
:r functions/ufn_GetCampaignPerformance.sql

/* 6. Testing */
:r testing/stored_procedure_invocation_tests.sql

PRINT 'Lab 6 Deployment Completed Successfully!';