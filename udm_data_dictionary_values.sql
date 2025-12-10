-- DataDictionary values for Research Administration Unified Data Model
-- Simplified schema: Entity, Entity_Type, Parent_Entity, Description, Synonyms, PII_Flag

INSERT INTO DataDictionary (Entity, Entity_Type, Parent_Entity, Description, Synonyms, PII_Flag) VALUES

-- AllowedValues
('AllowedValues', 'Table', NULL, 'Stores allowed values for controlled vocabularies used in other tables', 'ValueList, LookupTable', FALSE),
('Allowed_Value_ID', 'Column', 'AllowedValues', 'Unique identifier for each allowed value', 'ValueID', FALSE),
('Allowed_Value_Group', 'Column', 'AllowedValues', 'Group or category for the allowed value', 'ValueGroup', FALSE),
('Allowed_Value_Code', 'Column', 'AllowedValues', 'Code representing the allowed value', 'ValueCode', FALSE),
('Allowed_Value_Label', 'Column', 'AllowedValues', 'Human-readable label for the allowed value', 'Label', FALSE),
('Allowed_Value_Description', 'Column', 'AllowedValues', 'Description of the allowed value', 'Description', FALSE),

-- Organization
('Organization', 'Table', NULL, 'Stores information about organizations, departments, colleges, sponsors, and other units', 'Org', FALSE),
('Organization_ID', 'Column', 'Organization', 'Unique identifier for an organization', 'OrganizationID', FALSE),
('Organization_Name', 'Column', 'Organization', 'Full name of the organization', 'Organization Name', FALSE),
('Organization_Type', 'Column', 'Organization', 'Type of organization (Department, College, Sponsor, etc.)', 'Organization Type', FALSE),
('Parent_Organization_ID', 'Column', 'Organization', 'Reference to parent organization, if applicable', 'ParentOrg', FALSE),
('UEI', 'Column', 'Organization', 'Unique Entity Identifier for external organizations', 'Unique Entity ID', FALSE),

-- Personnel
('Personnel', 'Table', NULL, 'Stores information about individuals involved in projects and awards', 'Person, Employee', FALSE),
('Personnel_ID', 'Column', 'Personnel', 'Unique identifier for a person', 'PersonID', FALSE),
('ORCID', 'Column', 'Personnel', 'ORCID identifier for the person', NULL, TRUE),
('First_Name', 'Column', 'Personnel', 'Person\'s first name', 'Given Name', TRUE),
('Last_Name', 'Column', 'Personnel', 'Person\'s last name', 'Surname', TRUE),
('Middle_Name', 'Column', 'Personnel', 'Person\'s middle name', NULL, TRUE),
('Institutional_ID', 'Column', 'Personnel', 'Institution-specific identifier for personnel', 'Employee ID', FALSE),
('Primary_Email', 'Column', 'Personnel', 'Primary email address of the person', 'Email', TRUE),
('Person_Type', 'Column', 'Personnel', 'Role type of the person (Faculty, Staff, Student, etc.)', NULL, FALSE),
('Department_Organization_ID', 'Column', 'Personnel', 'Reference to the department organization for the person', 'DepartmentID', FALSE),

-- ContactDetails
('ContactDetails', 'Table', NULL, 'Stores contact information for personnel and organizations', 'Contact, ContactInfo', FALSE),
('ContactDetails_ID', 'Column', 'ContactDetails', 'Unique identifier for a contact entry', 'Contact ID', FALSE),
('Personnel_ID', 'Column', 'ContactDetails', 'Reference to personnel if contact is for a person', 'PersonID', FALSE),
('Organization_ID', 'Column', 'ContactDetails', 'Reference to organization if contact is for an org', 'OrgID', FALSE),
('AllowedValue_ID', 'Column', 'ContactDetails', 'Reference to AllowedValues for the type of contact', 'Contact Type', FALSE),
('ContactDetails_Value', 'Column', 'ContactDetails', 'The actual contact information (email, phone, etc.)', 'Contact Info, Contact Value', TRUE),
('Is_Primary', 'Column', 'ContactDetails', 'Indicates if this is the primary contact', NULL, FALSE),

-- Project
('Project', 'Table', NULL, 'Represents research or training projects', NULL, FALSE),
('Project_ID', 'Column', 'Project', 'Unique identifier for a project', 'ProjID', FALSE),
('Project_Title', 'Column', 'Project', 'Title of the project', 'Title, Project Name', FALSE),
('Acronym', 'Column', 'Project', 'Short acronym for the project', NULL, FALSE),
('Parent_Project_ID', 'Column', 'Project', 'Reference to parent project, if applicable', 'Parent Project', FALSE),
('Project_Type', 'Column', 'Project', 'Type of project (Research, Training, Service, etc.)', NULL, FALSE),
('Abstract', 'Column', 'Project', 'Project abstract or summary', 'Summary, Description', FALSE),
('Start_Date', 'Column', 'Project', 'Official start date of the project', 'Project Start', FALSE),
('End_Date', 'Column', 'Project', 'Official end date of the project', 'Project End', FALSE),
('Lead_Organization_ID', 'Column', 'Project', 'Organization leading the project', 'Lead Department', FALSE),
('Project_Status', 'Column', 'Project', 'Current status of the project', 'Status', FALSE),

-- RFA
('RFA', 'Table', NULL, 'Represents Request for Applications or funding announcements', 'Funding Opportunity', FALSE),
('RFA_ID', 'Column', 'RFA', 'Unique identifier for an RFA', NULL, FALSE),
('Sponsor_Organization_ID', 'Column', 'RFA', 'Organization sponsoring the RFA', 'SponsorID', FALSE),
('RFA_Number', 'Column', 'RFA', 'Official number assigned to the RFA', NULL, FALSE),
('RFA_Title', 'Column', 'RFA', 'Title of the RFA', NULL, FALSE),
('Program_Code', 'Column', 'RFA', 'Sponsor program code for the RFA', NULL, FALSE),

-- Proposal
('Proposal', 'Table', NULL, 'Represents submitted proposals for projects', NULL, FALSE),
('Proposal_ID', 'Column', 'Proposal', 'Unique identifier for a proposal', NULL, FALSE),
('Proposal_Number', 'Column', 'Proposal', 'Official proposal number', NULL, FALSE),
('Proposal_Title', 'Column', 'Proposal', 'Title of the proposal', 'Title, Proposal Name', FALSE),
('Project_ID', 'Column', 'Proposal', 'Associated project ID', 'ProjID', FALSE),
('Sponsor_Organization_ID', 'Column', 'Proposal', 'Sponsoring organization', 'SponsorID', FALSE),
('Submitting_Organization_ID', 'Column', 'Proposal', 'Organization submitting the proposal', 'Submitter', FALSE),
('Administering_Organization_ID', 'Column', 'Proposal', 'Organization administering the proposal', 'Administrator', FALSE),
('RFA_ID', 'Column', 'Proposal', 'Associated RFA ID, if applicable', NULL, FALSE),
('Proposed_Start_Date', 'Column', 'Proposal', 'Proposed start date for the project', NULL, FALSE),
('Proposed_End_Date', 'Column', 'Proposal', 'Proposed end date for the project', NULL, FALSE),

-- Award
('Award', 'Table', NULL, 'Represents awarded funding for projects', NULL, FALSE),
('Award_ID', 'Column', 'Award', 'Unique identifier for an award', NULL, FALSE),
('Award_Number', 'Column', 'Award', 'Official award number', NULL, FALSE),
('Award_Title', 'Column', 'Award', 'Title of the award', 'Title', FALSE),
('Project_ID', 'Column', 'Award', 'Associated project ID', 'ProjID', FALSE),
('Sponsor_Organization_ID', 'Column', 'Award', 'Sponsoring organization', 'SponsorID', FALSE),
('RFA_ID', 'Column', 'Award', 'Associated RFA ID, if applicable', NULL, FALSE),
('Proposal_ID', 'Column', 'Award', 'Associated proposal ID', NULL, FALSE),
('Original_Start_Date', 'Column', 'Award', 'Original start date of the award', NULL, FALSE),
('Original_End_Date', 'Column', 'Award', 'Original end date of the award', NULL, FALSE),
('Current_Total_Funded', 'Column', 'Award', 'Current total funded amount', 'Total Funding', FALSE),
('Current_End_Date', 'Column', 'Award', 'Current end date of the award', NULL, FALSE),
('Award_Status', 'Column', 'Award', 'Current award status', 'Status', FALSE),

-- Subaward
('Subaward', 'Table', NULL, 'Represents subawards issued under prime awards', NULL, FALSE),
('Subaward_ID', 'Column', 'Subaward', 'Unique identifier for a subaward', NULL, FALSE),
('Prime_Award_ID', 'Column', 'Subaward', 'Reference to the prime award', 'Prime Award', FALSE),
('Subrecipient_Organization_ID', 'Column', 'Subaward', 'Organization receiving the subaward', 'Subrecipient', FALSE),
('Subaward_Number', 'Column', 'Subaward', 'Official subaward number', NULL, FALSE),
('Subaward_Amount', 'Column', 'Subaward', 'Subaward funding amount', 'Amount', FALSE),
('Start_Date', 'Column', 'Subaward', 'Subaward start date', NULL, FALSE),
('End_Date', 'Column', 'Subaward', 'Subaward end date', NULL, FALSE),
('Subaward_Status', 'Column', 'Subaward', 'Subaward current status', 'Status', FALSE);
