# Job Application Tracker
A full-stack web application designed to manage the end-to-end job search process, featuring advanced data tracking and skill-matching logic.

## Key Features
* **Live Dashboard:** Real-time metrics for total applications and scheduled interviews.
* **Full CRUD Functionality:** Create, Read, Update, and Delete capabilities across Companies, Jobs, and Applications.
* **Safety First:** Implementation of JavaScript confirmation popups for all delete actions to prevent accidental data loss.
* **Job Matcher:** A specialized algorithm that parses **JSON-stored job requirements** to calculate a user's skill-match percentage.

## Tech Stack
* **Backend:** Python 3.12+ with Flask.
* **Database:** MySQL 8.0+ using `mysql-connector-python`.
* **Frontend:** Bootstrap 5, Jinja2 Templates, and Custom CSS.

## Setup & Installation
1.  **Clone/Download** this repository to your local machine.
2.  **Database Setup:**
    * Import `schema.sql`. This file contains the full schema plus 18 pre-loaded jobs with JSON skill data so the **Job Matcher** works.
3.  **How to Import:**
    * Open MySQL Workbench.
    * Go to **Server > Data Import**.
    * Select **"Import from Self-Contained File"** and choose your preferred `.sql` file.
    * Select **"Default Target Schema"** (or create one named `job_tracker`) and click **Start Import**.
4.  **Configure Credentials:**
    * Open `database.py` and ensure the `password` in the `__init__` method matches your local MySQL root password.
5.  **Install Dependencies:**
    * Run `pip install -r requirements.txt`.
6.  **Launch:**
    * Run `python app.py` and visit `http://127.0.0.1:5000`.

## Documentation & Credits
* **AI Usage:** Detailed disclosure of Generative AI assistance is provided in `AI_USAGE.md`.
* **Project Specs:** Built to satisfy the "Excellent" criteria for the COP4751 final project rubric.