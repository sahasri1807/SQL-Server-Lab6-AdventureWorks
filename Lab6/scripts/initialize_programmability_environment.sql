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

SET NOCOUNT ON;
GO

PRINT '================================================================================';
PRINT ' Lab 6 — Programmability Environment Initialization';
PRINT ' Task 1 — Verifying RetailAnalytics prerequisites';
PRINT '================================================================================';
GO

-- ----------------------------------------------------------------------------
-- Step 1: Verify database context
-- ----------------------------------------------------------------------------
IF DB_NAME() <> N'AdventureWorks2022'
BEGIN
    RAISERROR('Script must be executed in the AdventureWorks2022 database.', 16, 1);
    RETURN;
END
GO

-- ----------------------------------------------------------------------------
-- Step 2: Verify RetailAnalytics schema exists
-- ----------------------------------------------------------------------------
IF NOT EXISTS (
    SELECT 1
    FROM sys.schemas
    WHERE name = N'RetailAnalytics'
)
BEGIN
    RAISERROR(
        'RetailAnalytics schema does not exist. Complete prerequisite lab setup before continuing.',
        16,
        1
    );
    RETURN;
END
GO

PRINT 'RetailAnalytics schema found.';
GO

-- ----------------------------------------------------------------------------
-- Step 3: Verify required tables exist
-- ----------------------------------------------------------------------------
DECLARE @MissingTables TABLE (
    TableName sysname NOT NULL
);

INSERT INTO @MissingTables (TableName)
SELECT Required.TableName
FROM (
    VALUES
        (N'Campaign'),
        (N'CampaignProduct'),
        (N'CampaignPerformance')
) AS Required (TableName)
WHERE NOT EXISTS (
    SELECT 1
    FROM sys.tables AS t
    INNER JOIN sys.schemas AS s
        ON t.schema_id = s.schema_id
    WHERE s.name = N'RetailAnalytics'
      AND t.name = Required.TableName
);

IF EXISTS (SELECT 1 FROM @MissingTables)
BEGIN
    DECLARE @MissingList NVARCHAR(MAX);

    SELECT @MissingList = STRING_AGG(TableName, N', ')
    FROM @MissingTables;

    DECLARE @ErrorMessage NVARCHAR(4000) =
        N'Missing required RetailAnalytics tables: ' + ISNULL(@MissingList, N'(unknown)');

    RAISERROR(@ErrorMessage, 16, 1);
    RETURN;
END
GO

PRINT 'Required RetailAnalytics tables verified: Campaign, CampaignProduct, CampaignPerformance.';
GO

-- ----------------------------------------------------------------------------
-- Step 4: Report row counts for sanity check
-- ----------------------------------------------------------------------------
SELECT
    s.name AS SchemaName,
    t.name AS TableName,
    SUM(p.rows) AS RowCount
FROM sys.tables AS t
INNER JOIN sys.schemas AS s
    ON t.schema_id = s.schema_id
INNER JOIN sys.partitions AS p
    ON t.object_id = p.object_id
WHERE s.name = N'RetailAnalytics'
  AND t.name IN (N'Campaign', N'CampaignProduct', N'CampaignPerformance')
  AND p.index_id IN (0, 1)
GROUP BY s.name, t.name
ORDER BY t.name;
GO

PRINT 'Environment initialization completed successfully.';
PRINT 'Ready for programmable object deployment.';
GO
