-- Sample Data for Research Administration Unified Data Model
-- This file provides realistic sample data for all tables

-- AllowedValues
INSERT INTO AllowedValues (Allowed_Value_Group, Allowed_Value_Code, Allowed_Value_Label, Allowed_Value_Description) VALUES
('CONTACT_TYPE', 'EMAIL', 'Email', 'Email address'),
('CONTACT_TYPE', 'PHONE', 'Phone', 'Telephone number'),
('CONTACT_TYPE', 'FAX', 'Fax', 'Fax number'),
('CONTACT_TYPE', 'MOBILE', 'Mobile', 'Mobile phone number'),
('PROJECT_ROLE', 'PI', 'Principal Investigator', 'Lead scientist responsible for project'),
('PROJECT_ROLE', 'CO_PI', 'Co-Principal Investigator', 'Co-lead scientist with equal responsibility'),
('PROJECT_ROLE', 'CO_I', 'Co-Investigator', 'Contributing scientist'),
('PROJECT_ROLE', 'KEY_PERSONNEL', 'Key Personnel', 'Critical project contributor'),
('PROJECT_ROLE', 'COORDINATOR', 'Project Coordinator', 'Administrative coordination'),
('FUND_TYPE', 'SPONSORED', 'Sponsored Research', 'External sponsored research funds'),
('FUND_TYPE', 'INTERNAL', 'Internal Funds', 'Institutional internal funds'),
('FUND_TYPE', 'GIFT', 'Gift Funds', 'Philanthropic gift funds'),
('FUND_TYPE', 'ENDOWMENT', 'Endowment', 'Endowment income funds'),
('TRANSACTION_TYPE', 'EXPENSE', 'Expense', 'Expenditure transaction'),
('TRANSACTION_TYPE', 'REVENUE', 'Revenue', 'Revenue receipt'),
('TRANSACTION_TYPE', 'ENCUMBRANCE', 'Encumbrance', 'Committed funds not yet spent'),
('TRANSACTION_TYPE', 'TRANSFER', 'Transfer', 'Transfer between accounts'),
('TRANSACTION_TYPE', 'ADJUSTMENT', 'Adjustment', 'Correcting adjustment'),
('TRANSACTION_TYPE', 'REVERSAL', 'Reversal', 'Reversal of prior transaction'),
('TRANSACTION_TYPE', 'COST_SHARE', 'Cost Share', 'Cost sharing contribution'),
('MODIFICATION_EVENT', 'INITIAL', 'Initial Award', 'Initial award setup'),
('MODIFICATION_EVENT', 'FUNDING', 'Incremental Funding', 'Additional funding provided'),
('MODIFICATION_EVENT', 'NCE', 'No Cost Extension', 'Extension without additional funding'),
('MODIFICATION_EVENT', 'BUDGET_REV', 'Budget Revision', 'Budget reallocation'),
('MODIFICATION_EVENT', 'SCOPE_CHANGE', 'Scope Change', 'Change in project scope'),
('MODIFICATION_EVENT', 'PERSONNEL', 'Personnel Change', 'Change in key personnel'),
('MODIFICATION_EVENT', 'TERMINATION', 'Termination', 'Award termination'),
('MODIFICATION_EVENT', 'SUPPLEMENT', 'Supplement', 'Supplemental funding'),
('DELIVERABLE_TYPE', 'TECH_REPORT', 'Technical Progress Report', 'Technical progress report'),
('DELIVERABLE_TYPE', 'FIN_REPORT', 'Financial Report', 'Financial status report'),
('DELIVERABLE_TYPE', 'ANNUAL', 'Annual Report', 'Annual progress report'),
('DELIVERABLE_TYPE', 'FINAL_TECH', 'Final Technical Report', 'Final technical report'),
('DELIVERABLE_TYPE', 'FINAL_FIN', 'Final Financial Report', 'Final financial report'),
('DELIVERABLE_TYPE', 'INVENTION', 'Invention Disclosure', 'Invention or patent disclosure'),
('DELIVERABLE_TYPE', 'PUBLICATION', 'Publication', 'Research publication'),
('PROJECT_TYPE', 'RESEARCH', 'Research', 'Research project'),
('PROJECT_TYPE', 'TRAINING', 'Training', 'Training or education project'),
('PROJECT_TYPE', 'SERVICE', 'Service', 'Service or outreach project'),
('PROJECT_TYPE', 'CLINICAL', 'Clinical Trial', 'Clinical trial'),
('PROJECT_TYPE', 'FELLOWSHIP', 'Fellowship', 'Fellowship program'),
('FINANCE_PURPOSE', 'DIRECT', 'Direct Costs', 'Direct project costs'),
('FINANCE_PURPOSE', 'COST_SHARE', 'Cost Share', 'Cost sharing funds'),
('FINANCE_PURPOSE', 'INDIRECT', 'Indirect Costs', 'Indirect cost recovery'),
('FINANCE_PURPOSE', 'SUBCONTRACT', 'Subcontract', 'Subcontract funds'),
('COI_RELATIONSHIP', 'FINANCIAL', 'Financial', 'Financial interest'),
('COI_RELATIONSHIP', 'CONSULTING', 'Consulting', 'Consulting relationship'),
('COI_RELATIONSHIP', 'EMPLOYMENT', 'Employment', 'Employment relationship'),
('COI_RELATIONSHIP', 'EQUITY', 'Equity', 'Equity ownership'),
('COI_RELATIONSHIP', 'IP', 'Intellectual Property', 'IP rights'),
('DOCUMENT_TYPE', 'PROPOSAL', 'Proposal', 'Grant proposal document'),
('DOCUMENT_TYPE', 'AWARD_NOTICE', 'Award Notice', 'Official award notification'),
('DOCUMENT_TYPE', 'PROGRESS_REPORT', 'Progress Report', 'Progress report document'),
('DOCUMENT_TYPE', 'FINANCIAL_REPORT', 'Financial Report', 'Financial report document'),
('DOCUMENT_TYPE', 'CONTRACT', 'Contract', 'Contract document'),
('DOCUMENT_TYPE', 'CORRESPONDENCE', 'Correspondence', 'Email or letter correspondence'),
('DOCUMENT_TYPE', 'BUDGET', 'Budget', 'Budget document'),
('DOCUMENT_TYPE', 'SOW', 'Statement of Work', 'Statement of work document'),
('DOCUMENT_TYPE', 'COMPLIANCE', 'Compliance Approval', 'Compliance approval certificate');

-- BudgetCategory
INSERT INTO BudgetCategory (Category_Code, Category_Name, Category_Description) VALUES
('A', 'Senior Personnel', 'Salaries and wages for senior personnel'),
('B', 'Other Personnel', 'Salaries and wages for other personnel'),
('C', 'Fringe Benefits', 'Fringe benefits for all personnel'),
('D', 'Equipment', 'Equipment costing $5,000 or more'),
('E', 'Travel', 'Domestic and foreign travel'),
('F', 'Participant Support', 'Participant support costs'),
('G', 'Other Direct', 'Other direct costs'),
('H', 'MTDC', 'Modified Total Direct Costs'),
('I', 'Indirect Costs', 'Facilities and administrative costs'),
('J', 'Total', 'Total project costs'),
('K', 'Subcontract', 'Subcontract costs'),
('L', 'Consultant', 'Consultant services'),
('M', 'Materials', 'Materials and supplies'),
('N', 'Publication', 'Publication costs');

-- Organization
INSERT INTO Organization (Organization_ID, Organization_Name, Organization_Type, Parent_Organization_ID, UEI) VALUES
('INST001', 'State University', 'Institute', NULL, 'SU1234567890'),
('COLL001', 'College of Engineering', 'College', 'INST001', NULL),
('COLL002', 'College of Medicine', 'College', 'INST001', NULL),
('COLL003', 'College of Arts and Sciences', 'College', 'INST001', NULL),
('DEPT001', 'Department of Computer Science', 'Department', 'COLL001', NULL),
('DEPT002', 'Department of Biomedical Engineering', 'Department', 'COLL001', NULL),
('DEPT003', 'Department of Internal Medicine', 'Department', 'COLL002', NULL),
('DEPT004', 'Department of Chemistry', 'Department', 'COLL003', NULL),
('SPON001', 'National Institutes of Health', 'Sponsor', NULL, 'NIH123456789'),
('SPON002', 'National Science Foundation', 'Sponsor', NULL, 'NSF123456789'),
('SPON003', 'Department of Defense', 'Sponsor', NULL, 'DOD123456789'),
('SPON004', 'Department of Energy', 'Sponsor', NULL, 'DOE123456789'),
('SPON005', 'Acme Research Foundation', 'Sponsor', NULL, 'ARF123456789'),
('SPON006', 'TechCorp Industries', 'Sponsor', NULL, 'TCI123456789'),
('SUBRE001', 'Tech Research Institute', 'Subrecipient', NULL, 'TRI123456789'),
('SUBRE002', 'Metro University', 'Subrecipient', NULL, 'MET123456789'),
('VEND001', 'Lab Equipment Supply Co', 'Vendor', NULL, NULL),
('VEND002', 'Office Supplies Plus', 'Vendor', NULL, NULL);

-- Personnel
INSERT INTO Personnel (Personnel_ID, ORCID, First_Name, Last_Name, Middle_Name, Institutional_ID, Primary_Email, Person_Type, Department_Organization_ID) VALUES
('P001', '0000-0001-2345-6789', 'Jane', 'Smith', 'A', 'JS12345', 'jane.smith@stateuniversity.edu', 'Faculty', 'DEPT001'),
('P002', '0000-0002-3456-7890', 'John', 'Doe', 'B', 'JD23456', 'john.doe@stateuniversity.edu', 'Faculty', 'DEPT002'),
('P003', '0000-0003-4567-8901', 'Maria', 'Garcia', NULL, 'MG34567', 'maria.garcia@stateuniversity.edu', 'Faculty', 'DEPT003'),
('P004', '0000-0004-5678-9012', 'David', 'Chen', 'L', 'DC45678', 'david.chen@stateuniversity.edu', 'Faculty', 'DEPT004'),
('P005', NULL, 'Sarah', 'Johnson', 'M', 'SJ56789', 'sarah.johnson@stateuniversity.edu', 'Staff', 'DEPT001'),
('P006', NULL, 'Michael', 'Brown', NULL, 'MB67890', 'michael.brown@stateuniversity.edu', 'Postdoc', 'DEPT002'),
('P007', NULL, 'Emily', 'Davis', 'R', 'ED78901', 'emily.davis@stateuniversity.edu', 'Student', 'DEPT001'),
('P008', NULL, 'Robert', 'Wilson', NULL, 'RW89012', 'robert.wilson@stateuniversity.edu', 'Staff', 'INST001'),
('P009', '0000-0005-6789-0123', 'Linda', 'Martinez', 'K', 'LM90123', 'linda.martinez@stateuniversity.edu', 'Faculty', 'DEPT003'),
('P010', NULL, 'James', 'Taylor', NULL, 'JT01234', 'james.taylor@external.org', 'External', NULL);

-- Contact

Details
INSERT INTO ContactDetails (Personnel_ID, Organization_ID, AllowedValue_ID, ContactDetails_Value, Is_Primary) VALUES
('P001', NULL, 1, 'jane.smith@stateuniversity.edu', TRUE),
('P001', NULL, 2, '555-0101', FALSE),
('P002', NULL, 1, 'john.doe@stateuniversity.edu', TRUE),
('P002', NULL, 2, '555-0102', FALSE),
('P003', NULL, 1, 'maria.garcia@stateuniversity.edu', TRUE),
('P004', NULL, 1, 'david.chen@stateuniversity.edu', TRUE),
(NULL, 'SPON001', 1, 'grants@nih.gov', TRUE),
(NULL, 'SPON001', 2, '301-496-4000', TRUE),
(NULL, 'SPON002', 1, 'info@nsf.gov', TRUE),
(NULL, 'SPON002', 2, '703-292-5111', TRUE);

-- IndirectRate
INSERT INTO IndirectRate (Organization_ID, Rate_Type, Rate_Percentage, Effective_Start_Date, Effective_End_Date, Base_Type, Negotiated_Agreement_ID) VALUES
('INST001', 'On-Campus', 55.50, '2023-07-01', '2026-06-30', 'MTDC', 'NICRA-2023-001'),
('INST001', 'Off-Campus', 26.00, '2023-07-01', '2026-06-30', 'MTDC', 'NICRA-2023-001'),
('INST001', 'Fringe Benefits', 32.00, '2024-01-01', NULL, 'Salaries and Wages', 'FB-2024-001');

-- Project
INSERT INTO Project (Project_ID, Project_Title, Acronym, Parent_Project_ID, Project_Type_Value_ID, Abstract, Start_Date, End_Date, Lead_Organization_ID, Project_Status) VALUES
('PRJ001', 'Machine Learning for Medical Diagnosis', 'ML-MED', NULL, 45, 'Developing machine learning algorithms for early disease detection using medical imaging data', '2023-09-01', '2026-08-31', 'DEPT001', 'Active'),
('PRJ002', 'Sustainable Energy Systems', 'SES', NULL, 45, 'Research into renewable energy storage and distribution systems', '2024-01-01', '2027-12-31', 'DEPT002', 'Active'),
('PRJ003', 'Cancer Immunotherapy Clinical Trial', 'CICT', NULL, 47, 'Phase II clinical trial of novel immunotherapy approach', '2023-06-01', '2028-05-31', 'DEPT003', 'Active'),
('PRJ004', 'Advanced Materials Chemistry', 'AMC', NULL, 45, 'Synthesis and characterization of novel polymer materials', '2024-03-01', '2027-02-28', 'DEPT004', 'Active'),
('PRJ005', 'Graduate Training Program in Data Science', 'GTPDS', NULL, 46, 'Training program for graduate students in data science methods', '2023-08-15', '2028-08-14', 'DEPT001', 'Active');
