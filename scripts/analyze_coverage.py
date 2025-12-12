#!/usr/bin/env python3
"""
Analyze table coverage using reverse relationships (child tables).
Find minimum entry points needed for 100% coverage.
"""

import json
from pathlib import Path
from collections import defaultdict

def build_reverse_relationships(relationships):
    """Build a map of table -> list of tables that reference it (children)."""
    reverse_map = defaultdict(list)

    for rel in relationships:
        from_table = rel['from_table']
        to_table = rel['to_table']

        # Skip self-referential relationships
        if from_table != to_table:
            reverse_map[to_table].append(from_table)

    # Remove duplicates
    for table in reverse_map:
        reverse_map[table] = list(set(reverse_map[table]))

    return reverse_map

def get_reachable_tables(start_table, relationships, reverse_map, all_tables):
    """Get all tables reachable from start_table via both FK and reverse relationships."""
    reachable = set([start_table])
    to_visit = [start_table]

    while to_visit:
        current = to_visit.pop()

        # Add child tables (reverse relationships)
        for child in reverse_map.get(current, []):
            if child not in reachable:
                reachable.add(child)
                to_visit.append(child)

        # Add parent tables (FK relationships)
        for rel in relationships:
            if rel['from_table'] == current and rel['to_table'] != current:
                parent = rel['to_table']
                if parent not in reachable:
                    reachable.add(parent)
                    to_visit.append(parent)

    return reachable

def find_minimum_entry_points(all_tables, relationships, reverse_map, exclude_structural=True):
    """Find minimum set of entry points for 100% coverage."""
    # Exclude structural/technical tables from being entry points
    structural_tables = {'AllowedValues', 'ActivityLog', 'BudgetCategory'}

    if exclude_structural:
        candidate_tables = [t for t in all_tables if t not in structural_tables]
        # But we still want to cover ALL tables, including structural ones
        uncovered = set(all_tables)
    else:
        candidate_tables = all_tables
        uncovered = set(all_tables)

    entry_points = []

    # Calculate coverage for each potential entry point
    coverage_map = {}
    for table in all_tables:
        coverage_map[table] = get_reachable_tables(table, relationships, reverse_map, all_tables)

    # Greedy algorithm: pick table with most uncovered tables
    while uncovered:
        best_table = None
        best_coverage = 0

        for table in candidate_tables:
            new_coverage = len(coverage_map[table] & uncovered)
            if new_coverage > best_coverage:
                best_coverage = new_coverage
                best_table = table

        if best_table:
            entry_points.append(best_table)
            uncovered -= coverage_map[best_table]
            candidate_tables.remove(best_table)  # Don't pick the same table twice
        else:
            break

    return entry_points, coverage_map

def main():
    base_dir = Path(__file__).parent.parent

    # Load relationships
    with open(base_dir / 'docs' / 'data' / 'relationships.json') as f:
        rel_data = json.load(f)

    # Load data dictionary
    with open(base_dir / 'docs' / 'data' / 'data-dictionary.json') as f:
        dd_data = json.load(f)

    relationships = rel_data['relationships']
    all_tables = list(dd_data['tables'].keys())

    print(f"Total tables: {len(all_tables)}")
    print()

    # Build reverse relationship map
    reverse_map = build_reverse_relationships(relationships)

    print("=== Reverse Relationships (Tables Referenced By) ===")
    for table in sorted(reverse_map.keys()):
        children = reverse_map[table]
        print(f"{table}: {len(children)} child tables")
        for child in sorted(children):
            print(f"  - {child}")
    print()

    # Find minimum entry points (excluding structural tables)
    entry_points, coverage_map = find_minimum_entry_points(all_tables, relationships, reverse_map, exclude_structural=True)

    print("=== Minimum Domain-Meaningful Entry Points for 100% Coverage ===")
    print("(Excluding structural tables: AllowedValues, ActivityLog, BudgetCategory)")
    print(f"Number of entry points needed: {len(entry_points)}")
    print()

    for i, table in enumerate(entry_points, 1):
        reachable = coverage_map[table]
        print(f"{i}. {table}")
        print(f"   Reaches {len(reachable)} tables ({len(reachable)/len(all_tables)*100:.1f}%)")
        print(f"   Via reverse: {len(reverse_map.get(table, []))} children")
        print()

    # Show coverage from current 4 entry points
    print("=== Coverage from Current Entry Points ===")
    current_entries = ['Organization', 'Project', 'Personnel', 'Transaction']
    total_reachable = set()

    for table in current_entries:
        reachable = coverage_map[table]
        total_reachable |= reachable
        print(f"{table}: {len(reachable)} tables ({len(reachable)/len(all_tables)*100:.1f}%)")
        print(f"  Children: {', '.join(sorted(reverse_map.get(table, [])))}")
        print()

    print(f"Combined coverage: {len(total_reachable)}/{len(all_tables)} ({len(total_reachable)/len(all_tables)*100:.1f}%)")
    print(f"Missing: {', '.join(sorted(set(all_tables) - total_reachable))}")

if __name__ == '__main__':
    main()
