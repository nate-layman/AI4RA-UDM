# AI4RA-UDM Todo List

## Completed Tasks ✓

1.  ✓ Pull any changes made on dolthub
2.  ✓ Remove all tables matching the pattern with "DataDictionary\_\*" keeping only the base "DataDictionary" table
3.  ✓ Evaluate the udm_data_dictionary_schema.sql and udm_data_dictionary_values.sql against udm_schema.sql
4.  ✓ Make sure Dolt database has appropriate values in DataDictionary table (72 rows inserted)
5.  ✓ Set up a udm_testing.sql with a series of insert and select statements to verify that the udm_schema is set up correctly and that all tables and views and relationships are working
6.  ✓ Commit and push both to dolt and github
7.  ✓ Evaluate the udm_testing.sql report on any issues that arise then drop changes instead of commiting to dolt. This is just for testing. (All tests passed successfully!)
8.  ✓ Create a python script in the scripts/ folder to generate mermaid ERD from the dolt db. Use an appropriate python library. Insert the resulting mermaid diagram code into the README.md in a mermaid block and commit to github.
9.  ✓ Make suggestions on how to improve the udm_schema. Make it simpler or more flexible or powerful. Make the names more transparent / clearer to understand for a regular research administrator. Highlight anything that might be missing. Do not implement the suggestions just review them. Consider things like consistency in naming scheme. Organization vs Org. (Comprehensive review document created: schema_improvement_suggestions.md)

## Summary of Completed Work

- **Dolt Database**: Cleaned up DataDictionary tables, populated with 72 entity definitions
- **Testing**: Created comprehensive test suite (udm_testing.sql) covering all 30 tables
- **Documentation**: Generated Mermaid ERD automatically and added to README.md
- **Analysis**: Created detailed schema improvement suggestions with prioritized recommendations

## Next Steps (Optional)

- Review schema_improvement_suggestions.md and prioritize improvements
- Consider implementing high-priority suggestions (naming consistency, foreign keys, DECIMAL precision)
- Expand testing suite with edge cases and validation tests
- Add more comprehensive data dictionary entries
