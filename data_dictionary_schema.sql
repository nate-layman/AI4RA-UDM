CREATE TABLE udm_data_dictionary (
    entity_id INT IDENTITY(1,1) PRIMARY KEY,     -- Unique ID for each row
    entity_name VARCHAR(255) NOT NULL,           -- Canonical name of the variable or table
    entity_type VARCHAR(50) NOT NULL,            -- 'Table' or 'Variable'
    description VARCHAR(1000),                   -- Plain-English definition of the entity
    synonyms VARCHAR(1000),                      -- Other names used in systems, reports, or by teams
    context VARCHAR(1000),                       -- Where this entity exists (tables, datasets, reports)
    notes VARCHAR(2000),                         -- Optional clarifications, business rules, or extra info
    category VARCHAR(255),                        -- Optional grouping, e.g., People, Project, Funding, Compliance
    sensitivity VARCHAR(100),                     -- Optional: PII / Sensitive / Public
    created_at DATETIME DEFAULT GETDATE(),       -- Timestamp for creation
    updated_at DATETIME DEFAULT GETDATE()        -- Timestamp for last update
);
