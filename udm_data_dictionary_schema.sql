-- DataDictionary: Simplified community-editable metadata for research administration unified data model
-- Purpose: Acts as a unifying translation layer between institutional data sources and universal schema
-- Maintained by: Research administrators community

CREATE TABLE DataDictionary (
    DataDictionary_ID INT AUTO_INCREMENT PRIMARY KEY,

    -- Entity identification
    Entity VARCHAR(255) NOT NULL COMMENT 'Name of the table, column, or view being documented',
    Entity_Type ENUM('Table', 'Column', 'View') NOT NULL,
    Parent_Entity VARCHAR(255) COMMENT 'For columns: the table name; NULL for tables and views',

    -- Documentation
    Description TEXT COMMENT 'Clear description of what this entity represents',
    Synonyms TEXT COMMENT 'Comma-separated alternative names used at different institutions',

    -- Data sensitivity
    PII_Flag BOOLEAN DEFAULT FALSE COMMENT 'Contains Personally Identifiable Information',

    -- Audit fields
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    -- Constraints and indexes
    UNIQUE KEY uq_entity_parent (Entity, Parent_Entity),
    INDEX idx_entity_type (Entity_Type),
    INDEX idx_parent_entity (Parent_Entity)
) COMMENT = 'Community-editable documentation for research administration unified data model';
