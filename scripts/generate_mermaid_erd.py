#!/usr/bin/env python3
"""
Generate Mermaid ERD from Dolt database schema
This script queries the Dolt database to extract table and column information
and generates a Mermaid entity-relationship diagram
"""

import subprocess
import json
import re
from typing import Dict, List, Tuple

def run_dolt_sql(query: str, db_path: str = "AI4RA-UDM") -> List[Dict]:
    """Execute a Dolt SQL query and return results as JSON"""
    result = subprocess.run(
        ["dolt", "sql", "-q", query, "--result-format", "json"],
        cwd=db_path,
        capture_output=True,
        text=True
    )
    if result.returncode != 0:
        raise Exception(f"Dolt query failed: {result.stderr}")

    # Parse the JSON output
    if result.stdout.strip():
        data = json.loads(result.stdout)
        # Dolt returns {"rows": [...]}
        if isinstance(data, dict) and 'rows' in data:
            # Convert uppercase keys to lowercase for consistency
            rows = []
            for row in data['rows']:
                lowercase_row = {k.lower(): v for k, v in row.items()}
                rows.append(lowercase_row)
            return rows
    return []

def get_tables(db_path: str = "AI4RA-UDM") -> List[str]:
    """Get all user tables from the database"""
    query = """
    SELECT table_name
    FROM information_schema.tables
    WHERE table_schema = 'AI4RA-UDM'
    AND table_type = 'BASE TABLE'
    AND table_name NOT LIKE 'dolt_%'
    ORDER BY table_name;
    """
    results = run_dolt_sql(query, db_path)
    return [row['table_name'] for row in results]

def get_table_columns(table_name: str, db_path: str = "AI4RA-UDM") -> List[Dict]:
    """Get columns for a specific table"""
    query = f"""
    SELECT
        column_name,
        data_type,
        is_nullable,
        column_key,
        column_default,
        extra
    FROM information_schema.columns
    WHERE table_schema = 'AI4RA-UDM'
    AND table_name = '{table_name}'
    ORDER BY ordinal_position;
    """
    return run_dolt_sql(query, db_path)

def get_foreign_keys(db_path: str = "AI4RA-UDM") -> List[Dict]:
    """Get all foreign key relationships"""
    query = """
    SELECT
        kcu.table_name,
        kcu.column_name,
        kcu.referenced_table_name,
        kcu.referenced_column_name,
        kcu.constraint_name
    FROM information_schema.key_column_usage kcu
    WHERE kcu.table_schema = 'AI4RA-UDM'
    AND kcu.referenced_table_name IS NOT NULL
    ORDER BY kcu.table_name, kcu.column_name;
    """
    return run_dolt_sql(query, db_path)

def format_column_type(column: Dict) -> str:
    """Format column type for Mermaid ERD"""
    data_type = column['data_type'].upper()

    # Simplify type names for readability
    type_map = {
        'VARCHAR': 'VARCHAR',
        'INT': 'INT',
        'DECIMAL': 'DECIMAL',
        'DATE': 'DATE',
        'TIMESTAMP': 'TIMESTAMP',
        'TEXT': 'TEXT',
        'BOOLEAN': 'BOOL',
        'TINYINT': 'BOOL'
    }

    for key, value in type_map.items():
        if data_type.startswith(key):
            return value

    return data_type

def generate_mermaid_erd(db_path: str = "AI4RA-UDM") -> str:
    """Generate Mermaid graph from database schema"""

    tables = get_tables(db_path)
    foreign_keys = get_foreign_keys(db_path)

    # Start Mermaid graph
    mermaid = ["graph TD"]

    # Group tables by domain for better organization
    domain_groups = {
        'Core': ['Organization', 'Personnel', 'Contact', 'AllowedValues', 'DataDictionary'],
        'Project': ['Project', 'RFA', 'Proposal', 'ProposalBudget'],
        'Award': ['Award', 'Modification', 'Terms', 'AwardBudgetPeriod', 'AwardBudget', 'Subaward', 'CostShare'],
        'Deliverables': ['Invoice', 'AwardDeliverable'],
        'Roles': ['ProjectRole', 'Effort'],
        'Finance': ['Fund', 'Account', 'FinanceCode', 'ActivityCode', 'IndirectRate', 'Transaction'],
        'Compliance': ['ComplianceRequirement', 'ConflictOfInterest'],
        'Documents': ['Document', 'ActivityLog']
    }

    # Create a flat list for ordering
    ordered_tables = []
    for group in domain_groups.values():
        ordered_tables.extend(group)

    # Add any tables not in the groups
    for table in tables:
        if table not in ordered_tables:
            ordered_tables.append(table)

    # Generate relationships (graph TD format uses arrows)
    mermaid.append("")

    # Track relationships to avoid duplicates
    relationships_added = set()

    for fk in foreign_keys:
        from_table = fk['table_name']
        to_table = fk['referenced_table_name']

        # Skip if tables don't exist
        if from_table not in tables or to_table not in tables:
            continue

        # Create a unique key for this relationship
        rel_key = f"{to_table}-->{from_table}"

        # Skip if we've already added this relationship
        if rel_key in relationships_added:
            continue

        relationships_added.add(rel_key)

        # Graph format: referenced table --> referencing table
        mermaid.append(f"    {to_table}-->{from_table}")

    return "\n".join(mermaid)

def update_readme(mermaid_erd: str, readme_path: str = "README.md"):
    """Update README.md with the generated Mermaid ERD"""
    try:
        with open(readme_path, 'r') as f:
            content = f.read()
    except FileNotFoundError:
        content = "# AI4RA-UDM\n\nUnified Data Model for AI for Research Administration\n\n"

    # Define the markers for the ERD section
    start_marker = "<!-- ERD_START -->"
    end_marker = "<!-- ERD_END -->"

    # Create the ERD section
    erd_section = f"{start_marker}\n## Entity Relationship Diagram\n\n```mermaid\n{mermaid_erd}\n```\n{end_marker}"

    # Check if markers exist
    if start_marker in content and end_marker in content:
        # Replace existing ERD
        pattern = f"{re.escape(start_marker)}.*?{re.escape(end_marker)}"
        content = re.sub(pattern, erd_section, content, flags=re.DOTALL)
    else:
        # Append ERD to end of file
        if not content.endswith("\n\n"):
            content += "\n\n"
        content += erd_section + "\n"

    with open(readme_path, 'w') as f:
        f.write(content)

    print(f"Updated {readme_path} with Mermaid ERD")

def main():
    """Main function to generate and insert ERD"""
    print("Generating Mermaid ERD from Dolt database...")

    try:
        mermaid_erd = generate_mermaid_erd()

        print("\nGenerated Mermaid ERD:")
        print("=" * 80)
        print(mermaid_erd)
        print("=" * 80)

        print("\nUpdating README.md...")
        update_readme(mermaid_erd)

        print("\nDone!")

    except Exception as e:
        print(f"Error: {e}")
        import traceback
        traceback.print_exc()
        return 1

    return 0

if __name__ == "__main__":
    exit(main())
