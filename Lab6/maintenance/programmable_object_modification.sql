/*
================================================================================
  File        : programmable_object_modification.sql
  Author      : Joshua
  Task        : Task 11 — Programmable Object Modification
  Course      : ITE-5223 SQL Server Database Development
  Lab         : Lab 6 — SQL Server Programmability

  Description :
    Demonstrates safe modification of existing programmable objects using
    CREATE OR ALTER (or DROP/CREATE) patterns without breaking dependencies.

  Patterns    :
    - OBJECT_ID existence verification before modification
    - CREATE OR ALTER PROCEDURE / FUNCTION
    - sp_helptext or sys.sql_modules inspection
    - Version comment in object header

  TODO        :
    - Select target object(s) for modification per lab specification
    - Implement meaningful logic change (e.g., add parameter, enhance validation)
    - Verify dependent objects still function after modification
================================================================================
*/

USE AdventureWorks2022;
GO

SET NOCOUNT ON;
GO

PRINT '================================================================================';
PRINT ' Task 11 — Programmable Object Modification';
PRINT '================================================================================';
GO

-- ----------------------------------------------------------------------------
-- Step 1: Inspect current object definition
-- ----------------------------------------------------------------------------
IF OBJECT_ID(N'RetailAnalytics.usp_ValidateCampaign', N'P') IS NULL
BEGIN
    RAISERROR('Target object usp_ValidateCampaign does not exist. Deploy first.', 16, 1);
    RETURN;
END
GO

PRINT 'Current definition of RetailAnalytics.usp_ValidateCampaign:';
EXEC sp_helptext N'RetailAnalytics.usp_ValidateCampaign';
GO

-- ----------------------------------------------------------------------------
-- Step 2: Modify object using CREATE OR ALTER
-- ----------------------------------------------------------------------------
-- TODO: Implement lab-required modification to the target object
-- Example: add @ValidateDates BIT parameter, enhance validation message

/*
CREATE OR ALTER PROCEDURE RetailAnalytics.usp_ValidateCampaign
    @CampaignID     INT,
    @IsValid        BIT           OUTPUT,
    @Message        NVARCHAR(500) OUTPUT
AS
BEGIN
    -- Modified implementation here
END;
GO
*/

PRINT 'Modification stub ready. Uncomment and implement per lab Task 11 requirements.';
GO

-- ----------------------------------------------------------------------------
-- Step 3: Verify modified object
-- ----------------------------------------------------------------------------
SELECT
    o.name AS ObjectName,
    o.type_desc AS ObjectType,
    o.modify_date AS LastModified
FROM sys.objects AS o
WHERE o.object_id = OBJECT_ID(N'RetailAnalytics.usp_ValidateCampaign');
GO

PRINT 'Object modification script complete.';
GO
