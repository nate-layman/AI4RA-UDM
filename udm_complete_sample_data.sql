-- ============================================================================
-- UDM Complete Sample Data
-- ============================================================================
-- This file contains sample data for ALL tables in the UDM schema
-- Excludes DataDictionary which is already populated
-- ============================================================================

-- Disable foreign key checks during data load
SET FOREIGN_KEY_CHECKS = 0;

-- ============================================================================
-- TABLE 1: AllowedValues (must be first - no foreign keys, AUTO_INCREMENT)
-- ============================================================================

INSERT INTO AllowedValues (Allowed_Value_Group, Allowed_Value_Code, Allowed_Value_Label, Allowed_Value_Description) VALUES
('CONTACT_TYPE', 'EMAIL', 'Email Address', 'Primary email contact'),
('CONTACT_TYPE', 'PHONE', 'Phone Number', 'Telephone contact'),
('CONTACT_TYPE', 'FAX', 'Fax Number', 'Facsimile contact'),
('CONTACT_TYPE', 'MOBILE', 'Mobile Phone', 'Mobile telephone contact'),
('CONTACT_TYPE', 'ADDRESS', 'Mailing Address', 'Physical mailing address'),
('PROJECT_TYPE', 'RESEARCH', 'Research Project', 'Basic or applied research project'),
('PROJECT_TYPE', 'TRAINING', 'Training Grant', 'Educational or training program'),
('PROJECT_TYPE', 'SERVICE', 'Service Contract', 'Service or consulting project'),
('PROJECT_TYPE', 'CLINICAL_TRIAL', 'Clinical Trial', 'Clinical research trial'),
('ROLE_TYPE', 'PI', 'Principal Investigator', 'Lead investigator on project'),
('ROLE_TYPE', 'CO_PI', 'Co-Principal Investigator', 'Co-lead investigator'),
('ROLE_TYPE', 'ADMIN', 'Administrator', 'Project administrator'),
('ROLE_TYPE', 'COORDINATOR', 'Research Coordinator', 'Project coordinator'),
('ROLE_TYPE', 'POSTDOC', 'Postdoctoral Researcher', 'Postdoctoral researcher'),
('EVENT_TYPE', 'FUNDING_INCREASE', 'Funding Increase', 'Additional funding awarded'),
('EVENT_TYPE', 'NO_COST_EXT', 'No-Cost Extension', 'Project timeline extended without additional funds'),
('EVENT_TYPE', 'SCOPE_CHANGE', 'Scope Change', 'Project scope modified'),
('EVENT_TYPE', 'PI_CHANGE', 'PI Change', 'Principal investigator changed'),
('DELIVERABLE_TYPE', 'PROGRESS_REPORT', 'Progress Report', 'Scientific or technical progress report'),
('DELIVERABLE_TYPE', 'FINANCIAL_REPORT', 'Financial Report', 'Financial status report'),
('DELIVERABLE_TYPE', 'FINAL_REPORT', 'Final Report', 'Final project report'),
('DELIVERABLE_TYPE', 'INVENTION_REPORT', 'Invention Disclosure', 'Invention or intellectual property disclosure'),
('FUND_TYPE', 'SPONSORED', 'Sponsored Program Fund', 'Fund for sponsored research'),
('FUND_TYPE', 'UNRESTRICTED', 'Unrestricted Fund', 'Unrestricted institutional funds'),
('FUND_TYPE', 'RESTRICTED', 'Restricted Fund', 'Restricted gift or endowment'),
('PURPOSE_CODE', 'RESEARCH', 'Research Activity', 'Research-related expenditure'),
('PURPOSE_CODE', 'INSTRUCTION', 'Instructional Activity', 'Teaching-related expenditure'),
('PURPOSE_CODE', 'SERVICE', 'Service Activity', 'Service or consulting activity'),
('TRANSACTION_TYPE', 'SALARY', 'Salary Expense', 'Personnel salary charge'),
('TRANSACTION_TYPE', 'SUPPLY', 'Supply Purchase', 'Supplies and materials'),
('TRANSACTION_TYPE', 'TRAVEL', 'Travel Expense', 'Travel-related expense'),
('TRANSACTION_TYPE', 'EQUIPMENT', 'Equipment Purchase', 'Equipment acquisition'),
('RELATIONSHIP_TYPE', 'EQUITY', 'Equity Interest', 'Ownership interest in entity'),
('RELATIONSHIP_TYPE', 'CONSULTING', 'Consulting Agreement', 'Consulting or advisory relationship'),
('RELATIONSHIP_TYPE', 'BOARD', 'Board Membership', 'Board of directors membership'),
('DOCUMENT_TYPE', 'PROPOSAL_DOC', 'Proposal Document', 'Original proposal submission'),
('DOCUMENT_TYPE', 'AWARD_NOTICE', 'Award Notice', 'Official award notification'),
('DOCUMENT_TYPE', 'PROTOCOL', 'Protocol Document', 'IRB/IACUC protocol'),
('DOCUMENT_TYPE', 'REPORT', 'Report Document', 'Progress or final report'),
('DOCUMENT_TYPE', 'CONTRACT', 'Contract Document', 'Legal agreement or contract');

-- ============================================================================
-- TABLE 2: BudgetCategory (no foreign keys, AUTO_INCREMENT)
-- ============================================================================

INSERT INTO BudgetCategory (Category_Code, Category_Name, Category_Description) VALUES
('SALARY', 'Salaries and Wages', 'Personnel salaries and wages'),
('FRINGE', 'Fringe Benefits', 'Employee benefits'),
('EQUIPMENT', 'Equipment', 'Equipment over $5,000'),
('TRAVEL', 'Travel', 'Domestic and foreign travel'),
('SUPPLIES', 'Materials and Supplies', 'General supplies and materials');

-- ============================================================================
-- TABLE 3: Organization (depends on itself for parent org)
-- ============================================================================

INSERT INTO Organization (Organization_ID, Organization_Name, Organization_Type, Parent_Organization_ID, UEI) VALUES
('ORG-UNI-001', 'Research University', 'Institute', NULL, 'ABCD12345678'),
('ORG-ENG-001', 'College of Engineering', 'College', 'ORG-UNI-001', NULL),
('ORG-MED-001', 'School of Medicine', 'School', 'ORG-UNI-001', NULL),
('ORG-NIH-001', 'National Institutes of Health', 'Sponsor', NULL, 'NIH123456789'),
('ORG-NSF-001', 'National Science Foundation', 'Sponsor', NULL, 'NSF987654321'),
('ORG-SUB-001', 'Partner Research Institute', 'Subrecipient', NULL, 'PRI111222333');

-- ============================================================================
-- TABLE 4: Personnel (depends on Organization)
-- ============================================================================

INSERT INTO Personnel (Personnel_ID, ORCID, First_Name, Last_Name, Middle_Name, Institutional_ID, Primary_Email, Person_Type, Department_Organization_ID) VALUES
('PER-001', '0000-0001-2345-6789', 'Sarah', 'Johnson', 'Marie', 'EMP001234', 'sjohnson@university.edu', 'Faculty', 'ORG-ENG-001'),
('PER-002', '0000-0002-3456-7890', 'Michael', 'Chen', 'Wei', 'EMP002345', 'mchen@university.edu', 'Faculty', 'ORG-MED-001'),
('PER-003', NULL, 'Jennifer', 'Martinez', 'Ann', 'EMP003456', 'jmartinez@university.edu', 'Staff', 'ORG-ENG-001'),
('PER-004', '0000-0003-4567-8901', 'Robert', 'Anderson', 'James', 'EMP004567', 'randerson@university.edu', 'Postdoc', 'ORG-MED-001'),
('PER-005', NULL, 'Emily', 'Davis', NULL, 'EMP005678', 'edavis@university.edu', 'Staff', 'ORG-UNI-001');

-- ============================================================================
-- TABLE 5: ContactDetails (depends on Personnel, Organization, AllowedValues)
-- ============================================================================

INSERT INTO ContactDetails (Personnel_ID, Organization_ID, AllowedValue_ID, ContactDetails_Value, Is_Primary) VALUES
('PER-001', NULL, (SELECT Allowed_Value_ID FROM AllowedValues WHERE Allowed_Value_Group='CONTACT_TYPE' AND Allowed_Value_Code='PHONE'), '+1-555-0101', TRUE),
('PER-002', NULL, (SELECT Allowed_Value_ID FROM AllowedValues WHERE Allowed_Value_Group='CONTACT_TYPE' AND Allowed_Value_Code='PHONE'), '+1-555-0102', TRUE),
('PER-003', NULL, (SELECT Allowed_Value_ID FROM AllowedValues WHERE Allowed_Value_Group='CONTACT_TYPE' AND Allowed_Value_Code='MOBILE'), '+1-555-0103', FALSE),
(NULL, 'ORG-NIH-001', (SELECT Allowed_Value_ID FROM AllowedValues WHERE Allowed_Value_Group='CONTACT_TYPE' AND Allowed_Value_Code='PHONE'), '+1-301-496-4000', TRUE),
(NULL, 'ORG-NSF-001', (SELECT Allowed_Value_ID FROM AllowedValues WHERE Allowed_Value_Group='CONTACT_TYPE' AND Allowed_Value_Code='PHONE'), '+1-703-292-5111', TRUE);

-- ============================================================================
-- TABLE 6: IndirectRate (depends on Organization)
-- ============================================================================

INSERT INTO IndirectRate (Organization_ID, Rate_Type, Rate_Percentage, Effective_Start_Date, Effective_End_Date, Base_Type, Negotiated_Agreement_ID) VALUES
('ORG-UNI-001', 'On-Campus', 56.00, '2024-07-01', '2025-06-30', 'MTDC', 'AGR-2024-001'),
('ORG-UNI-001', 'Off-Campus', 26.00, '2024-07-01', '2025-06-30', 'MTDC', 'AGR-2024-001'),
('ORG-UNI-001', 'Fringe Benefits', 32.50, '2024-07-01', '2025-06-30', 'Salaries and Wages', 'AGR-2024-002'),
('ORG-SUB-001', 'On-Campus', 50.00, '2024-01-01', '2024-12-31', 'MTDC', 'AGR-2024-003');

-- ============================================================================
-- TABLE 7: Project (depends on Organization, AllowedValues)
-- ============================================================================

INSERT INTO Project (Project_ID, Project_Title, Acronym, Parent_Project_ID, Project_Type_Value_ID, Abstract, Start_Date, End_Date, Lead_Organization_ID, Project_Status) VALUES
('PRJ-001', 'Advanced Machine Learning for Healthcare Applications', 'ML4Health', NULL, (SELECT Allowed_Value_ID FROM AllowedValues WHERE Allowed_Value_Group='PROJECT_TYPE' AND Allowed_Value_Code='RESEARCH'), 'This project develops novel machine learning algorithms to improve diagnostic accuracy in medical imaging.', '2024-01-01', '2026-12-31', 'ORG-UNI-001', 'Active'),
('PRJ-002', 'Renewable Energy Grid Integration Study', 'REGIS', NULL, (SELECT Allowed_Value_ID FROM AllowedValues WHERE Allowed_Value_Group='PROJECT_TYPE' AND Allowed_Value_Code='RESEARCH'), 'Research on integrating renewable energy sources into existing power grid infrastructure.', '2024-03-01', '2027-02-28', 'ORG-UNI-001', 'Active'),
('PRJ-003', 'Biomedical Research Training Program', 'BRTP', NULL, (SELECT Allowed_Value_ID FROM AllowedValues WHERE Allowed_Value_Group='PROJECT_TYPE' AND Allowed_Value_Code='TRAINING'), 'Training program for graduate students in biomedical research methodologies.', '2023-09-01', '2028-08-31', 'ORG-UNI-001', 'Active'),
('PRJ-004', 'Cancer Immunotherapy Clinical Trial', 'CICT', NULL, (SELECT Allowed_Value_ID FROM AllowedValues WHERE Allowed_Value_Group='PROJECT_TYPE' AND Allowed_Value_Code='CLINICAL_TRIAL'), 'Phase II clinical trial evaluating novel immunotherapy approaches for cancer treatment.', '2024-06-01', '2027-05-31', 'ORG-UNI-001', 'Active');

-- ============================================================================
-- TABLE 8: RFA (depends on Organization)
-- ============================================================================

INSERT INTO RFA (RFA_ID, Sponsor_Organization_ID, RFA_Number, RFA_Title, Program_Code, Announcement_URL, Opportunity_Number, CFDA_Number) VALUES
('RFA-001', 'ORG-NIH-001', 'RFA-HL-24-001', 'Artificial Intelligence in Medical Imaging', 'HL', 'https://grants.nih.gov/grants/guide/rfa-files/RFA-HL-24-001.html', 'PA-24-001', '93.837'),
('RFA-002', 'ORG-NSF-001', 'NSF 24-500', 'Smart and Connected Communities', 'CISE', 'https://www.nsf.gov/pubs/2024/nsf24500/nsf24500.htm', 'PD-24-1234', '47.070'),
('RFA-003', 'ORG-NIH-001', 'PAR-23-145', 'Biomedical Research Training Programs', 'GM', 'https://grants.nih.gov/grants/guide/pa-files/PAR-23-145.html', 'PA-23-145', '93.859');

-- ============================================================================
-- TABLE 9: Proposal (depends on Project, Organization, RFA)
-- ============================================================================

INSERT INTO Proposal (Proposal_ID, Proposal_Number, Proposal_Title, Project_ID, Sponsor_Organization_ID, Submitting_Organization_ID, Administering_Organization_ID, RFA_ID, Previous_Proposal_ID, Submission_Version, Proposed_Start_Date, Proposed_End_Date, Total_Proposed_Direct, Total_Proposed_Indirect, Total_Proposed_Budget, Submission_Deadline, Submission_Date, Internal_Approval_Status, Decision_Status, Decision_Date, PAF_Routing_Status) VALUES
('PROP-001', 'P001-2024', 'Advanced Machine Learning for Healthcare Applications', 'PRJ-001', 'ORG-NIH-001', 'ORG-UNI-001', 'ORG-UNI-001', 'RFA-001', NULL, 1, '2024-01-01', '2026-12-31', 450000.00, 252000.00, 702000.00, '2023-10-15', '2023-10-10', 'Approved', 'Awarded', '2023-12-01', 'Complete'),
('PROP-002', 'P002-2024', 'Renewable Energy Grid Integration Study', 'PRJ-002', 'ORG-NSF-001', 'ORG-UNI-001', 'ORG-UNI-001', 'RFA-002', NULL, 1, '2024-03-01', '2027-02-28', 380000.00, 212800.00, 592800.00, '2023-12-01', '2023-11-28', 'Approved', 'Awarded', '2024-02-15', 'Complete'),
('PROP-003', 'P003-2023', 'Biomedical Research Training Program', 'PRJ-003', 'ORG-NIH-001', 'ORG-UNI-001', 'ORG-UNI-001', 'RFA-003', NULL, 1, '2023-09-01', '2028-08-31', 1500000.00, 840000.00, 2340000.00, '2023-05-01', '2023-04-28', 'Approved', 'Awarded', '2023-07-20', 'Complete');

-- ============================================================================
-- TABLE 10: ProposalBudget (depends on Proposal, BudgetCategory, IndirectRate)
-- ============================================================================

INSERT INTO ProposalBudget (Proposal_ID, Period_Number, BudgetCategory_ID, Line_Item_Description, Direct_Cost, Indirect_Cost, Total_Cost, Quantity, Unit_Cost, Applied_Indirect_Rate_ID, Rate_Base_Used, Version_No) VALUES
('PROP-001', 1, (SELECT BudgetCategory_ID FROM BudgetCategory WHERE Category_Code='SALARY'), 'PI Salary - Sarah Johnson', 120000.00, 67200.00, 187200.00, 1.00, 120000.00, 1, 'MTDC', 1),
('PROP-001', 1, (SELECT BudgetCategory_ID FROM BudgetCategory WHERE Category_Code='FRINGE'), 'Fringe Benefits', 39000.00, 0.00, 39000.00, 1.00, 39000.00, NULL, NULL, 1),
('PROP-001', 1, (SELECT BudgetCategory_ID FROM BudgetCategory WHERE Category_Code='EQUIPMENT'), 'High-Performance Computing Cluster', 75000.00, 0.00, 75000.00, 1.00, 75000.00, NULL, NULL, 1),
('PROP-002', 1, (SELECT BudgetCategory_ID FROM BudgetCategory WHERE Category_Code='SALARY'), 'PI Salary - Michael Chen', 100000.00, 56000.00, 156000.00, 1.00, 100000.00, 1, 'MTDC', 1),
('PROP-003', 1, (SELECT BudgetCategory_ID FROM BudgetCategory WHERE Category_Code='SALARY'), 'Program Director Salary', 150000.00, 84000.00, 234000.00, 1.00, 150000.00, 1, 'MTDC', 1);

-- ============================================================================
-- TABLE 11: Award (depends on Project, Organization, RFA, Proposal)
-- ============================================================================

INSERT INTO Award (Award_ID, Award_Number, Award_Title, Project_ID, Sponsor_Organization_ID, RFA_ID, Proposal_ID, Original_Start_Date, Original_End_Date, Current_Total_Funded, Current_End_Date, Total_Anticipated_Funding, Award_Status, CFDA_Number, Federal_Award_ID, Prime_Sponsor_Organization_ID, Flow_Through_Indicator) VALUES
('AWD-001', 'R01HL123456', 'Advanced Machine Learning for Healthcare Applications', 'PRJ-001', 'ORG-NIH-001', 'RFA-001', 'PROP-001', '2024-01-01', '2026-12-31', 702000.00, '2026-12-31', 702000.00, 'Active', '93.837', 'R01HL123456-01', NULL, FALSE),
('AWD-002', 'NSF-2401234', 'Renewable Energy Grid Integration Study', 'PRJ-002', 'ORG-NSF-001', 'RFA-002', 'PROP-002', '2024-03-01', '2027-02-28', 592800.00, '2027-02-28', 592800.00, 'Active', '47.070', 'NSF-2401234', NULL, FALSE),
('AWD-003', 'T32GM987654', 'Biomedical Research Training Program', 'PRJ-003', 'ORG-NIH-001', 'RFA-003', 'PROP-003', '2023-09-01', '2028-08-31', 2340000.00, '2028-08-31', 2340000.00, 'Active', '93.859', 'T32GM987654-01', NULL, FALSE);

-- ============================================================================
-- TABLE 12: Modification (depends on Award, Personnel, AllowedValues)
-- ============================================================================

INSERT INTO Modification (Modification_ID, Award_ID, Modification_Number, Event_Type_Value_ID, Event_Timestamp, Effective_Date, Funding_Amount_Change, New_End_Date, Affected_Personnel_ID, Change_Description, Justification, Impact_on_Budget, Requires_Prior_Approval, Approval_Status, Approved_By_Personnel_ID, Approval_Date) VALUES
('MOD-001', 'AWD-001', 'A01', (SELECT Allowed_Value_ID FROM AllowedValues WHERE Allowed_Value_Group='EVENT_TYPE' AND Allowed_Value_Code='FUNDING_INCREASE'), '2024-06-15 10:30:00', '2024-07-01', 50000.00, NULL, NULL, 'Supplemental funding for additional computing resources', 'Additional data analysis requirements identified', TRUE, FALSE, 'Not Required', NULL, NULL),
('MOD-002', 'AWD-002', 'A01', (SELECT Allowed_Value_ID FROM AllowedValues WHERE Allowed_Value_Group='EVENT_TYPE' AND Allowed_Value_Code='NO_COST_EXT'), '2025-01-10 14:20:00', '2025-03-01', 0.00, '2027-08-31', NULL, 'Six-month no-cost extension', 'Delays due to equipment procurement', FALSE, TRUE, 'Approved', 'PER-005', '2025-02-01'),
('MOD-003', 'AWD-001', 'A02', (SELECT Allowed_Value_ID FROM AllowedValues WHERE Allowed_Value_Group='EVENT_TYPE' AND Allowed_Value_Code='PI_CHANGE'), '2024-09-01 09:00:00', '2024-09-15', 0.00, NULL, 'PER-001', 'PI sabbatical - Co-PI taking lead role temporarily', 'PI on sabbatical for one semester', FALSE, TRUE, 'Approved', 'PER-005', '2024-08-20');

-- ============================================================================
-- TABLE 13: Terms (depends on Award)
-- ============================================================================

INSERT INTO Terms (Award_ID, Payment_Method, Invoicing_Frequency, Invoice_Submission_Days, Reporting_Requirements, Special_Conditions, Property_Requirements, Publication_Requirements, Closeout_Requirements, Record_Retention_Years) VALUES
('AWD-001', 'Reimbursement', 'Quarterly', 30, 'Annual progress reports required; Final technical report due 90 days after project end', 'Human subjects research approved under IRB protocol 2023-001', 'Equipment over $5,000 must be reported in annual inventory', 'Acknowledge NIH support in all publications', 'Final financial report and Federal Financial Report (FFR) due 120 days after project end', 3),
('AWD-002', 'Advance', 'Quarterly', 45, 'Annual project reports required; Final report due 90 days after project end', 'Cost sharing of $50,000 required', 'None specified', 'Acknowledge NSF support; submit publications to NSF Public Access Repository', 'Final project report due 90 days after project end', 3),
('AWD-003', 'Letter-of-Credit', 'Monthly', 15, 'Annual progress reports; trainee appointment data; final progress report', 'Must maintain minimum of 6 predoctoral trainees', 'None', 'Acknowledge NIH training grant support', 'Final progress report and trainee appointment data due 90 days after end', 3);

-- ============================================================================
-- TABLE 14: AwardBudgetPeriod (depends on Award)
-- ============================================================================

INSERT INTO AwardBudgetPeriod (Award_ID, Period_Number, Start_Date, End_Date, Direct_Costs, Indirect_Costs, Total_Costs, Cost_Share_Amount, Period_Status) VALUES
('AWD-001', 1, '2024-01-01', '2024-12-31', 150000.00, 84000.00, 234000.00, 0.00, 'Active'),
('AWD-001', 2, '2025-01-01', '2025-12-31', 150000.00, 84000.00, 234000.00, 0.00, 'Released'),
('AWD-001', 3, '2026-01-01', '2026-12-31', 150000.00, 84000.00, 234000.00, 0.00, 'Pending'),
('AWD-002', 1, '2024-03-01', '2025-02-28', 126933.33, 70922.67, 197856.00, 16666.67, 'Active'),
('AWD-003', 1, '2023-09-01', '2024-08-31', 300000.00, 168000.00, 468000.00, 0.00, 'Closed');

-- ============================================================================
-- TABLE 15: AwardBudget (depends on Award, AwardBudgetPeriod, BudgetCategory)
-- ============================================================================

INSERT INTO AwardBudget (Award_ID, AwardBudgetPeriod_ID, BudgetCategory_ID, Line_Item_Description, Approved_Direct_Cost, Approved_Indirect_Cost, Approved_Total_Cost, Current_Direct_Cost, Current_Indirect_Cost, Current_Total_Cost, Rate_Base_Used) VALUES
(
    'AWD-001',
    (SELECT AwardBudgetPeriod_ID FROM AwardBudgetPeriod WHERE Award_ID='AWD-001' AND Period_Number=1),
    (SELECT BudgetCategory_ID FROM BudgetCategory WHERE Category_Code='SALARY'),
    'PI Salary',
    120000.00, 67200.00, 187200.00, 120000.00, 67200.00, 187200.00, 'MTDC'
),
(
    'AWD-001',
    (SELECT AwardBudgetPeriod_ID FROM AwardBudgetPeriod WHERE Award_ID='AWD-001' AND Period_Number=1),
    (SELECT BudgetCategory_ID FROM BudgetCategory WHERE Category_Code='FRINGE'),
    'Fringe Benefits',
    30000.00, 0.00, 30000.00, 30000.00, 0.00, 30000.00, NULL
),
(
    'AWD-002',
    (SELECT AwardBudgetPeriod_ID FROM AwardBudgetPeriod WHERE Award_ID='AWD-002' AND Period_Number=1),
    (SELECT BudgetCategory_ID FROM BudgetCategory WHERE Category_Code='SALARY'),
    'Personnel Salaries',
    100000.00, 56000.00, 156000.00, 100000.00, 56000.00, 156000.00, 'MTDC'
),
(
    'AWD-003',
    (SELECT AwardBudgetPeriod_ID FROM AwardBudgetPeriod WHERE Award_ID='AWD-003' AND Period_Number=1),
    (SELECT BudgetCategory_ID FROM BudgetCategory WHERE Category_Code='SALARY'),
    'Trainee Stipends',
    200000.00, 112000.00, 312000.00, 200000.00, 112000.00, 312000.00, 'MTDC'
);

-- ============================================================================
-- TABLE 16: Subaward (depends on Award, Organization)
-- ============================================================================

INSERT INTO Subaward (Subaward_ID, Prime_Award_ID, Subrecipient_Organization_ID, Subaward_Number, Subaward_Amount, Start_Date, End_Date, Subaward_Status, Statement_of_Work, PI_Name, Monitoring_Plan, Risk_Level) VALUES
('SUB-001', 'AWD-001', 'ORG-SUB-001', 'SUB-AWD-001-001', 150000.00, '2024-02-01', '2026-12-31', 'Active', 'Subrecipient will conduct data collection and preliminary analysis for machine learning model development', 'Dr. David Liu', 'Annual site visits; quarterly financial and progress reports; annual risk assessment', 'Low'),
('SUB-002', 'AWD-002', 'ORG-SUB-001', 'SUB-AWD-002-001', 100000.00, '2024-04-01', '2027-02-28', 'Active', 'Subrecipient will perform grid modeling simulations and provide technical expertise', 'Dr. Maria Rodriguez', 'Quarterly progress reports; semi-annual financial reviews', 'Low');

-- ============================================================================
-- TABLE 17: CostShare (depends on Award, Organization)
-- ============================================================================

INSERT INTO CostShare (Award_ID, Committed_Amount, Commitment_Type, Source_Organization_ID, Source_Fund_Code, Source_Description, Is_Mandatory, CostShare_Status, Met_Amount) VALUES
('AWD-002', 50000.00, 'Cash', 'ORG-ENG-001', 'DEPT-CS-001', 'College of Engineering cost share commitment', TRUE, 'In Progress', 15000.00),
('AWD-002', 25000.00, 'In-Kind', 'ORG-UNI-001', NULL, 'Laboratory space and equipment usage', FALSE, 'In Progress', 10000.00),
('AWD-003', 100000.00, 'Waived IDC', 'ORG-UNI-001', NULL, 'Waived indirect costs on trainee stipends', TRUE, 'In Progress', 25000.00);

-- ============================================================================
-- TABLE 18: Invoice (depends on Award, AwardBudgetPeriod)
-- ============================================================================

INSERT INTO Invoice (Invoice_ID, Award_ID, Invoice_Number, AwardBudgetPeriod_ID, Invoice_Date, Period_Start_Date, Period_End_Date, Direct_Costs, Indirect_Costs, Cost_Share, Total_Amount, Invoice_Status, Submission_Date, Payment_Date, Payment_Amount) VALUES
(
    'INV-001',
    'AWD-001',
    'INV-AWD001-Q1-2024',
    (SELECT AwardBudgetPeriod_ID FROM AwardBudgetPeriod WHERE Award_ID='AWD-001' AND Period_Number=1),
    '2024-04-05', '2024-01-01', '2024-03-31',
    37500.00, 21000.00, 0.00, 58500.00,
    'Paid', '2024-04-10', '2024-05-15', 58500.00
),
(
    'INV-002',
    'AWD-001',
    'INV-AWD001-Q2-2024',
    (SELECT AwardBudgetPeriod_ID FROM AwardBudgetPeriod WHERE Award_ID='AWD-001' AND Period_Number=1),
    '2024-07-05', '2024-04-01', '2024-06-30',
    38200.00, 21392.00, 0.00, 59592.00,
    'Paid', '2024-07-10', '2024-08-12', 59592.00
),
(
    'INV-003',
    'AWD-002',
    'INV-AWD002-Q1-2024',
    (SELECT AwardBudgetPeriod_ID FROM AwardBudgetPeriod WHERE Award_ID='AWD-002' AND Period_Number=1),
    '2024-06-05', '2024-03-01', '2024-05-31',
    31500.00, 17640.00, 4166.67, 49140.00,
    'Submitted', '2024-06-10', NULL, NULL
);

-- ============================================================================
-- TABLE 19: AwardDeliverable (depends on Award, AwardBudgetPeriod, Personnel, AllowedValues)
-- ============================================================================

INSERT INTO AwardDeliverable (Award_ID, Deliverable_Type_Value_ID, AwardBudgetPeriod_ID, Deliverable_Number, Due_Date, Submission_Date, Deliverable_Status, Responsible_Personnel_ID, Reviewed_By_Personnel_ID, Review_Date, Comments) VALUES
(
    'AWD-001',
    (SELECT Allowed_Value_ID FROM AllowedValues WHERE Allowed_Value_Group='DELIVERABLE_TYPE' AND Allowed_Value_Code='PROGRESS_REPORT'),
    (SELECT AwardBudgetPeriod_ID FROM AwardBudgetPeriod WHERE Award_ID='AWD-001' AND Period_Number=1),
    'RPR-001-Y1',
    '2025-01-31', '2025-01-28', 'Accepted',
    'PER-001', 'PER-005', '2025-02-05',
    'Excellent progress on all aims'
),
(
    'AWD-002',
    (SELECT Allowed_Value_ID FROM AllowedValues WHERE Allowed_Value_Group='DELIVERABLE_TYPE' AND Allowed_Value_Code='PROGRESS_REPORT'),
    (SELECT AwardBudgetPeriod_ID FROM AwardBudgetPeriod WHERE Award_ID='AWD-002' AND Period_Number=1),
    'RPR-002-Y1',
    '2025-03-31', NULL, 'Pending',
    'PER-002', NULL, NULL, NULL
),
(
    'AWD-001',
    (SELECT Allowed_Value_ID FROM AllowedValues WHERE Allowed_Value_Group='DELIVERABLE_TYPE' AND Allowed_Value_Code='FINANCIAL_REPORT'),
    (SELECT AwardBudgetPeriod_ID FROM AwardBudgetPeriod WHERE Award_ID='AWD-001' AND Period_Number=1),
    'FFR-001-Y1',
    '2025-02-15', '2025-02-10', 'Accepted',
    'PER-003', 'PER-005', '2025-02-12',
    'Financial reporting complete and accurate'
);

-- ============================================================================
-- TABLE 20: ProjectRole (depends on Project, Personnel, Award, AllowedValues)
-- ============================================================================

INSERT INTO ProjectRole (Project_ID, Personnel_ID, Role_Value_ID, Is_Key_Personnel, Funding_Award_ID, Start_Date, End_Date, FTE_Percent, Salary_Charged) VALUES
(
    'PRJ-001',
    'PER-001',
    (SELECT Allowed_Value_ID FROM AllowedValues WHERE Allowed_Value_Group='ROLE_TYPE' AND Allowed_Value_Code='PI'),
    TRUE, 'AWD-001', '2024-01-01', '2026-12-31', 25.00, 120000.00
),
(
    'PRJ-002',
    'PER-002',
    (SELECT Allowed_Value_ID FROM AllowedValues WHERE Allowed_Value_Group='ROLE_TYPE' AND Allowed_Value_Code='PI'),
    TRUE, 'AWD-002', '2024-03-01', '2027-02-28', 30.00, 100000.00
),
(
    'PRJ-003',
    'PER-002',
    (SELECT Allowed_Value_ID FROM AllowedValues WHERE Allowed_Value_Group='ROLE_TYPE' AND Allowed_Value_Code='PI'),
    TRUE, 'AWD-003', '2023-09-01', '2028-08-31', 15.00, 150000.00
),
(
    'PRJ-001',
    'PER-004',
    (SELECT Allowed_Value_ID FROM AllowedValues WHERE Allowed_Value_Group='ROLE_TYPE' AND Allowed_Value_Code='POSTDOC'),
    TRUE, 'AWD-001', '2024-01-01', '2026-12-31', 100.00, 60000.00
),
(
    'PRJ-002',
    'PER-003',
    (SELECT Allowed_Value_ID FROM AllowedValues WHERE Allowed_Value_Group='ROLE_TYPE' AND Allowed_Value_Code='COORDINATOR'),
    FALSE, 'AWD-002', '2024-03-01', '2027-02-28', 50.00, 40000.00
);

-- ============================================================================
-- TABLE 21: Fund (depends on Organization, AllowedValues)
-- ============================================================================

INSERT INTO Fund (Fund_Code, Fund_Name, Fund_Type_Value_ID, Organization_ID) VALUES
(
    'FUND-001',
    'Sponsored Programs Fund',
    (SELECT Allowed_Value_ID FROM AllowedValues WHERE Allowed_Value_Group='FUND_TYPE' AND Allowed_Value_Code='SPONSORED'),
    'ORG-UNI-001'
),
(
    'FUND-002',
    'Unrestricted Research Fund',
    (SELECT Allowed_Value_ID FROM AllowedValues WHERE Allowed_Value_Group='FUND_TYPE' AND Allowed_Value_Code='UNRESTRICTED'),
    'ORG-UNI-001'
),
(
    'FUND-003',
    'Engineering Department Fund',
    (SELECT Allowed_Value_ID FROM AllowedValues WHERE Allowed_Value_Group='FUND_TYPE' AND Allowed_Value_Code='RESTRICTED'),
    'ORG-ENG-001'
);

-- ============================================================================
-- TABLE 22: Account (depends on itself for parent)
-- ============================================================================

INSERT INTO Account (Account_Code, Account_Name, Account_Category, Account_Type, Parent_Account_Code) VALUES
('ACCT-5000', 'Operating Expenses', 'Expenses', 'Expense', NULL),
('ACCT-5100', 'Salaries and Wages', 'Personnel', 'Expense', 'ACCT-5000'),
('ACCT-5200', 'Supplies and Materials', 'Operating', 'Expense', 'ACCT-5000'),
('ACCT-4000', 'Sponsored Revenue', 'Revenue', 'Revenue', NULL),
('ACCT-1000', 'Cash and Equivalents', 'Assets', 'Asset', NULL);

-- ============================================================================
-- TABLE 23: FinanceCode (depends on Award, Organization, AllowedValues)
-- ============================================================================

INSERT INTO FinanceCode (Finance_Code, Finance_Name, Award_ID, Purpose_Value_ID, Organization_ID) VALUES
(
    'FC-AWD001',
    'ML Healthcare Award Finance Code',
    'AWD-001',
    (SELECT Allowed_Value_ID FROM AllowedValues WHERE Allowed_Value_Group='PURPOSE_CODE' AND Allowed_Value_Code='RESEARCH'),
    'ORG-ENG-001'
),
(
    'FC-AWD002',
    'Renewable Energy Award Finance Code',
    'AWD-002',
    (SELECT Allowed_Value_ID FROM AllowedValues WHERE Allowed_Value_Group='PURPOSE_CODE' AND Allowed_Value_Code='RESEARCH'),
    'ORG-ENG-001'
),
(
    'FC-AWD003',
    'Training Program Finance Code',
    'AWD-003',
    (SELECT Allowed_Value_ID FROM AllowedValues WHERE Allowed_Value_Group='PURPOSE_CODE' AND Allowed_Value_Code='INSTRUCTION'),
    'ORG-MED-001'
);

-- ============================================================================
-- TABLE 24: Transaction (depends on Fund, Account, FinanceCode, Award, Project, AwardBudgetPeriod, Personnel, AllowedValues)
-- ============================================================================

INSERT INTO Transaction (Transaction_ID, Fund_Code, Account_Code, Finance_Code, Transaction_Date, Fiscal_Year, Fiscal_Period, Transaction_Amount, Transaction_Type_Value_ID, Description, Award_ID, Project_ID, AwardBudgetPeriod_ID, Document_Number, Journal_ID, Vendor_ID, Personnel_ID, Reference_Number, Is_Reconciled) VALUES
(
    'TXN-001',
    'FUND-001',
    'ACCT-5100',
    'FC-AWD001',
    '2024-01-15', 2024, 1, 10000.00,
    (SELECT Allowed_Value_ID FROM AllowedValues WHERE Allowed_Value_Group='TRANSACTION_TYPE' AND Allowed_Value_Code='SALARY'),
    'PI Salary Charge - January 2024',
    'AWD-001', 'PRJ-001',
    (SELECT AwardBudgetPeriod_ID FROM AwardBudgetPeriod WHERE Award_ID='AWD-001' AND Period_Number=1),
    'DOC-2024-001', 'JRN-2024-001', NULL, 'PER-001', 'REF-001', TRUE
),
(
    'TXN-002',
    'FUND-001',
    'ACCT-5200',
    'FC-AWD001',
    '2024-02-10', 2024, 2, 2500.00,
    (SELECT Allowed_Value_ID FROM AllowedValues WHERE Allowed_Value_Group='TRANSACTION_TYPE' AND Allowed_Value_Code='SUPPLY'),
    'Laboratory supplies purchase',
    'AWD-001', 'PRJ-001',
    (SELECT AwardBudgetPeriod_ID FROM AwardBudgetPeriod WHERE Award_ID='AWD-001' AND Period_Number=1),
    'DOC-2024-002', 'JRN-2024-002', 'VEN-001', NULL, 'REF-002', TRUE
),
(
    'TXN-003',
    'FUND-001',
    'ACCT-5100',
    'FC-AWD002',
    '2024-03-15', 2024, 3, 8333.33,
    (SELECT Allowed_Value_ID FROM AllowedValues WHERE Allowed_Value_Group='TRANSACTION_TYPE' AND Allowed_Value_Code='SALARY'),
    'PI Salary Charge - March 2024',
    'AWD-002', 'PRJ-002',
    (SELECT AwardBudgetPeriod_ID FROM AwardBudgetPeriod WHERE Award_ID='AWD-002' AND Period_Number=1),
    'DOC-2024-003', 'JRN-2024-003', NULL, 'PER-002', 'REF-003', TRUE
);

-- ============================================================================
-- TABLE 25: Effort (depends on ProjectRole, Personnel)
-- ============================================================================

INSERT INTO Effort (ProjectRole_ID, Period_Start_Date, Period_End_Date, Committed_Percent, Committed_Person_Months, Actual_Percent, Variance_Percent, Is_Certified, Certification_Date, Certified_By_Personnel_ID, Certification_Method, Requires_Prior_Approval, Prior_Approval_Status) VALUES
(
    (SELECT ProjectRole_ID FROM ProjectRole WHERE Project_ID='PRJ-001' AND Personnel_ID='PER-001' LIMIT 1),
    '2024-01-01', '2024-06-30', 25.00, 1.50, 26.00, 1.00, TRUE, '2024-07-15', 'PER-001', 'PAR', FALSE, 'Not Required'
),
(
    (SELECT ProjectRole_ID FROM ProjectRole WHERE Project_ID='PRJ-001' AND Personnel_ID='PER-001' LIMIT 1),
    '2024-07-01', '2024-12-31', 25.00, 1.50, 24.50, -0.50, FALSE, NULL, NULL, 'PAR', FALSE, 'Not Required'
),
(
    (SELECT ProjectRole_ID FROM ProjectRole WHERE Project_ID='PRJ-002' AND Personnel_ID='PER-002' LIMIT 1),
    '2024-03-01', '2024-08-31', 30.00, 1.80, 30.00, 0.00, TRUE, '2024-09-10', 'PER-002', 'PAR', FALSE, 'Not Required'
),
(
    (SELECT ProjectRole_ID FROM ProjectRole WHERE Project_ID='PRJ-001' AND Personnel_ID='PER-004' LIMIT 1),
    '2024-01-01', '2024-06-30', 100.00, 6.00, 100.00, 0.00, TRUE, '2024-07-15', 'PER-004', 'Timesheet', FALSE, 'Not Required'
);

-- ============================================================================
-- TABLE 26: ComplianceRequirement (depends on Project, Personnel)
-- ============================================================================

INSERT INTO ComplianceRequirement (ComplianceRequirement_ID, Requirement_Number, Requirement_Title, Requirement_Type, Project_ID, Review_Type, Initial_Approval_Date, Expiration_Date, Requirement_Status, Principal_Investigator_ID, Approval_Body, Risk_Level) VALUES
('COMP-001', 'IRB-2023-001', 'Machine Learning Healthcare Study - Human Subjects Protocol', 'IRB', 'PRJ-001', 'Expedited', '2023-11-15', '2024-11-15', 'Approved', 'PER-001', 'University IRB', 'Minimal'),
('COMP-002', 'IRB-2024-002', 'Cancer Immunotherapy Clinical Trial Protocol', 'IRB', 'PRJ-004', 'Full Board', '2024-05-01', '2025-05-01', 'Approved', 'PER-002', 'University IRB', 'More than Minimal'),
('COMP-003', 'COI-2024-001', 'Conflict of Interest Disclosure - Johnson', 'COI', NULL, 'Administrative', '2024-01-10', NULL, 'Approved', 'PER-001', 'COI Committee', 'Minimal');

-- ============================================================================
-- TABLE 27: ConflictOfInterest (depends on Personnel, Project, Award, AllowedValues)
-- ============================================================================

INSERT INTO ConflictOfInterest (Personnel_ID, Project_ID, Award_ID, Disclosure_Date, Relationship_Type_Value_ID, Entity_Name, Financial_Interest_Amount, Relationship_Description, Management_Plan, ConflictOfInterest_Status, Review_Date, Reviewed_By_Personnel_ID) VALUES
(
    'PER-001',
    'PRJ-001',
    'AWD-001',
    '2024-01-10',
    (SELECT Allowed_Value_ID FROM AllowedValues WHERE Allowed_Value_Group='RELATIONSHIP_TYPE' AND Allowed_Value_Code='CONSULTING'),
    'HealthTech Consulting LLC',
    15000.00,
    'Consulting services provided 2 days per month on healthcare AI topics unrelated to funded research',
    'PI will not involve HealthTech in project activities or publications',
    'Manageable Conflict', '2024-01-15', 'PER-005'
),
(
    'PER-002',
    'PRJ-003',
    'AWD-003',
    '2023-08-15',
    (SELECT Allowed_Value_ID FROM AllowedValues WHERE Allowed_Value_Group='RELATIONSHIP_TYPE' AND Allowed_Value_Code='EQUITY'),
    'BioMed Innovations Inc',
    50000.00,
    'Holds equity interest in company developing medical devices',
    'Company activities not related to training grant; no trainees involved with company',
    'Manageable Conflict', '2023-08-20', 'PER-005'
),
(
    'PER-004',
    NULL,
    NULL,
    '2024-06-01',
    (SELECT Allowed_Value_ID FROM AllowedValues WHERE Allowed_Value_Group='RELATIONSHIP_TYPE' AND Allowed_Value_Code='BOARD'),
    'Research Advocacy Foundation',
    0.00,
    'Volunteer board member of non-profit research advocacy organization',
    'No management plan required - no financial interest',
    'No Conflict', '2024-06-05', 'PER-005'
);

-- ============================================================================
-- TABLE 28: Document (depends on AllowedValues, various entities)
-- ============================================================================

INSERT INTO Document (Document_Type_Value_ID, Related_Entity_Type, Related_Entity_ID, File_Name, Storage_Location, File_Size_Bytes, MIME_Type, File_Hash, Version_Number, Description) VALUES
(
    (SELECT Allowed_Value_ID FROM AllowedValues WHERE Allowed_Value_Group='DOCUMENT_TYPE' AND Allowed_Value_Code='PROPOSAL_DOC'),
    'Proposal', 'PROP-001', 'PROP-001_Application.pdf', '/documents/proposals/2024/PROP-001/', 2458624, 'application/pdf',
    'a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6q7r8s9t0u1v2w3x4y5z6', 1,
    'Original proposal submission to NIH'
),
(
    (SELECT Allowed_Value_ID FROM AllowedValues WHERE Allowed_Value_Group='DOCUMENT_TYPE' AND Allowed_Value_Code='AWARD_NOTICE'),
    'Award', 'AWD-001', 'AWD-001_NoA.pdf', '/documents/awards/2024/AWD-001/', 524288, 'application/pdf',
    'b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6q7r8s9t0u1v2w3x4y5z6a1', 1,
    'Notice of Award from NIH'
),
(
    (SELECT Allowed_Value_ID FROM AllowedValues WHERE Allowed_Value_Group='DOCUMENT_TYPE' AND Allowed_Value_Code='PROTOCOL'),
    'ComplianceRequirement', 'COMP-001', 'IRB-2023-001_Protocol.pdf', '/documents/compliance/irb/2023/', 1048576, 'application/pdf',
    'c3d4e5f6g7h8i9j0k1l2m3n4o5p6q7r8s9t0u1v2w3x4y5z6a1b2', 1,
    'IRB protocol for human subjects research'
),
(
    (SELECT Allowed_Value_ID FROM AllowedValues WHERE Allowed_Value_Group='DOCUMENT_TYPE' AND Allowed_Value_Code='REPORT'),
    'Award', 'AWD-001', 'AWD-001_ProgressReport_Y1.pdf', '/documents/awards/2024/AWD-001/reports/', 3145728, 'application/pdf',
    'd4e5f6g7h8i9j0k1l2m3n4o5p6q7r8s9t0u1v2w3x4y5z6a1b2c3', 1,
    'Year 1 annual progress report'
),
(
    (SELECT Allowed_Value_ID FROM AllowedValues WHERE Allowed_Value_Group='DOCUMENT_TYPE' AND Allowed_Value_Code='CONTRACT'),
    'Subaward', 'SUB-001', 'SUB-001_Agreement.pdf', '/documents/subawards/2024/SUB-001/', 786432, 'application/pdf',
    'e5f6g7h8i9j0k1l2m3n4o5p6q7r8s9t0u1v2w3x4y5z6a1b2c3d4', 1,
    'Subaward agreement with Partner Research Institute'
);

-- ============================================================================
-- TABLE 29: ActivityLog (no foreign keys)
-- ============================================================================

INSERT INTO ActivityLog (Table_Name, Record_ID, Action_Type, Action_Timestamp, User_ID, Old_Values, New_Values, IP_Address, Session_ID) VALUES
('Award', 'AWD-001', 'INSERT', '2023-12-15 10:30:00', 'PER-005', NULL, '{"Award_Number":"R01HL123456","Award_Title":"Advanced Machine Learning for Healthcare Applications","Award_Status":"Pending"}', '192.168.1.100', 'SESSION-001'),
('Award', 'AWD-001', 'UPDATE', '2024-01-02 09:15:00', 'PER-005', '{"Award_Status":"Pending"}', '{"Award_Status":"Active"}', '192.168.1.100', 'SESSION-002'),
('Modification', 'MOD-001', 'INSERT', '2024-06-15 10:30:00', 'PER-005', NULL, '{"Modification_Number":"A01","Funding_Amount_Change":50000.00}', '192.168.1.101', 'SESSION-003'),
('Invoice', 'INV-001', 'INSERT', '2024-04-05 14:20:00', 'PER-003', NULL, '{"Invoice_Number":"INV-AWD001-Q1-2024","Total_Amount":58500.00}', '192.168.1.102', 'SESSION-004'),
('Invoice', 'INV-001', 'UPDATE', '2024-05-15 11:00:00', 'PER-003', '{"Invoice_Status":"Submitted"}', '{"Invoice_Status":"Paid","Payment_Date":"2024-05-15","Payment_Amount":58500.00}', '192.168.1.102', 'SESSION-005');

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;

-- ============================================================================
-- END OF UDM COMPLETE SAMPLE DATA
-- ============================================================================
-- Summary: Sample data loaded for 29 tables
-- Tables populated:
--   1. AllowedValues (40 rows)
--   2. BudgetCategory (5 rows)
--   3. Organization (6 rows)
--   4. Personnel (5 rows)
--   5. ContactDetails (5 rows)
--   6. IndirectRate (4 rows)
--   7. Project (4 rows)
--   8. RFA (3 rows)
--   9. Proposal (3 rows)
--  10. ProposalBudget (5 rows)
--  11. Award (3 rows)
--  12. Modification (3 rows)
--  13. Terms (3 rows)
--  14. AwardBudgetPeriod (5 rows)
--  15. AwardBudget (4 rows)
--  16. Subaward (2 rows)
--  17. CostShare (3 rows)
--  18. Invoice (3 rows)
--  19. AwardDeliverable (3 rows)
--  20. ProjectRole (5 rows)
--  21. Fund (3 rows)
--  22. Account (5 rows)
--  23. FinanceCode (3 rows)
--  24. Transaction (3 rows)
--  25. Effort (4 rows)
--  26. ComplianceRequirement (3 rows)
--  27. ConflictOfInterest (3 rows)
--  28. Document (5 rows)
--  29. ActivityLog (5 rows)
-- ============================================================================
