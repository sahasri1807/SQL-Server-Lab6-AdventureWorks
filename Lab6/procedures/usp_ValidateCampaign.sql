/*
================================================================================
  File        : usp_ValidateCampaign.sql
  Author      : Parth
  Task        : Task 2 — Campaign Validation Stored Procedure
  Course      : ITE-5223 SQL Server Database Development
  Lab         : Lab 6 — SQL Server Programmability

  Description :
    Validates campaign input parameters and business rules before campaign
    operations are permitted. Returns validation status and descriptive messages.

  Patterns    :
    - IF EXISTS / OBJECT_ID check before CREATE OR ALTER
    - TRY/CATCH error handling
    - SET NOCOUNT ON
    - Input parameter validation with RAISERROR/THROW
    - Return code or OUTPUT parameter for validation result

  TODO        :
    - Implement campaign existence and date-range validation logic
    - Validate discount percentage bounds per lab specification
    - Return structured validation result (bit flag + message)
================================================================================
*/

USE AdventureWorks2022;
GO

IF OBJECT_ID(N'RetailAnalytics.usp_ValidateCampaign', N'P') IS NOT NULL
    DROP PROCEDURE RetailAnalytics.usp_ValidateCampaign;
GO

CREATE PROCEDURE RetailAnalytics.usp_ValidateCampaign
    @CampaignID     INT,
    @IsValid        BIT           OUTPUT,
    @Message        NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    SET @IsValid = 0;
    SET @Message = N'Validation not yet implemented.';

    BEGIN TRY
        -- TODO: Implement validation logic
        -- Example checks:
        --   1. @CampaignID is not NULL and > 0
        --   2. Campaign exists in RetailAnalytics.Campaign
        --   3. Campaign dates are valid (StartDate <= EndDate)
        --   4. Campaign is within active processing window

        IF @CampaignID IS NULL OR @CampaignID <= 0
        BEGIN
            SET @Message = N'Invalid CampaignID: must be a positive integer.';
            RETURN 1;
        END

        IF NOT EXISTS (
            SELECT 1
            FROM RetailAnalytics.Campaign
            WHERE CampaignID = @CampaignID
        )
        BEGIN
            SET @Message = N'Campaign not found.';
            RETURN 1;
        END

        -- TODO: Add remaining business rule validations

        SET @IsValid = 1;
        SET @Message = N'Campaign validation passed.';
        RETURN 0;
    END TRY
    BEGIN CATCH
        SET @IsValid = 0;
        SET @Message = ERROR_MESSAGE();
        RETURN ERROR_NUMBER();
    END CATCH
END;
GO

PRINT 'Created RetailAnalytics.usp_ValidateCampaign (stub — implementation pending).';
GO
