import mysql.connector
from mysql.connector import Error
import json

class JobTrackerDB:
    def __init__(self):
        self.config = {
            'host': '127.0.0.1',
            'user': 'root',
            'password': 'root', # Ensure this matches your MySQL password
            'database': 'job_tracker'
        }
        self.connection = None

    def connect(self):
        try:
            self.connection = mysql.connector.connect(**self.config)
            return True
        except Error as e:
            print(f"Connection error: {e}")
            return False

    def disconnect(self):
        if self.connection and self.connection.is_connected():
            self.connection.close()

    def get_all_companies(self):
        cursor = self.connection.cursor(dictionary=True)
        cursor.execute("SELECT * FROM companies ORDER BY company_id")
        return cursor.fetchall()

    def add_company(self, name, industry, website, city, state):
        cursor = self.connection.cursor()
        query = """INSERT INTO companies (company_name, industry, website, city, state) 
                   VALUES (%s, %s, %s, %s, %s)"""
        values = (name, industry, website, city, state)
        cursor.execute(query, values)
        self.connection.commit()

    def get_all_jobs_with_companies(self):
        cursor = self.connection.cursor(dictionary=True)
        query = """
            SELECT j.*, c.company_name 
            FROM jobs j 
            JOIN companies c ON j.company_id = c.company_id
        """
        cursor.execute(query)
        return cursor.fetchall()

    def add_job(self, company_id, title, job_type, salary_min, salary_max):
        cursor = self.connection.cursor()
        query = """INSERT INTO jobs (company_id, job_title, job_type, salary_min, salary_max) 
                   VALUES (%s, %s, %s, %s, %s)"""
        values = (company_id, title, job_type, salary_min, salary_max)
        cursor.execute(query, values)
        self.connection.commit()

    def get_all_applications(self):
        cursor = self.connection.cursor(dictionary=True)
        query = """
            SELECT a.*, j.job_title, c.company_name 
            FROM applications a
            JOIN jobs j ON a.job_id = j.job_id
            JOIN companies c ON j.company_id = c.company_id
            ORDER BY a.application_date DESC
        """
        cursor.execute(query)
        return cursor.fetchall()

    def add_application(self, job_id, date, status, resume):
        cursor = self.connection.cursor()
        query = """INSERT INTO applications (job_id, application_date, status, resume_version) 
                   VALUES (%s, %s, %s, %s)"""
        cursor.execute(query, (job_id, date, status, resume))
        self.connection.commit()

    def update_application_status(self, app_id, new_status):
        cursor = self.connection.cursor()
        query = "UPDATE applications SET status = %s WHERE application_id = %s"
        cursor.execute(query, (new_status, app_id))
        self.connection.commit()

    def get_all_contacts(self):
        cursor = self.connection.cursor(dictionary=True)
        query = """
            SELECT ct.*, co.company_name 
            FROM contacts ct
            JOIN companies co ON ct.company_id = co.company_id
        """
        cursor.execute(query)
        return cursor.fetchall()

    def add_contact(self, company_id, first_name, last_name, email, title):
        cursor = self.connection.cursor()
        query = """INSERT INTO contacts (company_id, first_name, last_name, email, job_title) 
                   VALUES (%s, %s, %s, %s, %s)"""
        cursor.execute(query, (company_id, first_name, last_name, email, title))
        self.connection.commit()

    def get_job_matches(self, user_skills):
        user_skills_list = [s.strip().lower() for s in user_skills.split(',')]
        cursor = self.connection.cursor(dictionary=True)
        cursor.execute("SELECT j.job_title, c.company_name, j.requirements FROM jobs j JOIN companies c ON j.company_id = c.company_id")
        all_jobs = cursor.fetchall()
        
        matches = []
        for job in all_jobs:
            if job['requirements']:
                job_reqs = json.loads(job['requirements'])
                job_reqs_lower = [r.lower() for r in job_reqs]
                found = [skill for skill in user_skills_list if skill in job_reqs_lower]
                percent = (len(found) / len(job_reqs_lower)) * 100 if job_reqs_lower else 0
                matches.append({
                    'title': job['job_title'],
                    'company': job['company_name'],
                    'percent': round(percent),
                    'found': found,
                    'total_reqs': len(job_reqs_lower)
                })
        return sorted(matches, key=lambda x: x['percent'], reverse=True)
        
    def delete_application(self, app_id):
        cursor = self.connection.cursor()
        query = "DELETE FROM applications WHERE application_id = %s"
        cursor.execute(query, (app_id,))
        self.connection.commit()