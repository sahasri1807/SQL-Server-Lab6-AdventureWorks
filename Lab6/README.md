# Lab 6: SQL Server Programmability

**ITE-5223 — SQL Server Database Development**  
Georgia Institute of Technology

| | |
|---|---|
| **Lab Title** | SQL Server Programmability — AdventureWorks Retail Analytics |
| **Due Date** | **June 21, 2026, 11:59 PM EDT** |
| **Database** | AdventureWorks2022 |
| **Schema** | `RetailAnalytics` |
| **Repository** | [SQL-Server-Lab6-AdventureWorks](https://github.com/sahasri1807/SQL-Server-Lab6-AdventureWorks) |

---

## Table of Contents

1. [Project Overview](#project-overview)
2. [Prerequisites](#prerequisites)
3. [Team Members](#team-members)
4. [Team Responsibility Matrix](#team-responsibility-matrix)
5. [Repository Structure](#repository-structure)
6. [Getting Started](#getting-started)
7. [Enabling SQLCMD Mode in SSMS](#enabling-sqlcmd-mode-in-ssms)
8. [Running deploy_all.sql](#running-deploy_allsql)
9. [Deployment Order](#deployment-order)
10. [Screenshot Checklist](#screenshot-checklist)
11. [Evaluation Criteria](#evaluation-criteria)
12. [Git Workflow for Team Collaboration](#git-workflow-for-team-collaboration)
13. [Academic Integrity](#academic-integrity)
14. [Submission Checklist](#submission-checklist)

---

## Project Overview

AdventureWorks Corporation operates a multi-channel retail analytics platform built on SQL Server. The `RetailAnalytics` schema stores marketing campaign data, product performance metrics, and revenue calculations used by the business intelligence team.

This lab extends that platform with **programmable database objects** — stored procedures, user-defined functions, table-valued parameters, and supporting infrastructure — to encapsulate business logic at the database layer. Rather than embedding complex T-SQL in application code, the team will deliver reusable, testable, and maintainable programmability objects that:

- **Validate** marketing campaign data before processing
- **Retrieve** campaign details and performance metrics on demand
- **Calculate** revenue, discounts, and profit margins using scalar and table-valued functions
- **Process** campaign batches efficiently via table-valued parameters (TVPs)
- **Support** ongoing maintenance through scripted object modification and removal

All objects are deployed to the `RetailAnalytics` schema in the AdventureWorks2022 database using a SQLCMD-based deployment pipeline.

---

## Prerequisites

Before beginning development or deployment, ensure the following are in place:

| Requirement | Details |
|---|---|
| **SQL Server** | SQL Server 2019 or later (Developer Edition recommended) |
| **Database** | `AdventureWorks2022` restored and accessible |
| **Schema** | `RetailAnalytics` schema with lab tables created (from prior labs or lab setup scripts) |
| **SSMS** | SQL Server Management Studio 19 or later |
| **SQLCMD Mode** | Must be enabled to run `deploy_all.sql` |
| **Git** | Git installed; team members added as collaborators on this repository |
| **Permissions** | `db_ddladmin` or equivalent on AdventureWorks2022 |

### Verifying Your Environment

Run `scripts/initialize_programmability_environment.sql` first. It confirms the `RetailAnalytics` schema and required tables exist before any programmable objects are created.

---

## Team Members

> **Action Required:** Each team member must replace `[Student ID]` with their actual Georgia Tech student ID before final submission.

| Name | Student ID | Role |
|------|------------|------|
| Sahasri | [Student ID] | Team Lead & Integrator |
| Parth | [Student ID] | Validation SP Developer |
| Kelvin | [Student ID] | Campaign Retrieval SP Developer |
| Hassana | [Student ID] | Revenue Calculation SP Developer |
| Lien | [Student ID] | TVP & Batch Processing Developer |
| Brian | [Student ID] | Discount Function + Invocation Test Developer |
| Dhruv | [Student ID] | Profit Margin Function Developer |
| Sahil | [Student ID] | TVF Developer |
| Joshua | [Student ID] | Maintenance & QA |

---

## Team Responsibility Matrix

| Person | Role | Primary Task | Scripts |
|--------|------|--------------|---------|
| Sahasri | Team Lead & Integrator | Task 1 + Task 13 | `initialize_programmability_environment.sql`, `deploy_all.sql` |
| Parth | Validation SP Developer | Task 2 | `usp_ValidateCampaign.sql` |
| Kelvin | Campaign Retrieval SP Developer | Task 3 | `usp_GetCampaignDetails.sql` |
| Hassana | Revenue Calculation SP Developer | Task 4 | `usp_CalculateCampaignRevenue.sql`, `test_output_parameters.sql` |
| Lien | TVP & Batch Processing Developer | Task 5 | `CampaignListType.sql`, `usp_ProcessCampaignBatch.sql`, `tvp_batch_test.sql` |
| Brian | Discount Function + Invocation Test | Task 6 + Task 10 | `ufn_CalculateDiscountAmount.sql`, `stored_procedure_invocation_tests.sql` |
| Dhruv | Profit Margin Function Developer | Task 7 | `ufn_CalculateProfitMargin.sql` |
| Sahil | TVF Developer | Task 8 + Task 9 | `ufn_GetCampaignProducts.sql`, `ufn_GetCampaignPerformance.sql` |
| Joshua | Maintenance & QA | Task 11 + Task 12 + Screenshots | `programmable_object_modification.sql`, `programmable_object_removal.sql` |

---

## Repository Structure

```
Lab6/
├── scripts/
│   └── initialize_programmability_environment.sql   # Task 1: Verify schema/tables; set session options
├── types/
│   └── CampaignListType.sql                         # Task 5: User-defined table type (TVP)
├── functions/
│   ├── ufn_CalculateDiscountAmount.sql              # Task 6: Scalar function — discount calculation
│   ├── ufn_CalculateProfitMargin.sql                # Task 7: Scalar function — profit margin
│   ├── ufn_GetCampaignProducts.sql                  # Task 8: Inline table-valued function
│   └── ufn_GetCampaignPerformance.sql               # Task 9: Multi-statement table-valued function
├── procedures/
│   ├── usp_ValidateCampaign.sql                     # Task 2: Campaign validation stored procedure
│   ├── usp_GetCampaignDetails.sql                   # Task 3: Campaign detail retrieval
│   ├── usp_CalculateCampaignRevenue.sql             # Task 4: Revenue calculation with OUTPUT params
│   └── usp_ProcessCampaignBatch.sql                 # Task 5: Batch processing via TVP
├── testing/
│   ├── stored_procedure_invocation_tests.sql        # Task 10: SP invocation and error-handling tests
│   ├── test_output_parameters.sql                   # Task 4 (secondary): OUTPUT parameter tests
│   └── tvp_batch_test.sql                           # Task 5 (secondary): TVP batch processing tests
├── maintenance/
│   ├── programmable_object_modification.sql         # Task 11: ALTER existing programmable objects
│   └── programmable_object_removal.sql              # Task 12: DROP programmable objects safely
├── deployment/
│   └── deploy_all.sql                               # Task 13: Master SQLCMD deployment script
├── screenshots/
│   └── README.md                                    # Screenshot categories and naming conventions
└── README.md                                        # This file
```

---

## Getting Started

1. **Clone the repository**
   ```bash
   git clone https://github.com/sahasri1807/SQL-Server-Lab6-AdventureWorks.git
   cd SQL-Server-Lab6-AdventureWorks/Lab6
   ```

2. **Open SSMS** and connect to your SQL Server instance with AdventureWorks2022 available.

3. **Enable SQLCMD Mode** (see instructions below).

4. **Open** `deployment/deploy_all.sql` and execute against AdventureWorks2022.

5. **Run test scripts** individually from the `testing/` folder after deployment succeeds.

6. **Capture screenshots** per the checklist below and save to `screenshots/`.

---

## Enabling SQLCMD Mode in SSMS

SQLCMD mode allows SSMS to process `:r` (include file) directives used by `deploy_all.sql`.

1. Open **SQL Server Management Studio (SSMS)**.
2. Connect to your SQL Server instance.
3. Open a new query window (**File → New → Query with Current Connection**).
4. In the menu bar, select **Query → SQLCMD Mode** (a checkmark appears when enabled).
5. Alternatively, use the toolbar button labeled **SQLCMD Mode**.
6. Confirm SQLCMD is active — the status bar shows `SQLCMD:On`.

> **Note:** SQLCMD mode must be enabled in the query window where you execute `deploy_all.sql`. Each new query window defaults to SQLCMD off.

---

## Running deploy_all.sql

1. Ensure **SQLCMD Mode** is enabled (see above).
2. In SSMS, open `Lab6/deployment/deploy_all.sql`.
3. Set the database context:
   ```sql
   USE AdventureWorks2022;
   GO
   ```
4. Verify the `:r` paths in `deploy_all.sql` are correct relative to the `Lab6/` directory.
5. Execute the script (**F5** or **Execute**).
6. Review the **Messages** pane for deployment status and any errors.
7. If errors occur, fix the failing script on your feature branch, re-run `deploy_all.sql`, and verify with the test scripts.

---

## Deployment Order

Objects must be deployed in dependency order. `deploy_all.sql` enforces this sequence:

| Step | Script | Rationale |
|------|--------|-----------|
| 1 | `scripts/initialize_programmability_environment.sql` | Verify environment; set `ANSI_NULLS`, `QUOTED_IDENTIFIER`, etc. |
| 2 | `types/CampaignListType.sql` | TVP must exist before procedures reference it |
| 3 | `functions/ufn_CalculateDiscountAmount.sql` | Scalar function — no dependencies |
| 4 | `functions/ufn_CalculateProfitMargin.sql` | Scalar function — no dependencies |
| 5 | `functions/ufn_GetCampaignProducts.sql` | Inline TVF — no dependencies |
| 6 | `functions/ufn_GetCampaignPerformance.sql` | Multi-statement TVF — no dependencies |
| 7 | `procedures/usp_ValidateCampaign.sql` | SP — may reference functions |
| 8 | `procedures/usp_GetCampaignDetails.sql` | SP — may reference functions/TVFs |
| 9 | `procedures/usp_CalculateCampaignRevenue.sql` | SP with OUTPUT parameters |
| 10 | `procedures/usp_ProcessCampaignBatch.sql` | SP using TVP type |

> **Testing and maintenance scripts** (`testing/`, `maintenance/`) are run **separately** after deployment — they are not included in `deploy_all.sql`.

---

## Screenshot Checklist

Joshua is responsible for organizing screenshots. Save all images to `screenshots/` using the naming convention `##_category_description.png`.

| # | Category | Description |
|---|----------|-------------|
| 1 | Environment Setup | `initialize_programmability_environment.sql` executed successfully |
| 2 | Validation SP | `usp_ValidateCampaign` created and tested (valid + invalid input) |
| 3 | Campaign Details SP | `usp_GetCampaignDetails` result set for a sample campaign |
| 4 | Revenue SP | `usp_CalculateCampaignRevenue` with OUTPUT parameters displayed |
| 5 | TVP Type | `CampaignListType` created in Object Explorer |
| 6 | Batch Processing SP | `usp_ProcessCampaignBatch` processing a TVP batch |
| 7 | Discount Function | `ufn_CalculateDiscountAmount` scalar result |
| 8 | Profit Margin Function | `ufn_CalculateProfitMargin` scalar result |
| 9 | Campaign Products TVF | `ufn_GetCampaignProducts` result set |
| 10 | Campaign Performance TVF | `ufn_GetCampaignPerformance` result set |
| 11 | SP Invocation Tests | `stored_procedure_invocation_tests.sql` output (success + error cases) |
| 12 | Object Modification | `programmable_object_modification.sql` ALTER results |
| 13 | Object Removal | `programmable_object_removal.sql` DROP results |
| 14 | Full Deployment | `deploy_all.sql` completed with no errors in Messages pane |

See [`screenshots/README.md`](screenshots/README.md) for detailed guidance.

---

## Evaluation Criteria

| Category | Weight | Expectations |
|----------|--------|--------------|
| **Functionality** | 40% | All programmable objects execute correctly; business logic matches lab requirements |
| **Error Handling** | 20% | TRY/CATCH blocks, meaningful error messages, input validation |
| **Code Quality** | 15% | Consistent formatting, existence checks, schema-qualified names, header comments |
| **Testing** | 15% | Test scripts demonstrate success and failure paths; OUTPUT params and TVPs verified |
| **Documentation** | 10% | README complete, screenshots provided, team IDs filled in, Git history clean |

---

## Git Workflow for Team Collaboration

### Branch Strategy

Each team member works on a **personal feature branch**:

```
main
├── feature/sahasri-integration
├── feature/parth-validation-sp
├── feature/kelvin-campaign-details
├── feature/hassana-revenue-sp
├── feature/lien-tvp-batch
├── feature/brian-discount-function
├── feature/dhruv-profit-margin
├── feature/sahil-tvf
└── feature/joshua-maintenance-qa
```

### Workflow Steps

1. **Pull latest `main`** before starting work:
   ```bash
   git checkout main
   git pull origin main
   ```

2. **Create your feature branch:**
   ```bash
   git checkout -b feature/yourname-task-description
   ```

3. **Implement** your assigned script(s) only. Do not modify teammates' files without coordination.

4. **Commit** with descriptive messages:
   ```bash
   git add procedures/usp_ValidateCampaign.sql
   git commit -m "Implement usp_ValidateCampaign with TRY/CATCH validation (Task 2)"
   ```

5. **Push** and open a **Pull Request** to `main`:
   ```bash
   git push -u origin feature/yourname-task-description
   gh pr create --title "Task 2: usp_ValidateCampaign" --body "Implements campaign validation SP per lab spec."
   ```

6. **Code review:** At least one teammate (Sahasri for integration PRs) reviews before merge.

7. **Merge** via GitHub PR after approval. Sahasri resolves any merge conflicts in `deploy_all.sql`.

### Rules

- Never commit directly to `main` without a PR (except initial scaffold by team lead).
- One logical change per commit.
- Run `deploy_all.sql` after every merge to verify integration.
- Do not commit `.bak`, `.ssmssln`, or connection credential files.

---

## Academic Integrity

This is a **graded academic assignment** for ITE-5223. All submitted work must be original team effort.

- **Collaboration** within the assigned team is expected and encouraged.
- **Sharing code** with other teams or copying from external sources (Stack Overflow snippets, AI-generated solutions submitted without understanding, prior semester repos) without attribution and instructor permission constitutes academic misconduct.
- **Cite** any external references or templates used in script header comments.
- Each team member must be able to **explain** the code they contributed during lab review or instructor questioning.

Violations are subject to Georgia Tech's academic integrity policies.

---

## Submission Checklist

Before the deadline (**June 21, 2026, 11:59 PM EDT**), confirm:

- [ ] All 9 team member student IDs filled in above
- [ ] All assigned SQL scripts implemented (no remaining `TODO` blocks)
- [ ] `deploy_all.sql` runs end-to-end without errors
- [ ] All three test scripts in `testing/` execute successfully
- [ ] 14 screenshots captured and saved to `screenshots/`
- [ ] `main` branch contains merged work from all team members
- [ ] README reviewed and accurate
- [ ] Repository URL submitted per course instructions
- [ ] Each member can demonstrate their assigned task live if requested

---

*ITE-5223 SQL Server Database Development — Georgia Institute of Technology*
