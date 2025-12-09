ERD visualization

Data Source: Dolt database, accessed via the MySQL protocol.

Extraction Tool: ERAlchemy2 (Python library) running on the GitHub Action.

Output Format: Mermaid markup syntax, saved to a static file named mermaid_erd.md.

Security: GitHub Secret (DB_CONNECTION_URL) securely stores the Dolt connection string.

Automation: GitHub Action executes the Python script upon a code push (or manually).

Hosting: GitHub Pages hosts the static files (index.html and mermaid_erd.md).

Rendering: index.html uses JavaScript to fetch the mermaid_erd.md file and renders the ERD using the Mermaid JS library in the user's browser.
