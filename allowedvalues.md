# Enum Strategy for AI4RA-UDM

## Ref_Table (Dedicated Reference Tables)

For enums that **will grow over time** as institutions add new values or as technology/practices evolve. Each gets its own table (e.g., `Ref_ContactType`, `Ref_ProjectRole`).

- **ContactType** - Email, Phone → will add SMS, Fax, Slack, Teams, WhatsApp, Signal as communication methods evolve
- **ProjectRole** - PI, Co-PI, Key Personnel → institutions add Consultant, Collaborator, Site PI, Co-Investigator, Senior Personnel, Research Associate
- **FundType** - Grant, Contract → institutions add Gift, Fellowship, Endowment, Cooperative Agreement, Subcontract, Clinical Trial funding
- **Organization_Type** - Department, College, School, Sponsor, Subrecipient, Vendor → institutions add Institute, Center, Lab, Division, Consortium, Joint Venture
- **Person_Type** - Faculty, Staff, Student, Postdoc, External → institutions add Resident, Fellow, Research Scientist, Visiting Scholar, Adjunct

**Why Ref_Table for these:**
- New values emerge regularly (new org types, new roles, new communication platforms)
- Institution-specific variations are common
- Can add metadata later (Display_Order, Is_Active, Icon) without schema changes
- Institutions can INSERT new values without schema migrations
- Strong referential integrity (can't reference wrong type)

## Check (CHECK Constraints)

For enums that are **immutable or rarely changed** - universal standards that won't grow. Hardcoded in schema for simplicity and enforcement.

**Status Fields:**
- **Award_Status** - Pending, Active, Closed, Suspended, Terminated
- **Project_Status** - Planning, Active, Completed, Suspended, Cancelled
- **Proposal_Status** - Draft, Submitted, Under Review, Awarded, Not Awarded, Withdrawn
- **Deliverable_Status** - Pending, In Progress, Submitted, Accepted, Revision Required, Overdue
- **ConflictOfInterest_Status** - Under Review, No Conflict, Manageable Conflict, Unmanageable Conflict, Management Plan Required, Cleared
- **Requirement_Status** - Draft, Submitted, Under Review, Approved, Conditional Approval, Disapproved, Expired, Withdrawn, Terminated, Suspended, Closed
- **Subaward_Status** - Pending, Active, Closed, Terminated, Suspended
- **Period_Status** - Pending, Released, Active, Closed
- **CostShare_Status** - Committed, In Progress, Met, Waived
- **Invoice_Status** - Draft, Submitted, Under Review, Approved, Paid, Rejected
- **Internal_Approval_Status** - Draft, In Review, Approved, Rejected, Withdrawn
- **Decision_Status** - Pending, Submitted, Under Review, Awarded, Declined, Withdrawn
- **Approval_Status** - Pending, Approved, Rejected, Not Required
- **Prior_Approval_Status** - Not Required, Pending, Approved, Denied

**Financial & Accounting:**
- **Rate_Type** - On-Campus, Off-Campus, MTDC, TDC, Clinical Trial, Fringe Benefits, Facilities, Administrative
- **Base_Type** - MTDC, TDC, Salaries and Wages, Direct Salaries
- **Account_Type** - Expense, Revenue, Asset, Liability, Equity, Transfer
- **Transaction_Type** - Expense, Revenue, Encumbrance, Transfer, Adjustment, Reversal, Cost Share
- **Purpose** - Direct Costs, Cost Share, Indirect Costs, Subcontract, Department Share, Program Income, Other
- **Payment_Method** - Reimbursement, Advance, Cost-Reimbursement, Fixed-Price, Letter-of-Credit, Payment-Request
- **Invoicing_Frequency** - Monthly, Quarterly, Semi-Annual, Annual, Upon-Request, Milestone
- **Commitment_Type** - Cash, In-Kind, Third-Party, Waived IDC

**Research & Compliance:**
- **Deliverable_Type** - Technical Progress Report, Financial Report, Annual Report, Final Technical Report, Final Financial Report, Property Report, Invention Disclosure, Animal Welfare Report, Data Submission, Software Release, Clinical Trial Registration, Publication, Presentation, Material Transfer, Other
- **Requirement_Type** - IRB, IACUC, IBC, COI, Export Control, FCOI, Human Subjects, Animal Subjects, Biosafety, Radiation, Other
- **Review_Type** - Exempt, Expedited, Full Board, Not Human Subjects, Administrative
- **Relationship_Type** - Financial, Consulting, Employment, Equity, Intellectual Property, Board Membership, Family, Other
- **Risk_Level** - Low, Medium, High, Minimal, More than Minimal
- **Certification_Method** - PAR, Activity Report, Timesheet, Other

**Projects & Awards:**
- **Project_Type** - Research, Training, Service, Clinical Trial, Fellowship, Infrastructure, Other
- **Event_Type** - Initial Award, Incremental Funding, No Cost Extension, Time Extension, Budget Revision, Scope Change, Personnel Change, Termination, Supplement, Carryforward, Administrative Change
- **Related_Entity_Type** - Award, Proposal, Project, ComplianceRequirement, Subaward, Organization, Personnel, Invoice, AwardDeliverable, COI

**System:**
- **Action_Type** - INSERT, UPDATE, DELETE, SELECT

**Benefits:**
- Simple, no extra tables
- Cannot be changed without schema migration (good for stable values)
- Database enforces validation

## Unconstrained (VARCHAR with No Validation)

Highly variable, institution-specific fields where standardization would be counterproductive.

- **Document_Type** - Too variable across institutions (19+ values). Each institution has unique document workflows and categories. Let them use free text.

**Benefits:**
- Maximum flexibility
- No schema changes needed
- Application layer can provide suggested values without enforcing them
