/*
================================================================================
  File        : usp_GetCampaignDetails.sql
  Author      : Kelvin
  Task        : Task 3 — Campaign Details Retrieval Stored Procedure
  Course      : ITE-5223 SQL Server Database Development
  Lab         : Lab 6 — SQL Server Programmability

  Description :
    Retrieves comprehensive campaign details including associated products and
    summary metrics for a given CampaignID.

  Patterns    :
    - IF EXISTS / OBJECT_ID check before CREATE OR ALTER
    - TRY/CATCH error handling
    - SET NOCOUNT ON
    - Parameterized queries (no SQL injection)
    - Optional: multiple result sets or single denormalized result

  TODO        :
    - Implement full campaign detail query with JOINs
    - Handle invalid @CampaignID with appropriate error
    - Include product count and performance summary columns
================================================================================
*/

USE AdventureWorks2022;
GO

IF OBJECT_ID(N'RetailAnalytics.usp_GetCampaignDetails', N'P') IS NOT NULL
    DROP PROCEDURE RetailAnalytics.usp_GetCampaignDetails;
GO

CREATE PROCEDURE RetailAnalytics.usp_GetCampaignDetails
    @CampaignID INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        IF @CampaignID IS NULL OR @CampaignID <= 0
        BEGIN
            RAISERROR('Invalid CampaignID: must be a positive integer.', 16, 1);
            RETURN;
        END

        -- TODO: Replace stub SELECT with full campaign details query
        SELECT
            c.CampaignID,
            c.CampaignName,
            c.StartDate,
            c.EndDate,
            c.DiscountPct
            -- TODO: Add computed columns, product counts, performance metrics
        FROM RetailAnalytics.Campaign AS c
        WHERE c.CampaignID = @CampaignID;

        IF @@ROWCOUNT = 0
        BEGIN
            RAISERROR('Campaign ID %d not found.', 16, 1, @CampaignID);
        END
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO

PRINT 'Created RetailAnalytics.usp_GetCampaignDetails (stub — implementation pending).';
GO
