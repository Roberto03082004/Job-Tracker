# AI Usage Documentation - Job Application Tracker

## Tools Used
* **Gemini 3 Flash:** Used for backend architectural logic, SQL query optimization, and the design of the skill-matching algorithm.

## Feature Attribution & Prompts

### 1. Skill Matching Engine (`database.py` -> `get_job_matches`)
* **Prompt:** "Write a Python method for a class that takes a comma-separated string of user skills. It should query a MySQL table for job requirements stored in a JSON column, parse that JSON, and calculate a match percentage based on how many user skills exist in the job requirements. Sort the results from highest to lowest match."
* **AI Contribution:** Provided the core logic for splitting the user input, using `json.loads()` to process the database column, and performing the set intersection calculation for the percentage.

### 2. Multi-Query Dashboard Analytics (`app.py` -> `dashboard`)
* **Prompt:** "Create a Flask route for a dashboard that runs two separate COUNT queries: one for total applications and one for applications with a status of 'Interview' or 'Interview Completed'. Pass these values to the template in a single dictionary."
* **AI Contribution:** Designed the logic to handle multiple database interactions in a single route and the conditional check (`if app_data else 0`) to prevent errors if the table is empty.

### 3. Safety-First Delete Confirmation (`applications.html`)
* **Prompt:** "How do I implement a delete button in a Jinja2 template table that uses a standard HTML link but asks the user for confirmation before proceeding to the Flask route?"
* **AI Contribution:** Provided the `onclick="return confirm('...')"` JavaScript integration, which ensures the project meets the rubric requirement for safe CRUD operations.

### 4. Dynamic Select Dropdowns (`jobs.html` & `contacts.html`)
* **Prompt:** "How do I create an HTML select dropdown in a Flask template that is populated by a 'companies' list from a database, using the company ID as the value and the name as the label?"
* **AI Contribution:** Provided the Jinja2 `{% for %}` loop structure used across the "Add Job" and "Add Contact" forms to maintain relational integrity.

## 💡 Modifications & Manual Adjustments
* **Schema Refinement:** I manually added `ON DELETE CASCADE` to the foreign key constraints in `schema.sql` to ensure data integrity when companies are removed.
* **Status Workflow:** I modified the AI-generated status list to include "Interview Completed" as a specific tracking milestone and updated the dashboard query to include it.
* **UI Styling:** I manually integrated Bootstrap 5 classes (like `shadow-sm` and `border-left-success`) into the templates to create a clean, professional interface.

## Lessons Learned
* While AI is excellent for generating logic for JSON parsing, manual testing was required to ensure the skills were handled case-insensitively for a better user experience.
* The importance of database connection management (connect/disconnect) was a key takeaway to ensure the app remains stable during multiple consecutive CRUD operations.