# UDM Data Dictionary Browser

An interactive web-based browser for exploring the Universal Data Model (UDM) schema.

## Current Implementation: Data Dictionary Browser

### Overview

The UDM Data Dictionary Browser provides an intuitive way to navigate and understand the database schema by displaying table definitions with field-by-field descriptions and enabling drill-down navigation through foreign key relationships.

### Design Principles

1. **Simplicity First**: Don't overwhelm the user - show one table at a time
2. **Progressive Disclosure**: Start with core tables, enable exploration through clicking
3. **Bidirectional Navigation**: Navigate up (to parents) via FK fields, navigate down (to children) via related table cards
4. **"Contains" Mental Model**: Show child tables to match intuitive "X contains Y" thinking
5. **Breadcrumb Navigation**: Clear navigation path with easy backtracking
6. **Self-Referential Handling**: Don't add duplicate entries to navigation when clicking self-referential foreign keys

### Features

#### Home Page
- **Getting Started Section**: Clear instructions on how to use the browser
- **Entry Points**: Four distinct tracks into the data model (Organization, Project, Personnel, Transaction) presented as clickable cards with:
  - Color-coded borders matching the original theme
  - Brief descriptions
  - Hover effects for better UX
  - Each represents a different pathway through the data (organizational, research, people, financial)

#### Table View
- **Header**: Table name and description from data dictionary
- **Two-Column Layout**:
  - **Field Name**: Displayed in monospace font for clarity
  - **Description**: Field-level documentation from data dictionary
- **Foreign Key Navigation (Up)**: FK fields shown in blue with dotted underline, clickable to navigate to parent tables
- **Related Tables Navigation (Down)**: Section below fields showing child tables (tables that reference this table) as clickable cards
- **PII Indicators**: Red badges marking Personally Identifiable Information fields
- **Breadcrumb Trail**: Full navigation path with clickable history

#### Navigation Behavior
1. **Entry Points**: Click an entry point card from home (Organization, Project, Personnel, Transaction) → navigate to that table
2. **Navigate Up (to parents)**: Click a foreign key field (blue, dotted underline) → navigate to the referenced parent table
3. **Navigate Down (to children)**: Click a related table card below the field list → navigate to a child table that references the current table
4. **Breadcrumb Navigation**: Click any breadcrumb link → jump back to that point in history
5. **Return Home**: Click "Home" → return to starting page
6. **Self-Referential Handling**: Self-referential FKs don't create duplicate breadcrumb entries

### Implementation

#### Architecture
- **Static Site**: No backend required, can be hosted on GitHub Pages
- **JSON Data Files**: Pre-generated from SQL schema files
- **Client-Side Rendering**: JavaScript builds table views dynamically

#### Data Sources
1. **data-dictionary.json**: Generated from `udm_data_dictionary_values.sql`
   - Table descriptions
   - Column descriptions
   - Synonyms
   - PII flags

2. **relationships.json**: Generated from `udm_schema.sql`
   - Forward relationships (FK constraints)
   - Used to identify clickable fields (navigate up to parents)
   - Reverse relationships built client-side to show child tables (navigate down)

#### Generation Scripts
1. **parse_data_dictionary.py**: Parses `udm_data_dictionary_values.sql` to extract descriptions
2. **parse_schema.py**: Parses `udm_schema.sql` to extract relationships
3. **analyze_coverage.py**: Analyzes table reachability via forward and reverse relationships

#### Coverage Analysis
With bidirectional navigation (FK fields + reverse relationships):
- **Organization** alone reaches 28/29 tables (96.6%) with 11 child tables
- **Project** alone reaches 28/29 tables (96.6%) with 6 child tables
- **Personnel** alone reaches 28/29 tables (96.6%) with 8 child tables
- Only **ActivityLog** is unreachable (isolated structural table)
- Current 4 entry points provide 100% coverage of domain-meaningful tables

#### Color Scheme
Preserved from original visualization:
- **Organization**: Blue (#4A90E2)
- **Project**: Purple (#BD10E0)
- **Personnel**: Orange (#F5A623)
- **Transaction**: Green (#7ED321) - Financial track
- **Primary Gradient**: Purple gradient (#667eea → #764ba2)

### Usage

#### Local Development
```bash
# Generate data files
python3 scripts/parse_data_dictionary.py
python3 scripts/parse_schema.py

# Start local web server (required for CORS)
cd docs
python3 -m http.server 8000

# Open browser
open http://localhost:8000
```

#### Deployment
Deploy the `docs/` directory to any static hosting service (GitHub Pages, Netlify, etc.)

### Files

- **docs/index.html**: Main application
- **docs/data/data-dictionary.json**: Table and column descriptions
- **docs/data/relationships.json**: Foreign key relationships
- **scripts/parse_data_dictionary.py**: Data dictionary parser
- **scripts/parse_schema.py**: Schema parser (generates relationships.json)
- **scripts/analyze_coverage.py**: Coverage analysis tool
- **udm_data_dictionary_values.sql**: Source data for descriptions
- **udm_schema.sql**: Source data for schema structure

### Future Enhancements

Potential improvements:
- Search functionality to find tables/fields by name
- Filter by PII status
- Show reverse relationships (what tables reference this one)
- Export table documentation to PDF/Markdown
- Deep linking with URL parameters (e.g., `?table=Organization`)
- Mobile-responsive optimizations

---

## Data Model Structure

### Organization-Centric View

#### Concept
The most natural way to understand research administration is through **Organizations** and their multiple roles:
- Sponsors give money
- Departments receive and manage money
- Subrecipients receive portions of money
- People belong to organizations and work on projects

#### Main View - The Hub

```
                        ┌─────────────────┐
                        │  ORGANIZATION   │
                        │   [Expandable]  │
                        └────────┬────────┘
                                 │
        ┌────────────────────────┼────────────────────────┐
        │                        │                        │
   ┌────▼─────┐           ┌─────▼──────┐         ┌──────▼──────┐
   │ SPONSOR  │           │ RECIPIENT  │         │SUBRECIPIENT │
   │   Role   │           │    Role    │         │    Role     │
   └────┬─────┘           └─────┬──────┘         └──────┬──────┘
        │                       │                        │
    Gives Awards          Receives Awards        Receives Subawards
        │                       │                        │
        │                 ┌─────┴─────┐                 │
        │                 │           │                 │
        │            ┌────▼───┐  ┌───▼──────┐          │
        │            │PROJECT │  │PERSONNEL │          │
        │            └────┬───┘  └───┬──────┘          │
        │                 │          │                 │
        └─────────→ ┌─────▼──────────▼─────┐ ─────────┘
                    │       AWARD          │
                    │   (Financial Core)   │
                    └──────────────────────┘
```

## Tier 1: Core Tables (Always Visible)

### 1. Organization (Center Hub)
**Display:**
- Organization_Name
- Organization_Type
- Hierarchy indicator (if has Parent_Organization)
- UEI (if applicable)

**Click to expand:** Shows all organizational roles (see Tier 2)

### 2. Award (Primary Artifact)
**Display:**
- Award_Number
- Award_Title
- Award_Status
- Current_Total_Funded
- Original_Start_Date → Current_End_Date

**Connections:**
- FROM: Sponsor_Organization
- TO: Submitting_Organization / Administering_Organization
- FUNDS: Project

**Click to expand:** Shows financial details (see Tier 2)

### 3. Project (The Work)
**Display:**
- Project_Title
- Acronym
- Project_Status
- Start_Date → End_Date
- Project_Type

**Connections:**
- LED BY: Lead_Organization
- FUNDED BY: Award(s)
- TEAM: Personnel (via ProjectRole)
- PARENT: Parent_Project (if hierarchical)

**Click to expand:** Shows team, compliance, outputs (see Tier 2)

### 4. Personnel (The People)
**Display:**
- First_Name Last_Name
- Person_Type
- Primary_Email
- ORCID (if available)

**Connections:**
- WORKS FOR: Department_Organization
- ASSIGNED TO: Projects (via ProjectRole)

**Click to expand:** Shows roles, effort, compliance (see Tier 2)

---

## Tier 2: Expandable Details

### Expand Organization

#### Organizational Structure
- **Hierarchy Tree:** Parent/Child organization relationships
- **ContactDetails:** Phone, email, address
- **IndirectRate:** F&A rates (if applicable)

#### As Sponsor (Outbound Flow)
- **RFA:** Funding opportunities published
  - RFA_Number, RFA_Title, Program_Code, CFDA_Number
- **Proposals Received:** Proposals submitted to this sponsor
- **Awards Given:** Awards funded by this sponsor

#### As Recipient (Inbound Flow)
- **Proposals Submitted:** To sponsors
  - Shows Proposal status, amounts, decision
- **Awards Received:** From sponsors
  - Links to Projects funded
- **Projects Managed:** Research conducted

#### As Department/College (Internal)
- **Personnel Employed:** Staff in this department
- **Projects Led:** Research led by this unit
- **Funds Managed:** Financial accounts

#### As Subrecipient (Partner)
- **Subawards Received:** From prime recipients
  - Subaward_Number, Amount, Status, Monitoring_Plan

---

### Expand Award

#### Award Overview
- **From:** Sponsor_Organization_ID
- **To:** Submitting_Organization, Administering_Organization
- **Prime Sponsor:** Prime_Sponsor_Organization (if flow-through)
- **Supports:** Project_ID
- **Originated From:** Proposal_ID → RFA_ID
- **CFDA_Number, Federal_Award_ID**

#### Financial Management
**AwardBudgetPeriod** (Timeline View)
- Period_Number, Start_Date → End_Date
- Direct_Costs, Indirect_Costs, Total_Costs
- Period_Status
- Click period → **AwardBudget** line items
  - BudgetCategory breakdown
  - Approved vs Current costs
  - Rate_Base_Used

**Modification** (Change History)
- Modification_Number, Event_Type
- Funding_Amount_Change
- New_End_Date
- Change_Description, Approval_Status

**CostShare** (Institutional Commitment)
- Committed_Amount, Met_Amount
- Commitment_Type (Cash, In-Kind, etc.)
- Source_Organization, Status

**Terms** (Award Terms & Conditions)
- Payment_Method, Invoicing_Frequency
- Reporting_Requirements
- Special_Conditions
- Closeout_Requirements

#### Execution & Reporting
**Invoice** (Billing)
- Invoice_Number, Invoice_Date
- Direct_Costs, Indirect_Costs, Total_Amount
- Invoice_Status (Draft → Submitted → Paid)
- Payment_Date, Payment_Amount

**AwardDeliverable** (Reports & Outputs)
- Deliverable_Type, Deliverable_Number
- Due_Date, Submission_Date
- Deliverable_Status
- Responsible_Personnel, Reviewer

**Subaward** (Flow-Through to Partners)
- Subrecipient_Organization
- Subaward_Number, Subaward_Amount
- Start_Date → End_Date
- PI_Name, Risk_Level, Monitoring_Plan

#### Financial Transactions
**Transaction** (Money Movement)
- Transaction_Date, Transaction_Amount
- Transaction_Type (Expense, Revenue, etc.)
- Fund_Code, Account_Code, Finance_Code
- Description, Document_Number
- Is_Reconciled

**FinanceCode** (Accounting)
- Finance_Code, Finance_Name
- Purpose (from AllowedValues)
- Links to Award, Organization

---

### Expand Project

#### Project Team
**ProjectRole** (Personnel Assignments)
- Personnel_ID
- Role (PI, Co-I, Coordinator, etc. from AllowedValues)
- Is_Key_Personnel
- Start_Date → End_Date
- FTE_Percent, Salary_Charged
- Funding_Award_ID

**Click Role → Effort** (Time Tracking)
- Period_Start_Date → Period_End_Date
- Committed_Percent, Actual_Percent, Variance_Percent
- Is_Certified, Certification_Date, Certification_Method
- Certified_By_Personnel

#### Compliance
**ComplianceRequirement** (IRB, IACUC, etc.)
- Requirement_Number, Requirement_Title
- Requirement_Type (IRB, IACUC, IBC, COI, Radiation, Other)
- Review_Type (Exempt, Expedited, Full Board)
- Initial_Approval_Date, Expiration_Date
- Requirement_Status
- Principal_Investigator, Approval_Body
- Risk_Level

**ConflictOfInterest** (Disclosures)
- Personnel disclosures related to this project
- Relationship_Type, Entity_Name
- Financial_Interest_Amount
- ConflictOfInterest_Status, Management_Plan

#### Funding Sources
**Award(s)** funding this project
- Multiple awards can fund one project
- Shows Award_Number, amounts, periods

**ProposalBudget** (What Was Proposed)
- Original budget by period and category
- Compare to AwardBudget (approved vs proposed)

#### Outputs & Documentation
**Document** (Attachments)
- File_Name, Storage_Location
- Document_Type (from AllowedValues)
- Version_Number, Description
- File_Size_Bytes, MIME_Type, File_Hash

**AwardDeliverable** (linked to awards)
- Reports, publications, data deliverables

#### Project Structure
**Parent/Child Projects**
- Parent_Project_ID (if this is a subproject)
- Child Projects (if this has subprojects)
- Shows hierarchical research structure

---

### Expand Personnel

#### Identity & Contact
- **Name:** First_Name, Middle_Name, Last_Name
- **ORCID:** Researcher identifier
- **Institutional_ID:** Employee/Student ID
- **Primary_Email**
- **ContactDetails:** Additional phone, mobile, fax
  - Contact_Type (from AllowedValues)
  - ContactDetails_Value

#### Organizational Affiliation
- **Department:** Department_Organization_ID
- **Person_Type:** Faculty, Staff, Student, Postdoc, etc.

#### Project Assignments
**ProjectRole** (All Projects)
- List of projects this person works on
- Role on each project (PI, Co-I, etc.)
- FTE commitment
- Active date ranges

**For Each Role → Effort Tracking**
- Time periods
- Committed vs actual effort
- Certification status

#### Compliance & Disclosures
**ComplianceRequirement** (As Principal Investigator)
- IRB/IACUC protocols where this person is PI
- Approval status, expiration dates

**ConflictOfInterest** (Personal Disclosures)
- All COI disclosures by this person
- Related to which projects/awards
- Disclosure_Date, Status
- Entity_Name, Relationship_Type
- Management_Plan

#### Responsibilities
**AwardDeliverable** (As Responsible Person)
- Deliverables assigned to this person
- Due dates, submission status

**Modification** (As Approver or Affected)
- Award modifications this person approved
- Modifications affecting this person (e.g., role changes)

---

## Tier 3: Supporting Infrastructure

### Proposal Flow (Pre-Award Process)
```
┌─────┐    ┌──────────┐    ┌────────────────┐
│ RFA │ → │ Proposal │ → │ ProposalBudget │
└──┬──┘    └────┬─────┘    └────────────────┘
   │            │
   ↓            ↓
 Award      Project
```

**RFA** (Request for Applications)
- Sponsor_Organization
- RFA_Number, RFA_Title
- Program_Code, Opportunity_Number
- CFDA_Number, Announcement_URL

**Proposal**
- Proposal_Number, Proposal_Title
- Project_ID (proposed research)
- Sponsor_Organization (submitting to)
- Submitting_Organization, Administering_Organization
- Internal_Approval_Status, Decision_Status
- Total_Proposed_Budget (Direct + Indirect)
- Submission_Date, Decision_Date
- Previous_Proposal_ID (resubmissions)

**ProposalBudget**
- Budget by Period_Number and BudgetCategory
- Direct_Cost, Indirect_Cost, Total_Cost
- Quantity, Unit_Cost
- Applied_Indirect_Rate

### Financial Plumbing (Accounting Structure)
```
┌──────┐   ┌─────────────┐   ┌─────────────┐   ┌─────────┐
│ Fund │→│ FinanceCode │→│ Transaction │→│ Account │
└──────┘   └──────┬──────┘   └──────┬──────┘   └─────────┘
                  │                  │
                  ↓                  ↓
                Award          Reconciliation
```

**Fund**
- Fund_Code, Fund_Name
- Fund_Type (from AllowedValues)
- Organization_ID

**Account** (Chart of Accounts)
- Account_Code, Account_Name
- Account_Type (Expense, Revenue, Asset, Liability, Equity)
- Account_Category
- Parent_Account_Code (hierarchical)

**Transaction**
- Links: Fund, Account, FinanceCode, Award, Project

**FinanceCode**
- Award-specific accounting codes

### Reference & Metadata Tables

**AllowedValues** (Enumeration Management)
- Allowed_Value_Group (domain)
- Allowed_Value_Code (key)
- Allowed_Value_Label (display)
- Allowed_Value_Description
- Used for: Contact types, project types, roles, transaction types, etc.

**BudgetCategory** (Expense Classifications)
- Category_Code (e.g., SENIOR_PERSONNEL, TRAVEL, EQUIPMENT)
- Category_Name
- Category_Description
- Used in: ProposalBudget, AwardBudget

**Document** (Attachments Throughout)
- Can attach to: Award, Proposal, Project, ComplianceRequirement, Subaward, Organization, Personnel, Invoice, AwardDeliverable, ConflictOfInterest
- Document_Type (from AllowedValues)
- Related_Entity_Type, Related_Entity_ID
- Storage metadata: File_Name, Storage_Location, File_Size_Bytes, MIME_Type, File_Hash
- Version_Number (document versioning)

**IndirectRate** (F&A Rate Agreements)
- Organization_ID
- Rate_Type (On-Campus, Off-Campus, Fringe Benefits, etc.)
- Rate_Percentage
- Effective_Start_Date → Effective_End_Date
- Base_Type (MTDC, TDC, Salaries and Wages)
- Negotiated_Agreement_ID

---

## Alternative View: Graph Visualization (Previous Implementation)

### Overview
A previous implementation used Cytoscape.js to create an interactive network graph showing table relationships as nodes and edges. This view has been replaced with the data dictionary browser but is documented here for reference.

### Technology Stack
- **Visualization:** Cytoscape.js v3.28.1 with Cola layout algorithm
- **Layout Engine:** WebCola for force-directed graph layout
- **Data:** cytoscape-data.json (nodes + edges)

### Progressive Disclosure Pattern
**Initial State:**
- Only 4 core tables visible: Organization, Award, Project, Personnel
- Shows direct relationships between these core tables only

**Expansion Rules:**
Click tables to reveal related tables based on predefined hierarchy

**Interactive Features:**
- **Fit to Screen:** Zoom/pan to show all currently visible tables
- **Expand One Level:** Expand all currently visible tables simultaneously
- **Collapse All:** Reset view to 4 core tables
- **Show All Tables:** Reveal entire schema (all 29 tables, 72 relationships)

### Visual Design
**Node Colors:**
- Organization: `#4A90E2` (Blue)
- Award/Financial: `#7ED321` (Green)
- Project/Proposal: `#BD10E0` (Purple)
- Personnel: `#F5A623` (Orange)
- Compliance: `#D0021B` (Red)
- Supporting: `#D8D8D8` (Gray)

**Node Sizes:**
- Core tables: 90px diameter, bold font
- Regular tables: 70px diameter

**Edge Styling:**
- 2px gray lines with triangle arrows
- Bezier curves for smooth connections
- Highlighted: 3px purple when connected to selected node

