# 1. Greet user and prompt for location name

line_width = 40

puts "~" * line_width
puts "Will you need an umbrella today?".center(line_width)
puts "~" * line_width
puts


pp "Where are you located?"

user_location = gets.chomp.gsub(" ","%20")

puts "\n"

##user_location = "Chicago"

#pp user_location

pp "Thanks. Checking the weather at #{user_location}..."

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

#pp latitude 
#pp longitude

pp "Your coordinates are: #{latitude}, #{longitude}."

# 3. get weather information

#fetch weather API key
pirate_weather_api_key = ENV.fetch("PIRATE_WEATHER_KEY")

pirate_weather_url = "https://api.pirateweather.net/forecast/" + pirate_weather_api_key + "/#{latitude},#{longitude}"

#pp pirate_weather_url
weather_url = HTTP.get(pirate_weather_url)
##pp weather_url

weather_json = JSON.parse(weather_url.to_s)
current = weather_json["currently"]

require 'tzinfo'
require 'time'

#get time
#pp Time.at(current["time"])
#change to local central time, CDT

#change from epoch to universal time
utc_time = Time.at(current["time"]).utc

#define CST time zone
#cst_timezone = TZInfo::Timezone.get('America/Chicago') # 'America/Chicago' represents the Central Time Zone

#convert UTC to CST
#cst_time = cst_timezone.utc_to_local(utc_time)

pp "The current date and time is: #{utc_time}"

pp "It is currently #{current["temperature"]} °F"

#add ascii chart: https://github.com/benlund/ascii_charts
require "ascii_charts"

puts "\n"

# Some locations around the world do not come with minutely data.
minutely_hash = weather_json.fetch("minutely", false)

if minutely_hash
  next_hour_summary = minutely_hash["summary"]

  puts "Next hour: #{next_hour_summary}"
end

hourly_hash = weather_json["hourly"]

hourly_data_array = hourly_hash["data"]

next_twelve_hours = hourly_data_array[1..12]

precip_prob_threshold = -1

any_precipitation = false

lst_precipitation = []

next_twelve_hours.each do |hour_hash|
  precip_prob = hour_hash.fetch("precipProbability")

  if precip_prob > precip_prob_threshold
    any_precipitation = true

    precip_time = Time.at(hour_hash.fetch("time"))

    seconds_from_now = precip_time - Time.now

    hours_from_now = seconds_from_now / 60 / 60

    #append data to array
    lst_precipitation.append([hours_from_now.round, precip_prob * 100.round])

    puts "In #{hours_from_now.round} hours, there is a #{(precip_prob * 100).round}% chance of precipitation."
  end
end

if any_precipitation == true
  puts "You might want to take an umbrella!"
else
  puts "You probably won't need an umbrella."
end

puts

pp "Hours from now vs Precipitation probability"
 

## 4. Plot data
#puts AsciiCharts::Cartesian.new([[0, 1], [1, 3], [2, 7], [3, 15], [4, 4]]).draw
puts AsciiCharts::Cartesian.new(lst_precipitation).draw
