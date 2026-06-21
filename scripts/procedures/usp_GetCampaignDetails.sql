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

        -- validation
        IF @CampaignID IS NULL OR @CampaignID <= 0
            RETURN -2;

        -- exists check
        IF NOT EXISTS (
            SELECT 1
            FROM RetailAnalytics.PromotionCampaign
            WHERE CampaignID = @CampaignID
        )
            RETURN -1;

        -- output (MATCHES YOUR REAL TABLE)
        SELECT
            CampaignID,
            CampaignName,
            DiscountRate,
            CASE 
                WHEN DiscountRate >= 30 THEN 'High Discount'
                WHEN DiscountRate >= 10 THEN 'Medium Discount'
                ELSE 'Low Discount'
            END AS CampaignStatus
        FROM RetailAnalytics.PromotionCampaign
        WHERE CampaignID = @CampaignID;

        RETURN 0;

    END TRY
    BEGIN CATCH
        RETURN -99;
    END CATCH
END;
GO

DECLARE @rc INT;

EXEC @rc = RetailAnalytics.usp_GetCampaignDetails 1;

SELECT @rc AS ReturnCode;