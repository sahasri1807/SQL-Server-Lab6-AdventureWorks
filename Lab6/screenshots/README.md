# Screenshots — Lab 6 Evidence

Joshua (Maintenance & QA) is responsible for collecting and organizing all lab screenshots. Save files to this directory using the naming convention below.

## Naming Convention

```
##_category_short_description.png
```

Examples:
- `01_environment_setup_success.png`
- `04_revenue_sp_output_parameters.png`
- `14_full_deployment_complete.png`

## Required Screenshot Categories (14 Total)

| # | Filename Prefix | What to Capture | Assigned Task |
|---|-----------------|-----------------|---------------|
| 1 | `01_environment` | Successful execution of `initialize_programmability_environment.sql` showing schema/table verification | Task 1 |
| 2 | `02_validation_sp` | `usp_ValidateCampaign` — show valid input success and invalid input error message | Task 2 |
| 3 | `03_campaign_details` | `usp_GetCampaignDetails` result set for a sample `@CampaignID` | Task 3 |
| 4 | `04_revenue_sp` | `usp_CalculateCampaignRevenue` with OUTPUT parameters visible in Results/Messages | Task 4 |
| 5 | `05_tvp_type` | Object Explorer showing `RetailAnalytics.CampaignListType` under Types | Task 5 |
| 6 | `06_batch_processing` | `usp_ProcessCampaignBatch` executing with a populated TVP variable | Task 5 |
| 7 | `07_discount_function` | `SELECT RetailAnalytics.ufn_CalculateDiscountAmount(...)` scalar result | Task 6 |
| 8 | `08_profit_margin` | `SELECT RetailAnalytics.ufn_CalculateProfitMargin(...)` scalar result | Task 7 |
| 9 | `09_campaign_products` | `SELECT * FROM RetailAnalytics.ufn_GetCampaignProducts(@CampaignID)` | Task 8 |
| 10 | `10_campaign_performance` | `SELECT * FROM RetailAnalytics.ufn_GetCampaignPerformance(@CampaignID)` | Task 9 |
| 11 | `11_invocation_tests` | Output from `stored_procedure_invocation_tests.sql` (pass and fail cases) | Task 10 |
| 12 | `12_object_modification` | Successful ALTER from `programmable_object_modification.sql` | Task 11 |
| 13 | `13_object_removal` | Successful DROP from `programmable_object_removal.sql` | Task 12 |
| 14 | `14_full_deployment` | `deploy_all.sql` Messages pane showing all steps completed without errors | Task 13 |

## Capture Guidelines

- Use **full SSMS window** or a clearly cropped query editor + Messages/Results panes.
- Ensure **database name** (AdventureWorks2022) and **object names** are visible.
- Include **timestamp** where possible (visible in Messages pane output).
- Do not include personal connection strings or server passwords in screenshots.
- Submit **PNG** format; avoid blurry or low-resolution captures.

## Submission

All 14 screenshots must be committed to this folder on the `main` branch before the lab deadline:

**June 21, 2026, 11:59 PM EDT**
