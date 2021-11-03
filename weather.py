import requests, json
 
# Enter your API key here
class Weather():
    def __init__(self):
        self.api_key = "ade2a800bae9976517a8880b320bab8c"
        self.base_url = "http://api.openweathermap.org/data/2.5/weather?"
    def getCurrentWeather(self, city_name):
        complete_url = self.base_url + "&q=" + city_name + "&appid=" + self.api_key + "&q=" + city_name
        response = requests.get(complete_url)
        x = response.json()
        if x["cod"] == "200":
            y = x["main"]
            ret = {}
            ret["current_temperature"] = round(y["temp"] - 273.15, 2)
            ret["current_pressure"] = y["pressure"]
            ret["current_humidity"] = y["humidity"]
            ret["description"] = x["weather"][0]["description"]
            return ret
        else:
            return None

    def forecast(self, city_name):
        complete_url = 'http://api.openweathermap.org/data/2.5/forecast?appid=' + self.api_key + "&q=" + city_name + '&units=metric'
        response = requests.get(complete_url)
        x = response.json()
        if x['cod'] == '200':
            l = x['list']
            temp = [y['main']['temp'] for y in l]
            time = [y['dt_txt'] for y in l]
            return temp, time
        else:
            return None