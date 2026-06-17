/*
================================================================================
 File:       programmable_object_modification.sql
 Author:     Joshua
 Task:       Task 11 — Programmable Object Modification
 Description: Demonstrates ALTER PROCEDURE and ALTER FUNCTION to modify existing
              programmable objects without dropping dependencies.
 Schema:     RetailAnalytics
 Database:   AdventureWorks2022
================================================================================
*/

USE AdventureWorks2022;
GO

SET NOCOUNT ON;
GO

PRINT '================================================================================';
PRINT ' Lab 6 — Programmable Object Modification';
PRINT ' Task 11: Joshua';
PRINT '================================================================================';
GO

-- ============================================================================
-- Existence Check Before ALTER
-- ============================================================================
-- Pattern: Always verify object exists before attempting ALTER
-- IF OBJECT_ID(N'RetailAnalytics.usp_ValidateCampaign', N'P') IS NULL
-- BEGIN
--     RAISERROR('usp_ValidateCampaign does not exist. Deploy first.', 16, 1);
--     RETURN;
-- END
-- GO

-- ============================================================================
-- TODO: ALTER usp_ValidateCampaign — Add enhanced validation (Joshua)
-- ============================================================================
-- TODO: ALTER PROCEDURE RetailAnalytics.usp_ValidateCampaign ...
-- TODO: Add new validation rule (e.g., EndDate must be in the future for active campaigns)
-- TODO: Preserve existing parameter signature
-- GO

-- ============================================================================
-- TODO: ALTER ufn_CalculateDiscountAmount — Modify calculation logic (Joshua)
-- ============================================================================
-- TODO: ALTER FUNCTION RetailAnalytics.ufn_CalculateDiscountAmount ...
-- TODO: Apply maximum discount cap per lab specification
-- GO

-- ============================================================================
-- Verification: Confirm modified objects still execute
-- ============================================================================
PRINT '';
PRINT '--- Verifying modified objects ---';
-- TODO: Re-run sample EXEC/SELECT for each altered object
-- TODO: Compare behavior before and after ALTER

PRINT '';
PRINT 'Object modification complete. Capture screenshot #12.';
GO
