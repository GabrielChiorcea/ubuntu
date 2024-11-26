from flask import Flask, render_template, request, redirect, url_for
import subprocess
import os

app = Flask(__name__)

@app.route('/', methods=['GET', 'POST'])
def index():
    #uptime_command = 'bash /var/www/flaskapp/bashscripts/uptime_database.sh' 
    #result = subprocess.run(uptime_command, shell=True, check=True)
    path = '/var/www/flaskapp/uptime.txt'
   
    success_message = ""
    error_message = ""
    uptime_database = ""
    uptime_hour = ""

    if os.path.exists(path):
        with open(path, 'r') as file:
            uptime_database = file.read().strip() 
    
    
    uptime_start = float(uptime_database) / 3600
    uptime_hour = round(uptime_start)

    if request.method == "POST":
        if 'create_db' in request.form:
            db_name = request.form['db_name']
            db_user = request.form['db_user']
            db_password = request.form['db_password']
            mysql_server = request.form['mysql_server']


            create_command = f'bash /var/www/flaskapp/bashscripts/create_data_base.sh {db_name} {db_user} {db_password}'
            try:
                subprocess.run(create_command, shell=True, check=True)
                success_message = f"Database '{db_name}' has been created successfully."
            except subprocess.CalledProcessError as e:
                error_message = f"Error: {e}"

        elif 'run_query' in request.form:
            sql_query = request.form['sql_query']


            success_message = f"Query executed successfully on {mysql_server}."


    return render_template('index.html', uptime_hour=uptime_hour,  success_message=success_message, error_message=error_message)
    #return uptime_hour
if __name__ == "__main__":
    app.run(debug=True)
