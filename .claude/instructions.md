# Claude Instructions for AI4RA-UDM Project

## Critical Rules

1. **NEVER ALTER THE DOLT DATABASE DIRECTLY**:

   - No `ALTER TABLE`, `DROP TABLE`, or any direct database modifications
   - This is schema development, not a live database
   - The Dolt database is only for testing the schema files

2. **NEVER CREATE NEW FILENAMES**:

   - Don't make backup files like `udm_schema_backup.sql` or `udm_schema_fixed.sql` or `udm_schema.sql.backup`
   - Don't create new files unless explicitly asked
   - Use git for version control - commit before and after changes
   - Only modify the actual files: `udm_schema.sql`, `udm_views.sql`, `udm_testing.sql`

3. **NEVER CREATE MIGRATION SCRIPTS**:
   - No `migrations/` folder
   - No numbered migration files like `001_*.sql`
   - Always work directly on the source schema files

## Workflow for Schema Changes

1. **Commit current state**: `git add -A && git commit -m "Description"`
2. **Edit the schema file directly**: Modify `udm_schema.sql`
3. **Drop all Dolt tables**:
   ```bash
   dolt sql << 'EOF'
   SET FOREIGN_KEY_CHECKS = 0;
   DROP TABLE IF EXISTS [all tables];
   SET FOREIGN_KEY_CHECKS = 1;
   EOF
   ```
4. **Recreate from schema**: `dolt sql < udm_schema.sql`
5. **Load views**: `dolt sql < udm_views.sql`
6. **Run tests**: `dolt sql < udm_testing.sql`
7. **If tests pass, commit**: `git add -A && git commit -m "Description"`

## Schema Design Principles

- **Dolt Native Features**: Dolt provides native version control and audit tracking. Do not add `Last_Modified_By`, `Last_Modified_Date`, `Created_By`, or `Created_Date` columns - Dolt tracks all changes through its git-like commit history.

## Naming Conventions

- **Tables**: PascalCase (e.g., `Project`, `Award`, `Personnel`)
- **Columns**: Snake_case (e.g., `Project_ID`, `Award_Number`, `Start_Date`)
- **Avoid Ambiguous Names**: Prefix ambiguous column names with table context:
  - Use `Project_Title`, `Award_Title` instead of just `Title`
  - Use `Project_Status`, `Award_Status` instead of just `Status`
  - Avoid abbreviations like `Org` (use `Organization`)

## Files in This Project

- `udm_schema.sql`: Main schema definition (source of truth)
- `udm_values.sql`: Sample data to populate the unified data model
- `udm_views.sql`: Database views
- `udm_data_dictionary_schema.sql`: Data dictionary schema
- `udm_data_dictionary_values.sql`: Data dictionary values
- `udm_testing.sql`: Test data and validation queries
- `scripts/`: Python scripts for automation (use sparingly)
