from flask import Flask, render_template, request, redirect, url_for
from database import JobTrackerDB

app = Flask(__name__)
db = JobTrackerDB()

@app.route('/')
def dashboard():
    if db.connect():
        cursor = db.connection.cursor(dictionary=True)
        
        cursor.execute('SELECT COUNT(*) as total FROM applications')
        app_data = cursor.fetchone()
        total_apps = app_data['total'] if app_data else 0
        
        query = "SELECT COUNT(*) as total FROM applications WHERE status IN ('Interview', 'Interview Completed')"
        cursor.execute(query)
        int_data = cursor.fetchone()
        interviews = int_data['total'] if int_data else 0
        
        db.disconnect()
        
        stats = {
            'total_apps': total_apps,
            'interviews': interviews
        }
        return render_template('dashboard.html', stats=stats)
    return "Database Connection Failed!"

@app.route('/companies')
def companies_list():
    if db.connect():
        companies = db.get_all_companies()
        db.disconnect()
        return render_template('companies.html', companies=companies)
    return "DB Error"

@app.route('/companies/add', methods=['POST'])
def add_company():
    if db.connect():
        db.add_company(
            request.form.get('name'),
            request.form.get('industry'),
            request.form.get('website'),
            request.form.get('city'),
            request.form.get('state')
        )
        db.disconnect()
    return redirect(url_for('companies_list'))

@app.route('/jobs')
def jobs_list():
    if db.connect():
        jobs = db.get_all_jobs_with_companies()
        companies = db.get_all_companies()
        db.disconnect()
        return render_template('jobs.html', jobs=jobs, companies=companies)
    return "DB Error"

@app.route('/jobs/add', methods=['POST'])
def add_job():
    if db.connect():
        db.add_job(
            request.form.get('company_id'),
            request.form.get('title'),
            request.form.get('job_type'),
            request.form.get('salary_min'),
            request.form.get('salary_max')
        )
        db.disconnect()
    return redirect(url_for('jobs_list'))

@app.route('/applications')
def applications_list():
    if db.connect():
        apps = db.get_all_applications()
        jobs = db.get_all_jobs_with_companies()
        db.disconnect()
        return render_template('applications.html', apps=apps, jobs=jobs)
    return "DB Error"

@app.route('/applications/add', methods=['POST'])
def add_application():
    if db.connect():
        db.add_application(
            request.form.get('job_id'),
            request.form.get('date'),
            request.form.get('status'),
            request.form.get('resume')
        )
        db.disconnect()
    return redirect(url_for('applications_list'))

@app.route('/applications/update/<int:app_id>', methods=['POST'])
def update_status(app_id):
    if db.connect():
        db.update_application_status(app_id, request.form.get('status'))
        db.disconnect()
    return redirect(url_for('applications_list'))

@app.route('/contacts')
def contacts_list():
    if db.connect():
        contacts = db.get_all_contacts()
        companies = db.get_all_companies()
        db.disconnect()
        return render_template('contacts.html', contacts=contacts, companies=companies)
    return "DB Error"

@app.route('/contacts/add', methods=['POST'])
def add_contact():
    if db.connect():
        db.add_contact(
            request.form.get('company_id'),
            request.form.get('first_name'),
            request.form.get('last_name'),
            request.form.get('email'),
            request.form.get('title')
        )
        db.disconnect()
    return redirect(url_for('contacts_list'))

@app.route('/match', methods=['GET', 'POST'])
def job_match():
    results = []
    user_skills = ""
    if request.method == 'POST':
        user_skills = request.form.get('skills')
        if db.connect():
            results = db.get_job_matches(user_skills)
            db.disconnect()
    return render_template('job_match.html', results=results, user_skills=user_skills)
    
@app.route('/applications/delete/<int:app_id>')
def delete_app(app_id):
    if db.connect():
        db.delete_application(app_id)
        db.disconnect()
    return redirect(url_for('applications_list'))

if __name__ == '__main__':
    app.run(debug=True)