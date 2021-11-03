import sqlite3
from flask import (
    Flask, request, session, g, redirect, url_for, abort,
    render_template, flash, send_file)
from contextlib import closing
from custom.weather import Weather

# Configuration
DEBUG = True
SECRET_KEY = 'development key'
USERNAME = 'admin'
PASSWORD = 'default'
DOWNLOAD_FOLDER = 'data/'

app = Flask(__name__)
app.config.from_object(__name__)


@app.route('/')
def show_entries():
    return render_template('show_entries.html')

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


if __name__ == '__main__':
    app.run()
