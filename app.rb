require "sinatra"
require "sinatra/reloader"
require "http"

get("/") do

  # build the API url, including the API key in the query string
  api_url = "https://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATE_KEY"]}"

  # use HTTP.get to retrieve the API information
  raw_data = HTTP.get(api_url)

  # convert the raw request to a string
  raw_data_string = raw_data.to_s

  # convert the string to JSON and extract currencies
  parsed_data = JSON.parse(raw_data_string)

  @symbols = parsed_data.fetch("currencies")

  # render a view template where I show the symbols
  erb(:homepage)

end

get("/:from_currency") do
  @original_currency = params.fetch("from_currency")

  api_url = "https://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATE_KEY"]}"
  
  # use HTTP.get to retrieve the API information
  raw_data = HTTP.get(api_url)

  # convert the raw request to a string
  raw_data_string = raw_data.to_s

  # convert the string to JSON and extract currencies
  parsed_data = JSON.parse(raw_data_string)

  @symbols = parsed_data.fetch("currencies")

  # render a view template where I show the symbols
  erb(:convert_request)

end
