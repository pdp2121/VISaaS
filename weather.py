import requests, json
 
# Enter your API key here
class Weather(object):
    def __init__(self):
        self.api_key = "ade2a800bae9976517a8880b320bab8c"
        self.base_url = "http://api.openweathermap.org/data/2.5/weather?"
    def getCurrentWeather(self, city_name):
        complete_url = self.base_url + "appid=" + self.api_key + "&q=" + city_name
        response = requests.get(complete_url)
        x = response.json()
        if x["cod"] != "404":
            y = x["main"]
            ret = {}
            ret["current_temperature"] = y["temp"]
            ret["current_pressure"] = y["pressure"]
            ret["current_humidity"] = y["humidity"]
            ret["description"] = x["weather"][0]["description"]
            return ret
        else:
            return None