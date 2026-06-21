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

CREATE OR ALTER PROCEDURE RetailAnalytics.usp_ValidateCampaign
    @CampaignName  NVARCHAR(100),
    @CampaignType  NVARCHAR(50),
    @DiscountRate  DECIMAL(5,2),
    @StartDate     DATE,
    @EndDate       DATE
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY

        -- Rule 1
        IF @CampaignName IS NULL OR LTRIM(RTRIM(@CampaignName)) = ''
            THROW 50001, 'Campaign Name cannot be empty', 1;

        -- Rule 2
        IF @CampaignType IS NULL OR LTRIM(RTRIM(@CampaignType)) = ''
            THROW 50002, 'Campaign Type cannot be empty', 1;

        -- Rule 3
        IF @DiscountRate <= 0
            THROW 50003, 'Discount Rate must be greater than 0', 1;

        -- Rule 4
        IF @DiscountRate > 50
            THROW 50004, 'Discount Rate cannot exceed 50%', 1;

        -- Rule 5
        IF @StartDate >= @EndDate
            THROW 50005, 'Start Date must be earlier than End Date', 1;

        PRINT 'Validation successful';
        RETURN 0;

    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO