#!/usr/bin/env python3
"""
Parse udm_data_dictionary_values.sql to generate JSON for the data dictionary browser.
Generates data-dictionary.json with table and column descriptions.
"""

import re
import json
from pathlib import Path

def parse_data_dictionary_sql(sql_file):
    """Parse data dictionary SQL file and extract table and column descriptions."""

    with open(sql_file, 'r') as f:
        content = f.read()

    tables = {}

    # Pattern to match INSERT statements
    # Format: ('Entity', 'Type', 'Parent', 'Description', 'Synonyms', PII_Flag)
    value_pattern = r"\('([^']+)',\s*'(Table|Column)',\s*(?:'([^']*)'|NULL),\s*'([^']*)',\s*(?:'([^']*)'|NULL),\s*(TRUE|FALSE)\)"

    for match in re.finditer(value_pattern, content):
        entity = match.group(1)
        entity_type = match.group(2)
        parent_entity = match.group(3) if match.group(3) else None
        description = match.group(4)
        synonyms = match.group(5) if match.group(5) else None
        pii_flag = match.group(6) == 'TRUE'

        if entity_type == 'Table':
            # Initialize table entry
            tables[entity] = {
                'name': entity,
                'description': description,
                'synonyms': synonyms,
                'columns': []
            }
        elif entity_type == 'Column' and parent_entity:
            # Add column to parent table
            if parent_entity not in tables:
                tables[parent_entity] = {
                    'name': parent_entity,
                    'description': '',
                    'synonyms': None,
                    'columns': []
                }

            tables[parent_entity]['columns'].append({
                'name': entity,
                'description': description,
                'synonyms': synonyms,
                'pii': pii_flag
            })

    return tables

def main():
    # Paths
    base_dir = Path(__file__).parent.parent
    dd_file = base_dir / 'udm_data_dictionary_values.sql'
    output_dir = base_dir / 'docs' / 'data'

    # Create output directory
    output_dir.mkdir(parents=True, exist_ok=True)

    print(f"Parsing {dd_file}...")
    tables = parse_data_dictionary_sql(dd_file)

    print(f"Found {len(tables)} tables")

    # Generate data-dictionary.json
    output = {
        'tables': tables,
        'table_count': len(tables)
    }

    with open(output_dir / 'data-dictionary.json', 'w') as f:
        json.dump(output, f, indent=2)
    print(f"✓ Generated {output_dir / 'data-dictionary.json'}")

    print("\nDone! Data dictionary JSON ready for dashboard.")

if __name__ == '__main__':
    main()
