#!/usr/bin/env python3
"""
Remove audit columns and their FK constraints from schema.
Dolt provides native audit functionality via git-like tracking.
"""

import re

# Audit columns to remove
AUDIT_COLUMNS = [
    'Is_Active',
    'Date_Created',
    'Last_Modified_Date',
    'Last_Modified_By',
    'Created_By_Personnel_ID'
]

# Audit FK constraint patterns
AUDIT_FK_PATTERNS = [
    'fk_.*_modified_by',
    'fk_.*_created_by'
]

def remove_audit_columns(schema_content):
    """Remove audit columns while preserving syntax"""
    lines = schema_content.split('\n')
    result = []
    skip_until_comma = False

    for i, line in enumerate(lines):
        # Check if this line contains ONLY an audit column definition
        is_audit_column = any(
            re.match(rf'^\s*{col}\s+', line)
            for col in AUDIT_COLUMNS
        )

        # Check if this line starts an audit FK constraint
        is_audit_fk = any(
            re.search(pattern, line)
            for pattern in AUDIT_FK_PATTERNS
        )

        if is_audit_column:
            # Skip this line
            continue

        if is_audit_fk:
            # Skip until we find the end of this constraint (ends with comma or paren)
            skip_until_comma = True
            continue

        if skip_until_comma:
            # Check if this line ends the FK constraint
            if line.strip().endswith(',') or line.strip().endswith(')'):
                skip_until_comma = False
            continue

        result.append(line)

    return '\n'.join(result)

def fix_syntax(content):
    """Fix common syntax issues after removing columns"""
    # Remove lines that are just whitespace with a comma
    content = re.sub(r'^\s*,\s*$', '', content, flags=re.MULTILINE)

    # Fix cases where we have two consecutive commas
    content = re.sub(r',\s*,', ',', content)

    # Fix missing comma before CONSTRAINT
    # Pattern: value/paren followed by newline and CONSTRAINT (no comma)
    content = re.sub(
        r'([A-Za-z0-9_)\'\"])\s*\n(\s+CONSTRAINT)',
        r'\1,\n\2',
        content
    )

    # Remove comma just before closing paren
    content = re.sub(r',(\s*\n\s*\))', r'\1', content)

    # Clean up extra blank lines
    content = re.sub(r'\n\n\n+', '\n\n', content)

    return content

def main():
    with open('udm_schema.sql', 'r') as f:
        content = f.read()

    print("Original schema size:", len(content))

    # Remove audit columns
    content = remove_audit_columns(content)
    print(f"After removing audit columns: {len(content)}")

    # Fix syntax
    content = fix_syntax(content)
    print(f"After fixing syntax: {len(content)}")

    # Write result
    with open('udm_schema.sql', 'w') as f:
        f.write(content)

    print("\n✓ Removed all audit columns and FK constraints")
    print("  - Dolt provides native audit tracking via commits")

if __name__ == '__main__':
    main()
