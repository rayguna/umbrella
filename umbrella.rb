# 1. Greet user and prompt for location name

pp "howdy"

pp "Where are you located?"

user_location = gets.chomp.gsub(" ","%20")

##user_location = "Chicago"

pp user_location

# 2. Translate location name to geo-coordinates.
require "http"

maps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + user_location + "&key=" + ENV.fetch("GMAPS_KEY")

resp = HTTP.get(maps_url)

raw_response =  resp.to_s #maps_url

require"json"

parsed_response = JSON.parse(raw_response)

results = parsed_response.fetch("results")

geo = results[0]["geometry"]["location"]

latitude = geo["lat"]
longitude =geo["lng"]

pp latitude 
pp longitude

##pp parsed_response.keys

#fetch the hidden API key
##pirate_weather_api_key = ENV.fetch("PIRATE_WEATHER_KEY")

##pirate_weather_url = "https://api.pirateweather.net/forecast/" + pirate_weather_api_key + "41.8887, -87.6355"
