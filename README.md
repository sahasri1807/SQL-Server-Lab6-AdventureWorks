# SQL-Server-Lab6-AdventureWorks

**ITE-5223 — SQL Server Database Development**  
**Lab 6: SQL Server Programmability**

Repository for the AdventureWorks Retail Analytics programmability lab. All lab artifacts live under the [`Lab6/`](Lab6/) directory.

| | |
|---|---|
| **Course** | ITE-5223 SQL Server Database Development |
| **Lab** | Lab 6 — SQL Server Programmability |
| **Due Date** | June 21, 2026, 11:59 PM EDT |
| **Database** | AdventureWorks2022 (`RetailAnalytics` schema) |

## Quick Start

1. Clone this repository and open `Lab6/` in SQL Server Management Studio (SSMS).
2. Enable **SQLCMD Mode** (Query → SQLCMD Mode).
3. Review the full documentation in [`Lab6/README.md`](Lab6/README.md).
4. Run `Lab6/deployment/deploy_all.sql` against AdventureWorks2022.

## Team

Sahasri · Parth · Kelvin · Hassana · Lien · Brian · Dhruv · Sahil · Joshua

See the [Team Responsibility Matrix](Lab6/README.md#team-responsibility-matrix) in `Lab6/README.md` for task assignments.

## Repository Structure

```
Lab6/
├── scripts/          # Environment initialization
├── types/            # User-defined table types (TVPs)
├── functions/        # Scalar and table-valued functions
├── procedures/       # Stored procedures
├── testing/          # Invocation and validation tests
├── maintenance/      # Object modification and removal scripts
├── deployment/       # Master deployment script (SQLCMD)
└── screenshots/      # Lab evidence and documentation
```

For complete setup instructions, deployment order, evaluation criteria, and submission checklist, see **[`Lab6/README.md`](Lab6/README.md)**.
