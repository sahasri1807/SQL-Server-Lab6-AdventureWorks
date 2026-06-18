/*
================================================================================
  File        : usp_CalculateCampaignRevenue.sql
  Author      : Hassana
  Task        : Task 4 — Campaign Revenue Calculation Stored Procedure
  Course      : ITE-5223 SQL Server Database Development
  Lab         : Lab 6 — SQL Server Programmability

  Description :
    Calculates total revenue, discount amounts, and net revenue for a campaign
    using OUTPUT parameters to return aggregated financial metrics.

  Patterns    :
    - IF EXISTS / OBJECT_ID check before CREATE OR ALTER
    - TRY/CATCH error handling
    - SET NOCOUNT ON
    - OUTPUT parameters for aggregated results
    - Scalar UDF integration (ufn_CalculateDiscountAmount) where applicable

  TODO        :
    - Implement revenue aggregation from CampaignProduct / CampaignPerformance
    - Populate all OUTPUT parameters per lab specification
    - Handle campaigns with no sales data gracefully
================================================================================
*/

USE AdventureWorks2022;
GO

IF OBJECT_ID(N'RetailAnalytics.usp_CalculateCampaignRevenue', N'P') IS NOT NULL
    DROP PROCEDURE RetailAnalytics.usp_CalculateCampaignRevenue;
GO

CREATE PROCEDURE RetailAnalytics.usp_CalculateCampaignRevenue
    @CampaignID         INT,
    @TotalRevenue       DECIMAL(18, 2) OUTPUT,
    @TotalDiscount      DECIMAL(18, 2) OUTPUT,
    @NetRevenue         DECIMAL(18, 2) OUTPUT,
    @ProductCount       INT            OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    -- Initialize OUTPUT parameters
    SET @TotalRevenue  = 0;
    SET @TotalDiscount = 0;
    SET @NetRevenue    = 0;
    SET @ProductCount  = 0;

    BEGIN TRY
        IF @CampaignID IS NULL OR @CampaignID <= 0
        BEGIN
            RAISERROR('Invalid CampaignID: must be a positive integer.', 16, 1);
            RETURN;
        END

        -- TODO: Implement revenue calculation logic
        -- Example pattern:
        --   SELECT @TotalRevenue = SUM(...), @TotalDiscount = SUM(...), ...
        --   FROM RetailAnalytics.CampaignPerformance
        --   WHERE CampaignID = @CampaignID;

        SET @NetRevenue = @TotalRevenue - @TotalDiscount;

        PRINT CONCAT(
            'Revenue calculation stub executed for CampaignID ', @CampaignID,
            '. Implementation pending.'
        );
    END TRY
    BEGIN CATCH
        SET @TotalRevenue  = NULL;
        SET @TotalDiscount = NULL;
        SET @NetRevenue    = NULL;
        SET @ProductCount  = NULL;
        THROW;
    END CATCH
END;
GO

PRINT 'Created RetailAnalytics.usp_CalculateCampaignRevenue (stub — implementation pending).';
GO
