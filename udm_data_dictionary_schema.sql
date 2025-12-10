-- DataDictionary: Community-editable metadata about schema entities
CREATE TABLE DataDictionary (
    DataDictionary_ID INT AUTO_INCREMENT PRIMARY KEY,

    -- Entity identification
    Table_Name VARCHAR(255) NOT NULL,
    Column_Name VARCHAR(255), -- NULL for table-level documentation
    Entity_Type ENUM('Table', 'Column', 'View', 'Constraint', 'Index') NOT NULL,

    -- Core documentation
    Description TEXT,
    Business_Definition TEXT,
    Technical_Notes TEXT,
    Examples TEXT,

    -- Rich metadata
    Synonyms JSON COMMENT 'Alternative names: ["alternate_name1", "alternate_name2"]',
    Related_Entities JSON COMMENT 'Links to related tables/columns',
    Validation_Rules JSON COMMENT 'Business rules and constraints',

    -- Organization and categorization
    Schema_Domain VARCHAR(100) COMMENT 'Logical grouping: Reference, Core, PreAward, PostAward, Financial, Personnel, Compliance, System',
    Business_Category VARCHAR(100),
    Sensitivity_Level ENUM('Public', 'Internal', 'Confidential', 'Restricted'),
    PII_Flag BOOLEAN DEFAULT FALSE COMMENT 'Contains Personally Identifiable Information',

    -- Data quality metadata
    Source_System VARCHAR(100) COMMENT 'Originating system or data source',
    Data_Quality_Notes TEXT,

    -- Community editing workflow
    Proposed_By_Email VARCHAR(320),
    Approved_By_Email VARCHAR(320),
    Status ENUM('Draft', 'Proposed', 'Approved', 'Deprecated') DEFAULT 'Draft',

    -- Audit fields (Dolt tracks history, but these are helpful for queries)
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    -- Constraints
    UNIQUE KEY uq_table_column (Table_Name, Column_Name),
    INDEX idx_entity_type (Entity_Type),
    INDEX idx_table_name (Table_Name),
    INDEX idx_status (Status),
    INDEX idx_schema_domain (Schema_Domain)
) COMMENT = 'Community-editable documentation and metadata for all schema entities';

