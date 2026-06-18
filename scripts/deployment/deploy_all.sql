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

-- :setvar ScriptRoot "."
-- Adjust ScriptRoot if executing from a different working directory.

USE AdventureWorks2022;
GO

SET NOCOUNT ON;
GO

PRINT '================================================================================';
PRINT ' Lab 6 — Master Deployment Started';
PRINT CONCAT(' Timestamp: ', CONVERT(varchar(30), SYSDATETIME(), 120));
PRINT '================================================================================';
GO

-- ============================================================================
-- STEP 1: Environment Initialization (Task 1)
-- ============================================================================
PRINT '';
PRINT '>>> STEP 1: Environment Initialization';
:r ../initialize_programmability_environment.sql
GO

-- ============================================================================
-- STEP 2: User-Defined Table Type (Task 5 — prerequisite for batch SP)
-- ============================================================================
PRINT '';
PRINT '>>> STEP 2: CampaignListType Table-Valued Type';
:r ../types/CampaignListType.sql
GO

-- ============================================================================
-- STEP 3: Scalar Functions (Tasks 6–7)
-- ============================================================================
PRINT '';
PRINT '>>> STEP 3a: ufn_CalculateDiscountAmount';
:r ../functions/ufn_CalculateDiscountAmount.sql
GO

PRINT '';
PRINT '>>> STEP 3b: ufn_CalculateProfitMargin';
:r ../functions/ufn_CalculateProfitMargin.sql
GO

-- ============================================================================
-- STEP 4: Table-Valued Functions (Tasks 8–9)
-- ============================================================================
PRINT '';
PRINT '>>> STEP 4a: ufn_GetCampaignProducts';
:r ../functions/ufn_GetCampaignProducts.sql
GO

PRINT '';
PRINT '>>> STEP 4b: ufn_GetCampaignPerformance';
:r ../functions/ufn_GetCampaignPerformance.sql
GO

-- ============================================================================
-- STEP 5: Stored Procedures (Tasks 2–5)
-- ============================================================================
PRINT '';
PRINT '>>> STEP 5a: usp_ValidateCampaign';
:r ../procedures/usp_ValidateCampaign.sql
GO

PRINT '';
PRINT '>>> STEP 5b: usp_GetCampaignDetails';
:r ../procedures/usp_GetCampaignDetails.sql
GO

PRINT '';
PRINT '>>> STEP 5c: usp_CalculateCampaignRevenue';
:r ../procedures/usp_CalculateCampaignRevenue.sql
GO

PRINT '';
PRINT '>>> STEP 5d: usp_ProcessCampaignBatch';
:r ../procedures/usp_ProcessCampaignBatch.sql
GO

-- ============================================================================
-- STEP 6: Post-Deployment Verification
-- ============================================================================
PRINT '';
PRINT '>>> STEP 6: Post-Deployment Verification';
GO

SELECT
    o.name AS ObjectName,
    o.type_desc AS ObjectType,
    o.create_date AS CreatedDate,
    o.modify_date AS ModifiedDate
FROM sys.objects AS o
WHERE o.schema_id = SCHEMA_ID(N'RetailAnalytics')
  AND o.type IN ('P', 'FN', 'IF', 'TF', 'TT')
ORDER BY
    CASE o.type
        WHEN 'TT' THEN 1
        WHEN 'FN' THEN 2
        WHEN 'IF' THEN 3
        WHEN 'TF' THEN 4
        WHEN 'P'  THEN 5
        ELSE 6
    END,
    o.name;
GO

PRINT '';
PRINT '================================================================================';
PRINT ' Lab 6 — Master Deployment Completed Successfully';
PRINT '================================================================================';
GO
