```markdown
# Project Overview

This project is a **serverless, interactive data modeling and documentation platform** for your Unified Data Model (UDM). It provides:

- A **live interactive ERD** showing the current schema from your DoltHub database.
- A **wiki-style Data Dictionary** that allows users to propose updates to table and column metadata.

Key points:

- All **proposed changes to the Data Dictionary are saved to a branch** in DoltHub for review—they do **not** immediately alter the authoritative schema.
- The ERD reflects the **current reality** of the database as it exists in `main`.
- This setup ensures clear separation between **proposals** and **production schema** while keeping the system fully interactive and easy to navigate.

---

# Tech Stack

| Component             | Technology                         | Purpose                                                   |
| --------------------- | ---------------------------------- | --------------------------------------------------------- |
| Database              | **DoltHub**                        | Source of truth for schema and Data Dictionary            |
| Frontend              | **HTML + CSS + JavaScript**        | Static, responsive UI                                     |
| ERD Visualization     | **Cytoscape.js**                   | Interactive, clickable ERD                                |
| Data Dictionary Table | **Editable HTML table or JS grid** | Inline editing of proposals                               |
| Static Site Hosting   | **GitHub Pages**                   | Fully static, serverless deployment                       |
| Build Automation      | **GitHub Actions**                 | Pulls schema and dictionary to generate JSON for the site |

Optional: lightweight frameworks (e.g., Vue or React) for better interactivity.

---

# Static Site Layout (Single Page)

**Two main panels:**

| Panel                     | Description                                                                                                                                                                                        |
| ------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Left: Data Dictionary** | Editable table showing all tables, columns, descriptions, and metadata. Users can propose changes directly in the table. All edits are **saved to a DoltHub branch** for review before merging.    |
| **Right: ERD**            | Interactive, clickable diagram reflecting the **current database schema**. Users can click tables to see FK relationships. This panel is **read-only**, always showing the live state from `main`. |

**Additional UX details:**

- Left panel edits trigger inline validation before submitting proposals.
- Right panel updates automatically when the static site is rebuilt, ensuring the ERD always reflects the live database.
- Optional toolbar/search above the Data Dictionary table for quick filtering.
- Clear messaging: “**All changes are proposals for review; the ERD on the right shows the current reality.**”

---

# Summary

- **Single-page static site** with split layout: left editable Data Dictionary, right interactive ERD.
- **Proposals workflow** via DoltHub branches.
- **Live ERD** always reflects authoritative schema.
- **Fully serverless**, hosted on GitHub Pages, with automated JSON generation from DoltHub.
```
