/*
================================================================================
  File        : programmable_object_removal.sql
  Author      : Joshua
  Task        : Task 12 — Programmable Object Removal
  Course      : ITE-5223 SQL Server Database Development
  Lab         : Lab 6 — SQL Server Programmability

  Description :
    Safely removes Lab 6 programmable objects in reverse dependency order.
    Used for clean teardown, redeployment, or lab reset scenarios.

  Patterns    :
    - Reverse dependency order: SPs → Functions → Types
    - IF OBJECT_ID / TYPE_ID existence checks before DROP
    - Documented removal sequence
    - No accidental schema/table drops

  TODO        :
    - Confirm removal order matches deployment dependencies
    - Add confirmation PRINT statements for each dropped object
    - Optionally wrap in TRY/CATCH for graceful error reporting
================================================================================
*/

USE RetailPromotionAnalytics;
GO

/* =========================================================
   DROP STORED PROCEDURE
========================================================= */

IF OBJECT_ID('RetailAnalytics.usp_GetCampaignDetails', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE RetailAnalytics.usp_GetCampaignDetails;
    PRINT 'Dropped usp_GetCampaignDetails';
END
ELSE
BEGIN
    PRINT 'usp_GetCampaignDetails does not exist';
END
GO

/* =========================================================
   DROP FUNCTION
========================================================= */

IF OBJECT_ID('RetailAnalytics.ufn_CalculateProfitMargin', 'FN') IS NOT NULL
BEGIN
    DROP FUNCTION RetailAnalytics.ufn_CalculateProfitMargin;
    PRINT 'Dropped ufn_CalculateProfitMargin';
END
ELSE
BEGIN
    PRINT 'ufn_CalculateProfitMargin does not exist';
END
GO

PRINT 'Task 12 completed: Objects removed successfully.';
GO


SELECT name, type_desc
FROM sys.objects
WHERE name IN ('usp_GetCampaignDetails', 'ufn_CalculateProfitMargin');