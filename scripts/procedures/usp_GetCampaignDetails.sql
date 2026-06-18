/*
================================================================================
  File        : usp_GetCampaignDetails.sql
  Author      : Kelvin
  Task        : Task 3 — Campaign Details Retrieval Stored Procedure
  Course      : ITE-5223 SQL Server Database Development
  Lab         : Lab 6 — SQL Server Programmability
================================================================================
*/
USE RetailPromotionAnalytics;
GO
 
IF OBJECT_ID('RetailAnalytics.usp_GetCampaignDetails', 'P') IS NOT NULL

    DROP PROCEDURE RetailAnalytics.usp_GetCampaignDetails;
GO
 
CREATE PROCEDURE RetailAnalytics.usp_GetCampaignDetails
    @CampaignID INT
AS

BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Return Code: -2 (Invalid Campaign ID)
        IF @CampaignID IS NULL OR @CampaignID <= 0

        BEGIN
            RETURN -2;
        END;
 
        -- Return Code: -1 (Campaign Not Found)
        IF NOT EXISTS
        (
            SELECT 1
            FROM RetailAnalytics.PromotionCampaign
            WHERE CampaignID = @CampaignID
        )

        BEGIN
            RETURN -1;
        END;
 
        -- Required Output
        SELECT
            CampaignID, CampaignName, CampaignType, StartDate, EndDate, DiscountRate
        FROM RetailAnalytics.PromotionCampaign
        WHERE CampaignID = @CampaignID;

        -- Success
        RETURN 0; 
    END TRY

    BEGIN CATCH
        PRINT 'Error: ' + ERROR_MESSAGE();
        RETURN -99;
    END CATCH
END;
GO
 
PRINT 'RetailAnalytics.usp_GetCampaignDetails created successfully.';
GO
 
DECLARE @ReturnCode INT; 
EXEC @ReturnCode = RetailAnalytics.usp_GetCampaignDetails
    @CampaignID = 1;
 
SELECT @ReturnCode AS ReturnCode;
 
