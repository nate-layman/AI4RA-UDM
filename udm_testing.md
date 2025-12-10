# UDM Testing Protocol

**EVERY TIME YOU TEST: Drop tables → Load schema → Run tests**

## Step 1: Drop All Tables

```bash
cd /Users/nlayman/Documents/osp/granted/repos/AI4RA-UDM/dolt_db

dolt sql << 'EOF'
SET FOREIGN_KEY_CHECKS = 0;
DROP VIEW IF EXISTS vw_All_ContactDetails, vw_Active_Awards, vw_Active_Personnel_Roles, vw_Award_Financial_Summary, vw_Expiring_Awards, vw_Overdue_Deliverables, vw_ComplianceRequirement_Status, vw_Budget_Comparison;
DROP TABLE IF EXISTS Account, ActivityCode, ActivityLog, AllowedValues, Award, AwardBudget, AwardBudgetPeriod, AwardDeliverable, BudgetCategory, ComplianceRequirement, ConflictOfInterest, ContactDetails, CostShare, DataDictionary, Document, Effort, FinanceCode, Fund, IndirectRate, Invoice, Modification, Organization, Personnel, Project, ProjectRole, Proposal, ProposalBudget, RFA, Subaward, Terms, Transaction;
SET FOREIGN_KEY_CHECKS = 1;
EOF
```

Verify: `dolt sql -q "SHOW TABLES"` should return nothing.

## Step 2: Recreate Tables and Views

```bash
dolt sql < ../udm_schema.sql
dolt sql < ../udm_views.sql
```

## Step 3: Run Tests

```bash
dolt sql < ../udm_testing.sql 2>&1
```

Review output for errors. All test sections should complete successfully.

## Notes

- Always test on `test` branch
- If any step fails, start over from Step 1
- Test data is not committed - it's for validation only
