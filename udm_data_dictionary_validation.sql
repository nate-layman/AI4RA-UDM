-- DataDictionary Validation Views
-- Ensures DataDictionary stays in sync with the actual schema

CREATE VIEW vw_DataDictionary_Validation AS
-- Tables in schema but not documented
SELECT
    'MISSING_TABLE' AS validation_type,
    t.TABLE_NAME AS entity_name,
    NULL AS column_name,
    'Table exists but not in DataDictionary' AS issue,
    'HIGH' AS severity,
    1 AS sort_order
FROM INFORMATION_SCHEMA.TABLES t
LEFT JOIN DataDictionary dd
    ON t.TABLE_NAME = dd.Entity
    AND dd.Entity_Type = 'Table'
    AND dd.Parent_Entity IS NULL
WHERE t.TABLE_SCHEMA = DATABASE()
    AND t.TABLE_TYPE = 'BASE TABLE'
    AND dd.DataDictionary_ID IS NULL

UNION ALL

-- Columns in schema but not documented
SELECT
    'MISSING_COLUMN' AS validation_type,
    c.TABLE_NAME AS entity_name,
    c.COLUMN_NAME AS column_name,
    'Column exists but not in DataDictionary' AS issue,
    'MEDIUM' AS severity,
    2 AS sort_order
FROM INFORMATION_SCHEMA.COLUMNS c
LEFT JOIN DataDictionary dd
    ON c.COLUMN_NAME = dd.Entity
    AND c.TABLE_NAME = dd.Parent_Entity
    AND dd.Entity_Type = 'Column'
WHERE c.TABLE_SCHEMA = DATABASE()
    AND dd.DataDictionary_ID IS NULL

UNION ALL

-- Documentation for non-existent tables
SELECT
    'ORPHANED_TABLE_DOC' AS validation_type,
    dd.Entity AS entity_name,
    NULL AS column_name,
    'DataDictionary entry for non-existent table' AS issue,
    'HIGH' AS severity,
    3 AS sort_order
FROM DataDictionary dd
LEFT JOIN INFORMATION_SCHEMA.TABLES t
    ON dd.Entity = t.TABLE_NAME
WHERE dd.Entity_Type = 'Table'
    AND dd.Parent_Entity IS NULL
    AND t.TABLE_NAME IS NULL

UNION ALL

-- Documentation for non-existent columns
SELECT
    'ORPHANED_COLUMN_DOC' AS validation_type,
    dd.Parent_Entity AS entity_name,
    dd.Entity AS column_name,
    'DataDictionary entry for non-existent column' AS issue,
    'HIGH' AS severity,
    4 AS sort_order
FROM DataDictionary dd
LEFT JOIN INFORMATION_SCHEMA.COLUMNS c
    ON dd.Entity = c.COLUMN_NAME
    AND dd.Parent_Entity = c.TABLE_NAME
WHERE dd.Entity_Type = 'Column'
    AND c.COLUMN_NAME IS NULL

UNION ALL

-- Missing descriptions
SELECT
    'MISSING_DESCRIPTION' AS validation_type,
    CASE
        WHEN dd.Entity_Type = 'Table' THEN dd.Entity
        ELSE dd.Parent_Entity
    END AS entity_name,
    CASE
        WHEN dd.Entity_Type = 'Column' THEN dd.Entity
        ELSE NULL
    END AS column_name,
    'Entry missing description' AS issue,
    'LOW' AS severity,
    5 AS sort_order
FROM DataDictionary dd
WHERE (dd.Description IS NULL OR TRIM(dd.Description) = '')

UNION ALL

-- Views in schema but not documented
SELECT
    'MISSING_VIEW' AS validation_type,
    t.TABLE_NAME AS entity_name,
    NULL AS column_name,
    'View exists but not in DataDictionary' AS issue,
    'MEDIUM' AS severity,
    6 AS sort_order
FROM INFORMATION_SCHEMA.TABLES t
LEFT JOIN DataDictionary dd
    ON t.TABLE_NAME = dd.Entity
    AND dd.Entity_Type = 'View'
    AND dd.Parent_Entity IS NULL
WHERE t.TABLE_SCHEMA = DATABASE()
    AND t.TABLE_TYPE = 'VIEW'
    AND dd.DataDictionary_ID IS NULL

ORDER BY sort_order, severity, entity_name, column_name;


-- Summary view showing counts by validation type
CREATE VIEW vw_DataDictionary_Validation_Summary AS
SELECT
    validation_type,
    severity,
    COUNT(*) AS issue_count
FROM vw_DataDictionary_Validation
GROUP BY validation_type, severity
ORDER BY
    FIELD(severity, 'HIGH', 'MEDIUM', 'LOW'),
    validation_type;


-- Coverage statistics view
CREATE VIEW vw_DataDictionary_Coverage AS
SELECT
    'Tables' AS entity_category,
    COUNT(DISTINCT t.TABLE_NAME) AS total_entities,
    COUNT(DISTINCT dd.Entity) AS documented_entities,
    ROUND(COUNT(DISTINCT dd.Entity) * 100.0 / COUNT(DISTINCT t.TABLE_NAME), 2) AS coverage_percent
FROM INFORMATION_SCHEMA.TABLES t
LEFT JOIN DataDictionary dd
    ON t.TABLE_NAME = dd.Entity
    AND dd.Entity_Type = 'Table'
    AND dd.Parent_Entity IS NULL
WHERE t.TABLE_SCHEMA = DATABASE()
    AND t.TABLE_TYPE = 'BASE TABLE'

UNION ALL

SELECT
    'Columns' AS entity_category,
    COUNT(*) AS total_entities,
    COUNT(dd.DataDictionary_ID) AS documented_entities,
    ROUND(COUNT(dd.DataDictionary_ID) * 100.0 / COUNT(*), 2) AS coverage_percent
FROM INFORMATION_SCHEMA.COLUMNS c
LEFT JOIN DataDictionary dd
    ON c.COLUMN_NAME = dd.Entity
    AND c.TABLE_NAME = dd.Parent_Entity
    AND dd.Entity_Type = 'Column'
WHERE c.TABLE_SCHEMA = DATABASE()

UNION ALL

SELECT
    'Views' AS entity_category,
    COUNT(DISTINCT t.TABLE_NAME) AS total_entities,
    COUNT(DISTINCT dd.Entity) AS documented_entities,
    ROUND(COUNT(DISTINCT dd.Entity) * 100.0 / NULLIF(COUNT(DISTINCT t.TABLE_NAME), 0), 2) AS coverage_percent
FROM INFORMATION_SCHEMA.TABLES t
LEFT JOIN DataDictionary dd
    ON t.TABLE_NAME = dd.Entity
    AND dd.Entity_Type = 'View'
    AND dd.Parent_Entity IS NULL
WHERE t.TABLE_SCHEMA = DATABASE()
    AND t.TABLE_TYPE = 'VIEW';
