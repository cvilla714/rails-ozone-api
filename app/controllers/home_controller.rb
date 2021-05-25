class HomeController < ApplicationController
  def index
    require 'net/http'
    require 'json'

    @url = 'https://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=33102&distance=0&API_KEY=457C10CA-B388-404F-AE61-77FD758B49EF'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @output = JSON.parse(@response)

    @final_output = if @output.empty?
                      'Error'
                    else
                      @output[0]['AQI']
                    end

    @api_color = case @final_output
                 when 0..50
                   'green'
                 when 51..100
                   'yellow'
                 when 101..150
                   'orange'
                 when 151..200
                   'red'
                 when 201..300
                   'purple'
                 when 301..500
                   'maroon'
                 else
                   'gray'
                 end
  end
end
