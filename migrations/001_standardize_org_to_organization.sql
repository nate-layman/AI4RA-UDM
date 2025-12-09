-- Migration: Standardize Org to Organization
-- Purpose: Rename all Org_* columns to Organization_* for consistency and clarity
-- Date: 2024-12-08
-- Status: DRAFT - Review before execution

-- This migration renames columns in the following tables:
-- 1. Organization table: Org_ID -> Organization_ID, Org_Name -> Organization_Name, Org_Type -> Organization_Type
-- 2. All foreign key references across 13 tables

-- IMPORTANT: This migration should be run on a test branch first!
-- Run on test branch, verify with testing suite, then apply to main

-- ========================================
-- STEP 1: Organization Table (Primary)
-- ========================================

-- Rename primary key column
ALTER TABLE Organization CHANGE COLUMN Org_ID Organization_ID VARCHAR(50) NOT NULL;

-- Rename other columns
ALTER TABLE Organization CHANGE COLUMN Org_Name Organization_Name VARCHAR(255) NOT NULL;
ALTER TABLE Organization CHANGE COLUMN Org_Type Organization_Type VARCHAR(50) NOT NULL;
ALTER TABLE Organization CHANGE COLUMN Parent_Org_ID Parent_Organization_ID VARCHAR(50);

-- Note: Constraints will need to be recreated
ALTER TABLE Organization DROP CONSTRAINT chk_org_type;
ALTER TABLE Organization ADD CONSTRAINT chk_organization_type
    CHECK (Organization_Type IN ('Department','College','School','Sponsor','Subrecipient','Vendor','Institute','Center'));

-- Note: Foreign key will be automatically updated by ON UPDATE CASCADE

-- ========================================
-- STEP 2: Personnel Table
-- ========================================

ALTER TABLE Personnel CHANGE COLUMN Department_Org_ID Department_Organization_ID VARCHAR(50);

-- ========================================
-- STEP 3: Project Table
-- ========================================

ALTER TABLE Project CHANGE COLUMN Lead_Org_ID Lead_Organization_ID VARCHAR(50) NOT NULL;

-- ========================================
-- STEP 4: RFA Table
-- ========================================

ALTER TABLE RFA CHANGE COLUMN Sponsor_Org_ID Sponsor_Organization_ID VARCHAR(50) NOT NULL;

-- ========================================
-- STEP 5: Proposal Table
-- ========================================

ALTER TABLE Proposal CHANGE COLUMN Sponsor_Org_ID Sponsor_Organization_ID VARCHAR(50) NOT NULL;

-- ========================================
-- STEP 6: Award Table
-- ========================================

ALTER TABLE Award CHANGE COLUMN Sponsor_Org_ID Sponsor_Organization_ID VARCHAR(50) NOT NULL;
ALTER TABLE Award CHANGE COLUMN Prime_Sponsor_Org_ID Prime_Sponsor_Organization_ID VARCHAR(50);

-- ========================================
-- STEP 7: Subaward Table
-- ========================================

ALTER TABLE Subaward CHANGE COLUMN Subrecipient_Org_ID Subrecipient_Organization_ID VARCHAR(50) NOT NULL;

-- ========================================
-- STEP 8: CostShare Table
-- ========================================

ALTER TABLE CostShare CHANGE COLUMN Source_Org_ID Source_Organization_ID VARCHAR(50);

-- ========================================
-- STEP 9: Fund Table
-- ========================================

ALTER TABLE Fund CHANGE COLUMN Org_ID Organization_ID VARCHAR(50);

-- ========================================
-- STEP 10: FinanceCode Table
-- ========================================

ALTER TABLE FinanceCode CHANGE COLUMN Org_ID Organization_ID VARCHAR(50);

-- ========================================
-- STEP 11: IndirectRate Table
-- ========================================

ALTER TABLE IndirectRate CHANGE COLUMN Org_ID Organization_ID VARCHAR(50) NOT NULL;

-- ========================================
-- VERIFICATION QUERIES
-- ========================================

-- Run these after migration to verify changes

-- Check Organization table structure
DESCRIBE Organization;

-- Verify no more Org_* columns exist (should return 0 rows)
SELECT table_name, column_name
FROM information_schema.columns
WHERE table_schema = 'AI4RA-UDM'
  AND column_name LIKE 'Org_%'
  AND column_name NOT LIKE 'Organization_%'
ORDER BY table_name, column_name;

-- Verify all Organization_* columns (should return 15 rows)
SELECT table_name, column_name
FROM information_schema.columns
WHERE table_schema = 'AI4RA-UDM'
  AND column_name LIKE '%Organization%'
ORDER BY table_name, column_name;

-- Check foreign key relationships still work
SELECT
    kcu.table_name,
    kcu.column_name,
    kcu.referenced_table_name,
    kcu.referenced_column_name
FROM information_schema.key_column_usage kcu
WHERE kcu.table_schema = 'AI4RA-UDM'
  AND kcu.referenced_table_name = 'Organization'
ORDER BY kcu.table_name;
