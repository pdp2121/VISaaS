import sqlite3
from flask import (
    Flask, request, session, g, redirect, url_for, abort,
    render_template, flash, send_file)
from contextlib import closing
from weather import Weather

# Configuration
DATABASE = 'flaskr.db'
DEBUG = True
SECRET_KEY = 'development key'
USERNAME = 'admin'
PASSWORD = 'default'
DOWNLOAD_FOLDER = 'data/'

app = Flask(__name__)
app.config.from_object(__name__)


def connect_db():
    return sqlite3.connect(app.config['DATABASE'])


def init_db():
    with closing(connect_db()) as db:
        with app.open_resource('schema.sql') as f:
            db.cursor().executescript(f.read())
        db.commit()


@app.before_request
def before_request():
    g.db = connect_db()


@app.teardown_request
def teardown_request(exception):
    g.db.close()


@app.route('/')
def show_entries():
    cur = g.db.execute('select title, text from entries order by id desc')
    entries = [dict(title=row[0], text=row[1]) for row in cur.fetchall()]
    return render_template('show_entries.html', entries=entries)

@app.route('/weather', methods=['GET', 'POST'])
def show_weather():
    error = None
    weather = None
    if request.method == 'POST':
        w = Weather()
        weather = w.getCurrentWeather(request.form['cityname'])
        if not weather:
            error = 'Invalid city name'
    return render_template('weather.html', error=error, weather = weather)

@app.route('/downloadfiles/<filename>')
def download_files(filename):
    file_path = DOWNLOAD_FOLDER + filename
    return send_file(file_path, as_attachment=True, attachment_filename='')

@app.route('/weather_forecast', methods=['GET', 'POST'])
def get_weather_forecast():
    error = None
    forecast = None
    city = None
    times = None
    if request.method == 'POST':
        city = request.form['city_name']
        forecast, times = Weather().forecast(city)
        if not forecast:
            error = 'Error fetching forecast'   
    return render_template('forecast.html', error=error, forecast = forecast, city=city, times=times)



@app.route('/add', methods=['POST'])
def add_entry():
    if not session.get('logged_in'):
        abort(401)
    g.db.execute('insert into entries (title, text) values (?, ?)',
                 [request.form['title'], request.form['text']])
    g.db.commit()
    flash('New entry was successfully posted')
    return redirect(url_for('show_entries'))


@app.route('/login', methods=['GET', 'POST'])
def login():
    error = None
    if request.method == 'POST':
        if request.form['username'] != app.config['USERNAME']:
            error = 'Invalid username'
        elif request.form['password'] != app.config['PASSWORD']:
            error = 'Invalid password'
        else:
            session['logged_in'] = True
            flash('You were logged in')
            return redirect(url_for('show_entries'))
    return render_template('login.html', error=error)


@app.route('/logout')
def logout():
    session.pop('logged_in', None)
    flash('You were logged out')
    return redirect(url_for('show_entries'))


if __name__ == '__main__':
    app.run()
