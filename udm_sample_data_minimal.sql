-- Sample data for empty tables only

-- Project (using existing Project_Type_Value_IDs: 49=RESEARCH, 52=CLINICAL, 50=TRAINING)
INSERT INTO Project (Project_ID, Project_Title, Acronym, Parent_Project_ID, Project_Type_Value_ID, Abstract, Start_Date, End_Date, Lead_Organization_ID, Project_Status) VALUES
('PRJ001', 'Machine Learning for Medical Diagnosis', 'ML-MED', NULL, 49, 'Developing machine learning algorithms for early disease detection', '2023-09-01', '2026-08-31', 'DEPT001', 'Active'),
('PRJ002', 'Sustainable Energy Systems', 'SES', NULL, 49, 'Research into renewable energy storage systems', '2024-01-01', '2027-12-31', 'DEPT002', 'Active'),
('PRJ003', 'Cancer Immunotherapy Clinical Trial', 'CICT', NULL, 52, 'Phase II clinical trial', '2023-06-01', '2028-05-31', 'DEPT003', 'Active');

-- RFA
INSERT INTO RFA (RFA_ID, Sponsor_Organization_ID, RFA_Number, RFA_Title, Program_Code, Announcement_URL, Opportunity_Number, CFDA_Number) VALUES
('RFA001', 'SPON001', 'RFA-CA-23-001', 'Cancer Immunotherapy Research', 'R01', 'https://grants.nih.gov/rfa-001', 'RFA-CA-23-001', '93.393'),
('RFA002', 'SPON002', 'NSF 23-500', 'Advanced Computing Systems', NULL, 'https://nsf.gov/nsf23500', 'PD-23-7484', '47.070');

-- Proposal  
INSERT INTO Proposal (Proposal_ID, Proposal_Number, Proposal_Title, Project_ID, Sponsor_Organization_ID, Submitting_Organization_ID, Administering_Organization_ID, RFA_ID, Previous_Proposal_ID, Submission_Version, Proposed_Start_Date, Proposed_End_Date, Total_Proposed_Direct, Total_Proposed_Indirect, Total_Proposed_Budget, Submission_Deadline, Submission_Date, Internal_Approval_Status, Decision_Status, Decision_Date) VALUES
('PROP001', 'SU-2023-001', 'Machine Learning for Medical Diagnosis', 'PRJ001', 'SPON001', 'DEPT001', 'INST001', NULL, NULL, 1, '2023-09-01', '2026-08-31', 750000.00, 416250.00, 1166250.00, '2023-06-15', '2023-06-10', 'Approved', 'Awarded', '2023-08-01'),
('PROP002', 'SU-2024-001', 'Sustainable Energy Systems', 'PRJ002', 'SPON004', 'DEPT002', 'INST001', NULL, NULL, 1, '2024-01-01', '2027-12-31', 1200000.00, 666000.00, 1866000.00, '2023-10-31', '2023-10-25', 'Approved', 'Awarded', '2023-12-15');

-- ProposalBudget (using existing BudgetCategory_IDs and IndirectRate_IDs)
INSERT INTO ProposalBudget (Proposal_ID, Period_Number, BudgetCategory_ID, Line_Item_Description, Direct_Cost, Indirect_Cost, Total_Cost, Applied_Indirect_Rate_ID, Rate_Base_Used) VALUES
('PROP001', 1, 1, 'PI Salary', 50000.00, 0.00, 50000.00, NULL, NULL),
('PROP001', 1, 2, 'Postdoc', 65000.00, 0.00, 65000.00, NULL, NULL),
('PROP002', 1, 1, 'PI Salary', 60000.00, 0.00, 60000.00, NULL, NULL);

-- Award
INSERT INTO Award (Award_ID, Award_Number, Award_Title, Project_ID, Sponsor_Organization_ID, RFA_ID, Proposal_ID, Original_Start_Date, Original_End_Date, Current_Total_Funded, Current_End_Date, Total_Anticipated_Funding, Award_Status, CFDA_Number, Federal_Award_ID, Flow_Through_Indicator) VALUES
('AWD001', '1R01CA234567', 'Machine Learning for Medical Diagnosis', 'PRJ001', 'SPON001', NULL, 'PROP001', '2023-09-01', '2026-08-31', 750000.00, '2026-08-31', 1166250.00, 'Active', '93.393', '1R01CA234567-01', FALSE),
('AWD002', 'DE-SC0012345', 'Sustainable Energy Systems', 'PRJ002', 'SPON004', NULL, 'PROP002', '2024-01-01', '2027-12-31', 600000.00, '2027-12-31', 1866000.00, 'Active', '81.135', 'DE-SC0012345', FALSE);

-- Modification (using Event_Type_Value_ID: 34=INITIAL)
INSERT INTO Modification (Modification_ID, Award_ID, Modification_Number, Event_Type_Value_ID, Effective_Date, Funding_Amount_Change, Change_Description, Approval_Status, Approved_By_Personnel_ID) VALUES
('MOD001', 'AWD001', '00', 34, '2023-09-01', 750000.00, 'Initial award', 'Approved', 'P008'),
('MOD002', 'AWD002', '00', 34, '2024-01-01', 600000.00, 'Initial award', 'Approved', 'P008');

-- Terms
INSERT INTO Terms (Award_ID, Payment_Method, Invoicing_Frequency, Invoice_Submission_Days, Record_Retention_Years) VALUES
('AWD001', 'Reimbursement', 'Quarterly', 90, 3),
('AWD002', 'Reimbursement', 'Quarterly', 90, 3);

-- AwardBudgetPeriod
INSERT INTO AwardBudgetPeriod (Award_ID, Period_Number, Start_Date, End_Date, Direct_Costs, Indirect_Costs, Total_Costs, Period_Status) VALUES
('AWD001', 1, '2023-09-01', '2024-08-31', 250000.00, 138750.00, 388750.00, 'Active'),
('AWD002', 1, '2024-01-01', '2024-12-31', 300000.00, 166500.00, 466500.00, 'Active');

-- AwardBudget
INSERT INTO AwardBudget (Award_ID, AwardBudgetPeriod_ID, BudgetCategory_ID, Line_Item_Description, Approved_Direct_Cost, Approved_Total_Cost, Current_Direct_Cost, Current_Total_Cost) VALUES
('AWD001', 1, 1, 'PI Salary', 50000.00, 50000.00, 50000.00, 50000.00),
('AWD002', 1, 1, 'PI Salary', 60000.00, 60000.00, 60000.00, 60000.00);

-- ProjectRole (using Role_Value_ID: 18=PI)
INSERT INTO ProjectRole (Project_ID, Personnel_ID, Role_Value_ID, Is_Key_Personnel, Funding_Award_ID, Start_Date, FTE_Percent) VALUES
('PRJ001', 'P001', 18, TRUE, 'AWD001', '2023-09-01', 25.00),
('PRJ002', 'P002', 18, TRUE, 'AWD002', '2024-01-01', 30.00);

-- Fund (using Fund_Type_Value_ID: 23=SPONSORED)
INSERT INTO Fund (Fund_Code, Fund_Name, Fund_Type_Value_ID, Organization_ID) VALUES
('10000', 'Sponsored Research Fund', 23, 'INST001'),
('11001', 'NIH Awards Fund', 23, 'INST001');

-- Account
INSERT INTO Account (Account_Code, Account_Name, Account_Type) VALUES
('5000', 'Expenses', 'Expense'),
('5110', 'Faculty Salaries', 'Expense'),
('4000', 'Revenue', 'Revenue');

-- FinanceCode (using Purpose_Value_ID: 54=DIRECT)
INSERT INTO FinanceCode (Finance_Code, Finance_Name, Award_ID, Purpose_Value_ID, Organization_ID) VALUES
('FC-AWD001', 'ML-MED Project Code', 'AWD001', 54, 'DEPT001'),
('FC-AWD002', 'SES Project Code', 'AWD002', 54, 'DEPT002');

-- Transaction (using Transaction_Type_Value_ID: 27=EXPENSE)
INSERT INTO Transaction (Transaction_ID, Fund_Code, Account_Code, Finance_Code, Transaction_Date, Fiscal_Year, Fiscal_Period, Transaction_Amount, Transaction_Type_Value_ID, Description, Award_ID, Project_ID, Is_Reconciled) VALUES
('T001', '11001', '5110', 'FC-AWD001', '2023-09-30', 2024, 3, 16666.67, 27, 'PI Salary', 'AWD001', 'PRJ001', TRUE),
('T002', '11001', '5110', 'FC-AWD002', '2024-01-31', 2024, 7, 20000.00, 27, 'PI Salary', 'AWD002', 'PRJ002', TRUE);

-- Effort
INSERT INTO Effort (ProjectRole_ID, Period_Start_Date, Period_End_Date, Committed_Percent, Is_Certified, Certification_Method) VALUES
(1, '2023-09-01', '2024-02-29', 25.00, TRUE, 'PAR'),
(2, '2024-01-01', '2024-06-30', 30.00, FALSE, 'PAR');

-- ComplianceRequirement
INSERT INTO ComplianceRequirement (ComplianceRequirement_ID, Requirement_Number, Requirement_Title, Requirement_Type, Project_ID, Review_Type, Initial_Approval_Date, Requirement_Status, Principal_Investigator_ID) VALUES
('COMP001', 'IRB-2023-0123', 'ML-MED Human Subjects Review', 'IRB', 'PRJ001', 'Exempt', '2023-08-01', 'Approved', 'P001');

-- ConflictOfInterest (using Relationship_Type_Value_ID: 58=FINANCIAL)
INSERT INTO ConflictOfInterest (Personnel_ID, Project_ID, Award_ID, Disclosure_Date, Relationship_Type_Value_ID, Entity_Name, Financial_Interest_Amount, ConflictOfInterest_Status) VALUES
('P001', 'PRJ001', 'AWD001', '2023-07-15', 58, 'AI Diagnostics Corp', 5000.00, 'No Conflict');

-- Document (using Document_Type_Value_ID: 63=PROPOSAL, 64=AWARD_NOTICE)
INSERT INTO Document (Document_Type_Value_ID, Related_Entity_Type, Related_Entity_ID, File_Name, Storage_Location, File_Size_Bytes, MIME_Type, File_Hash, Version_Number, Description) VALUES
(63, 'Proposal', 'PROP001', 'proposal_mlmed.pdf', '/docs/proposals/PROP001.pdf', 2457600, 'application/pdf', 'sha256:abc123', 1, 'ML-MED proposal narrative'),
(64, 'Award', 'AWD001', 'award_notice.pdf', '/docs/awards/AWD001.pdf', 156000, 'application/pdf', 'sha256:def456', 1, 'NIH award notice');

-- ActivityLog
INSERT INTO ActivityLog (Table_Name, Record_ID, Action_Type, User_ID) VALUES
('Award', 'AWD001', 'INSERT', 'P008'),
('Award', 'AWD002', 'INSERT', 'P008');
