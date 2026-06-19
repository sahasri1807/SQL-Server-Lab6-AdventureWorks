# SQL-Server-Lab6-AdventureWorks

**ITE-5223 — SQL Server Database Development**  
**Lab 6: SQL Server Programmability — Stored Procedures & Functions**

| | |
|---|---|
| **Course** | ITE-5223 SQL Server Database Development |
| **Institution** | Humber Polytechnic |
| **Lab** | Lab 6 — SQL Server Programmability |
| **Due Date** | June 21, 2026, 11:59 PM EDT |
| **Database** | AdventureWorks2022 |
| **Schema** | `RetailAnalytics` |
| **GitHub** | [sahasri1807/SQL-Server-Lab6-AdventureWorks](https://github.com/sahasri1807/SQL-Server-Lab6-AdventureWorks) |

AdventureWorks Corporation's retail analytics platform needs a reusable **programmability layer** — stored procedures, scalar functions, table-valued functions, and table-valued parameters — to encapsulate campaign validation, revenue calculation, batch processing, and performance reporting inside SQL Server.

---

## Table of Contents

1. [Team Members](#team-members)
2. [Quick Start](#quick-start)
3. [Prerequisites](#prerequisites)
4. [Repository Structure](#repository-structure)
5. [Lab Tasks (1–13)](#lab-tasks-113)
6. [Script Inventory](#script-inventory)
7. [Deployment Instructions](#deployment-instructions)
8. [Screenshot Requirements](#screenshot-requirements)
9. [Evaluation Criteria](#evaluation-criteria)
10. [Git Workflow](#git-workflow)
11. [Submission Guidelines](#submission-guidelines)
12. [Academic Integrity](#academic-integrity)

---

## Team Members

> **Action Required:** Replace `[Student ID]` with your Humber Polytechnic student ID before final submission.

| # | Name | Student ID | Role | Primary Task(s) |
|---|------|------------|------|-----------------|
| 1 | Sahasri | N10010782 | Team Lead & Integrator | Task 1, Task 13 |
| 2 | Parth | [Student ID] | Validation SP Developer | Task 2 |
| 3 | Kelvin | N01777723 | Campaign Retrieval SP Developer | Task 3 |
| 4 | Hassana | [Student ID] | Revenue Calculation SP Developer | Task 4 |
| 5 | Lien | N01704642 | TVP & Batch Processing Developer | Task 5 |
| 6 | Brian | N10003819 | Discount Function + Invocation Tests | Task 6, Task 10 |
| 7 | Dhruv | [Student ID] | Profit Margin Function Developer | Task 7 |
| 8 | Sahil | [Student ID] | TVF Developer | Task 8, Task 9 |
| 9 | Joshua | [Student ID] | Maintenance, Lifecycle & QA | Task 11, Task 12 |

**Team:** Sahasri · Parth · Kelvin · Hassana · Lien · Brian · Dhruv · Sahil · Joshua

---

## Quick Start

```bash
# 1. Clone the repository
git clone https://github.com/sahasri1807/SQL-Server-Lab6-AdventureWorks.git
cd SQL-Server-Lab6-AdventureWorks
```

```text
2. Open SSMS → connect to SQL Server → ensure AdventureWorks2022 is available
3. Enable SQLCMD Mode (Query → SQLCMD Mode)
4. Open scripts/deployment/deploy_all.sql and execute (F5)
5. Run scripts/testing/stored_procedure_invocation_tests.sql
6. Capture 14 screenshots → save to screenshots/
```

For deployment order and troubleshooting, see **[Deployment Instructions](#deployment-instructions)** below.

---

## Prerequisites

| Requirement | Details |
|-------------|---------|
| **SQL Server** | SQL Server 2019 or later (Developer Edition recommended) |
| **Database** | `AdventureWorks2022` restored and accessible |
| **Schema** | `RetailAnalytics` schema with tables from prior labs (Lab 5) |
| **SSMS** | SQL Server Management Studio 19 or later |
| **SQLCMD** | SQLCMD Mode enabled in SSMS for `deploy_all.sql` |
| **Git** | Git installed; team members added as repo collaborators |
| **Permissions** | `db_ddladmin` or equivalent on AdventureWorks2022 |

Verify your environment by running `scripts/initialize_programmability_environment.sql` before deploying programmable objects.

---

## Repository Structure

```
SQL-Server-Lab6-AdventureWorks/
│
├── README.md
├── .gitignore
├── scripts/
│   ├── deployment/
│   │   └── deploy_all.sql
│   ├── functions/
│   │   ├── ufn_CalculateDiscountAmount.sql
│   │   ├── ufn_CalculateProfitMargin.sql
│   │   ├── ufn_GetCampaignProducts.sql
│   │   └── ufn_GetCampaignPerformance.sql
│   ├── maintenance/
│   │   ├── programmable_object_modification.sql
│   │   └── programmable_object_removal.sql
│   ├── procedures/
│   │   ├── usp_ValidateCampaign.sql
│   │   ├── usp_GetCampaignDetails.sql
│   │   ├── usp_CalculateCampaignRevenue.sql
│   │   └── usp_ProcessCampaignBatch.sql
│   ├── testing/
│   │   └── stored_procedure_invocation_tests.sql
│   ├── types/
│   │   └── CampaignListType.sql
│   └── initialize_programmability_environment.sql
└── screenshots/                       ← Lab evidence (14 categories)
```

---

## Lab Tasks (1–13)

| Task | Description | Owner | Script(s) |
|------|-------------|-------|-----------|
| **Task 1** | Environment initialization — verify `RetailAnalytics` schema and Lab 5 tables; set session options | Sahasri | `scripts/initialize_programmability_environment.sql` |
| **Task 2** | Campaign validation stored procedure with TRY/CATCH and custom error messages | Parth | `scripts/procedures/usp_ValidateCampaign.sql` |
| **Task 3** | Campaign detail retrieval SP with return codes (`0` / `-1` / `-2`) | Kelvin | `scripts/procedures/usp_GetCampaignDetails.sql` |
| **Task 4** | Campaign revenue calculation SP with `@TotalRevenue` / `@TotalOrders` OUTPUT parameters | Hassana | `scripts/procedures/usp_CalculateCampaignRevenue.sql` |
| **Task 5** | User-defined table type + batch processing SP using READONLY TVP | Lien | `scripts/types/CampaignListType.sql`, `scripts/procedures/usp_ProcessCampaignBatch.sql` |
| **Task 6** | Scalar function — discount amount calculation | Brian | `scripts/functions/ufn_CalculateDiscountAmount.sql` |
| **Task 7** | Scalar function — profit margin calculation | Dhruv | `scripts/functions/ufn_CalculateProfitMargin.sql` |
| **Task 8** | Inline table-valued function — campaign products | Sahil | `scripts/functions/ufn_GetCampaignProducts.sql` |
| **Task 9** | Multi-statement / inline table-valued function — campaign performance metrics | Sahil | `scripts/functions/ufn_GetCampaignPerformance.sql` |
| **Task 10** | Stored procedure invocation testing — EXEC, named params, OUTPUT, return codes, TVP | Brian | `scripts/testing/stored_procedure_invocation_tests.sql` |
| **Task 11** | Programmable object modification — ALTER PROCEDURE and ALTER FUNCTION | Joshua | `scripts/maintenance/programmable_object_modification.sql` |
| **Task 12** | Programmable object removal — DROP with existence checks (reverse dependency order) | Joshua | `scripts/maintenance/programmable_object_removal.sql` |
| **Task 13** | Master deployment script — SQLCMD `:r` includes all objects in dependency order | Sahasri | `scripts/deployment/deploy_all.sql` |

### Supporting Artifacts

| Artifact | Owner | Supports |
|----------|-------|----------|
| `screenshots/` (14 PNG files) | Joshua | All tasks — grading evidence |

---

## Script Inventory

| # | Script | Folder | Task | Owner | In deploy_all? |
|---|--------|--------|------|-------|----------------|
| 1 | `initialize_programmability_environment.sql` | `scripts/` | 1 | Sahasri | Yes (Step 1) |
| 2 | `CampaignListType.sql` | `scripts/types/` | 5 | Lien | Yes (Step 2) |
| 3 | `ufn_CalculateDiscountAmount.sql` | `scripts/functions/` | 6 | Brian | Yes (Step 3a) |
| 4 | `ufn_CalculateProfitMargin.sql` | `scripts/functions/` | 7 | Dhruv | Yes (Step 3b) |
| 5 | `ufn_GetCampaignProducts.sql` | `scripts/functions/` | 8 | Sahil | Yes (Step 4a) |
| 6 | `ufn_GetCampaignPerformance.sql` | `scripts/functions/` | 9 | Sahil | Yes (Step 4b) |
| 7 | `usp_ValidateCampaign.sql` | `scripts/procedures/` | 2 | Parth | Yes (Step 5a) |
| 8 | `usp_GetCampaignDetails.sql` | `scripts/procedures/` | 3 | Kelvin | Yes (Step 5b) |
| 9 | `usp_CalculateCampaignRevenue.sql` | `scripts/procedures/` | 4 | Hassana | Yes (Step 5c) |
| 10 | `usp_ProcessCampaignBatch.sql` | `scripts/procedures/` | 5 | Lien | Yes (Step 5d) |
| 11 | `stored_procedure_invocation_tests.sql` | `scripts/testing/` | 10 | Brian | No — run manually |
| 12 | `programmable_object_modification.sql` | `scripts/maintenance/` | 11 | Joshua | No — run after deploy |
| 13 | `programmable_object_removal.sql` | `scripts/maintenance/` | 12 | Joshua | No — reset only |
| 14 | `deploy_all.sql` | `scripts/deployment/` | 11 | Sahasri | N/A (orchestrator) |

**Programmable objects created:** 1 table type · 4 functions · 4 stored procedures

---

## Deployment Instructions

### Step 1 — Enable SQLCMD Mode in SSMS

1. Open **SQL Server Management Studio** and connect to your instance.
2. Open a new query window (**File → New → Query with Current Connection**).
3. Select **Query → SQLCMD Mode** (checkmark appears when active).
4. Confirm the status bar shows `SQLCMD:On`.

> SQLCMD mode is required for `:r` file-include directives in `deploy_all.sql`. Each new query window defaults to SQLCMD off.

### Step 2 — Run deploy_all.sql

1. Open `scripts/deployment/deploy_all.sql`.
2. Confirm database context: `USE AdventureWorks2022;`
3. Execute the script (**F5**).
4. Review the **Messages** pane — each step prints progress headers.
5. Verify the post-deployment query lists all 9 objects in `RetailAnalytics`.

### Step 3 — Run Test Scripts

Execute from `scripts/testing/` in SSMS (SQLCMD mode not required):

```sql
-- After successful deployment:
-- scripts/testing/stored_procedure_invocation_tests.sql
```

### Step 4 — Maintenance (Optional)

| Script | When to Run |
|--------|-------------|
| `scripts/maintenance/programmable_object_modification.sql` | After deploy — demonstrates ALTER PROCEDURE / ALTER FUNCTION (Task 11) |
| `scripts/maintenance/programmable_object_removal.sql` | Lab reset only — drops all Lab 6 objects (Task 12) |

### Deployment Order Summary

```
initialize_programmability_environment.sql
  → CampaignListType.sql
  → ufn_CalculateDiscountAmount.sql, ufn_CalculateProfitMargin.sql
  → ufn_GetCampaignProducts.sql, ufn_GetCampaignPerformance.sql
  → usp_ValidateCampaign.sql, usp_GetCampaignDetails.sql
  → usp_CalculateCampaignRevenue.sql
  → usp_ProcessCampaignBatch.sql  (requires TVP from step 2)
```

---

## Screenshot Requirements

Joshua organizes all lab evidence. Save **14 PNG screenshots** to `screenshots/` using the naming convention `##_category_description.png`.

| # | Category | What to Capture | Task |
|---|----------|-----------------|------|
| 1 | Environment Setup | `initialize_programmability_environment.sql` success | 1 |
| 2 | Validation SP | `usp_ValidateCampaign` — valid + invalid input | 2 |
| 3 | Campaign Details SP | `usp_GetCampaignDetails` result set | 3 |
| 4 | Revenue SP | `usp_CalculateCampaignRevenue` OUTPUT parameters | 4 |
| 5 | TVP Type | `CampaignListType` in Object Explorer | 5 |
| 6 | Batch Processing SP | `usp_ProcessCampaignBatch` with TVP | 5 |
| 7 | Discount Function | `ufn_CalculateDiscountAmount` scalar result | 6 |
| 8 | Profit Margin Function | `ufn_CalculateProfitMargin` scalar result | 7 |
| 9 | Campaign Products TVF | `ufn_GetCampaignProducts` result set | 8 |
| 10 | Campaign Performance TVF | `ufn_GetCampaignPerformance` result set | 9 |
| 11 | SP Invocation Tests | `stored_procedure_invocation_tests.sql` output | 10 |
| 12 | Object Modification | ALTER results from Task 11 | 11 |
| 11 | Object Removal | DROP results from Task 12 | 12 |
| 12 | Full Deployment | `deploy_all.sql` completed without errors | 11 |

Detailed capture guidelines: [`screenshots/README.md`](screenshots/README.md)

---

## Evaluation Criteria

| Category | Weight | Expectations |
|----------|--------|--------------|
| **Functionality** | 40% | All programmable objects execute correctly; business logic matches lab requirements |
| **Error Handling** | 20% | TRY/CATCH blocks, meaningful error messages, input validation |
| **Code Quality** | 15% | Consistent formatting, existence checks, schema-qualified names, header comments |
| **Testing** | 15% | Test scripts demonstrate success and failure paths; OUTPUT params and TVPs verified |
| **Documentation** | 10% | README complete, screenshots provided, team IDs filled in, architecture doc present |

---

## Git Workflow

This team pushes directly to the `main` branch.

### Workflow

1. Pull latest `main` before starting work:
   ```bash
   git checkout main
   git pull origin main
   ```
2. Implement your assigned script(s) only
3. Commit with descriptive messages:
   ```bash
   git add scripts/procedures/usp_ValidateCampaign.sql
   git commit -m "Implement usp_ValidateCampaign with TRY/CATCH validation (Task 2)"
   ```
4. Push directly to `main`:
   ```bash
   git push origin main
   ```
5. Coordinate with teammates to avoid editing the same files at the same time
6. Run `deploy_all.sql` after significant changes to verify integration

### Rules

- Always pull before you push to reduce merge conflicts
- One logical change per commit
- Do not commit `.bak`, `.ssmssln`, or credential files
- Add instructor as GitHub collaborator before submission

---

## Submission Guidelines

Before the deadline (**June 21, 2026, 11:59 PM EDT**):

- [ ] All 9 team member student IDs filled in [Team Members](#team-members)
- [ ] All assigned SQL scripts implemented (no remaining `TODO` blocks)
- [ ] `deploy_all.sql` runs end-to-end without errors
- [ ] All three test scripts in `testing/` execute successfully
- [ ] 14 screenshots captured in `screenshots/`
- [ ] `main` branch contains all team members' work
- [ ] README reviewed and accurate
- [ ] Repository URL submitted per course instructions (Canvas / course portal)
- [ ] Instructor added as GitHub collaborator
- [ ] Each member can demonstrate their assigned task live if requested

---

## Academic Integrity

This is a **graded academic assignment** for ITE-5223. All submitted work must be original team effort.

- Collaboration within the assigned team is expected and encouraged.
- Sharing code with other teams or copying external sources without attribution constitutes academic misconduct.
- Cite external references in script header comments.
- Each team member must be able to explain the code they contributed.

Violations are subject to Georgia Tech's academic integrity policies.

---

## Documentation Index

| Document | Path | Contents |
|----------|------|----------|
| **This README** | `README.md` | Overview, tasks, deployment, submission |
| **Screenshot Guide** | [`screenshots/README.md`](screenshots/README.md) | Naming conventions, capture guidelines |

---

*ITE-5223 SQL Server Database Development — Georgia Institute of Technology*
