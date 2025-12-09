# Claude Instructions for AI4RA-UDM Project

## Database Management

1. **No Migration Scripts**: Never create database migration scripts. Always work directly with the schema file (`udm_schema.sql`) and rebuild tables when needed.

2. **Dolt Native Features**: Dolt provides native version control and audit tracking. Do not add `Last_Modified_By`, `Last_Modified_Date`, `Created_By`, or `Created_Date` columns - Dolt tracks all changes through its git-like commit history.

3. **Schema Updates**: When updating the schema:
   - Update `udm_schema.sql` directly
   - Drop and recreate tables from the schema file
   - Run `udm_testing.sql` to verify changes
   - Don't make backup files, e.g., `udm_testing.backup` use git. Commit before making changes, make the changes to the actual file, and commit when tests pass.
   - Don't EVER make your own filenames up unless directly asked. For example you shouldn't make a new sql file when making changes to `udm_schema.sql` like `udm_schema_fixed.sql`. That just muddies file organization and makes it difficult to tell which file is the correct one to work from. Just use git and modify the file directly using commits.

## Naming Conventions

- **Tables**: PascalCase (e.g., `Project`, `Award`, `Personnel`)
- **Columns**: Snake_case (e.g., `Project_ID`, `Award_Number`, `Start_Date`)
- **Avoid Ambiguous Names**: Prefix ambiguous column names with table context:
  - Use `Project_Title`, `Award_Title` instead of just `Title`
  - Use `Project_Status`, `Award_Status` instead of just `Status`
  - Avoid abbreviations like `Org` (use `Organization`) or `COI` (use `ConflictOfInterest`)

## File Organization

- `udm_schema.sql`: Main schema definition (source of truth)
- `udm_views.sql`: Database views
- `udm_testing.sql`: Test data and validation queries
- `scripts/`: Python scripts for automation
- `migrations/`: **DO NOT CREATE** - Not used in this project
