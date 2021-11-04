import os
from app import *
import unittest
from flask import (
    Flask, request, session, g, redirect, url_for, abort,
    render_template, flash, send_file)
from custom.weather import Weather

class FlaskrTestCase(unittest.TestCase):
    def test_show_entries(self):
        client = app.test_client()
        page = client.get('/', follow_redirects = True)
        assert ("Sample Data".encode('utf-8') in page.data) and ("Plot Tools".encode('utf-8') in page.data) and ("ViSaaS".encode('utf-8') in page.data)
    def test_show_weather(self):
        client = app.test_client()
        page = client.get('/weather', follow_redirects = True)
        assert ("Weather Data".encode('utf-8') in page.data) and ("Enter a City Name:".encode('utf-8') in page.data) and ("Download Data".encode('utf-8') in page.data)
    def test_show_weather_filter(self, filter = "London"):
        client = app.test_client()
        page = client.post('/weather', data = dict(filter = filter), follow_redirects = True)
        assert ("Current temperature".encode('utf-8') in page.data) and ("Enter a City Name:".encode('utf-8') in page.data) and ("Download Data".encode('utf-8') in page.data)
    def test_show_weather_filter(self, filter = "London"):
        client = app.test_client()
        page = client.post('/weather', data = dict(filter = filter), follow_redirects = True)
        assert ("Current temperature".encode('utf-8') in page.data) and ("Enter a City Name:".encode('utf-8') in page.data) and ("Download Data".encode('utf-8') in page.data)
    def test_show_weather_filter_error(self, filter = "random (not a city)"):
        client = app.test_client()
        page = client.post('/weather', data = dict(filter = filter), follow_redirects = True)
        assert ("Invalid city name".encode('utf-8') in page.data) and ("Enter a City Name:".encode('utf-8') in page.data) and ("Download Data".encode('utf-8') in page.data)
    def test_get_weather_forecast(self):
        client = app.test_client()
        page = client.get('/weather_visualization', follow_redirects = True)
        assert ("Weather Forecast".encode('utf-8') in page.data) and ("Enter a City Name:".encode('utf-8') in page.data) and ("Back to Home Page".encode('utf-8') in page.data)
    def test_get_weather_forecast_filter(self, filter = 'London'):
        client = app.test_client()
        page = client.post('/weather_visualization', data = dict(filter = filter), follow_redirects = True)
        assert ("Temperature Forecast for London".encode('utf-8') in page.data) and ("Enter a City Name:".encode('utf-8') in page.data) and ("Back to Home Page".encode('utf-8') in page.data)
    def test_get_current_weather(self):
        w = Weather()
        try:
            w.getCurrentWeather("London")
        except:
            self.fail("error raised")
    def test_forecast_weather(self):
        w = Weather()
        try:
            w.forecast("London")
        except:
            self.fail("error raised")
if __name__ == '__main__':
    unittest.main()
