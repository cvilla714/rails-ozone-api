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

    if @final_output == 'Error'
      @api_color = 'gray'
    elsif @final_output <= 50
      @api_color = 'green'
      @api_description = 'Good (0-50) Air quaility is Good'
    elsif @final_output >= 51 && @final_output <= 100
      @api_color = 'yellow'
      @api_description = 'Moderate (51-100) Air quality is acceptable,however, for some pollutants there may be moderate health concerns for a very small number of people who are usually sensitive to air pollution.'
    elsif @final_output >= 101 && @final_output <= 150
      @api_color = 'orange'
      @api_description = 'Unhealthy for Sensitive Groups (101-150) Although general public is not likely to be affected at this AQI range, people with lung diseases older adults and children are at a greater risk from exposure to ozone,whereas persons with heart and lung disease older adults and children are a greate risk from presence of particles in ther air'
    elsif @final_output >= 151 && @final_output <= 200
      @api_color = 'red'
      @api_color = 'Unhealthy. Everyone may beging to experience health effects, member of sensitve groups may experience serious health effects'
    elsif @final_output >= 201 && @final_output <= 300
      @api_color = 'purple'
      @api_description = 'Very Unhealthy.Everyone will experience some serious health effects'
    elsif @final_output >= 301 && @final_output <= 500
      @api_color = 'maroon'
      @api_description = 'Emercy Conditions. The entire population is more likely to be affected'
    end
    # @api_color = case @final_output
    #              when 0..50
    #                'green',
    #                @api_description = 'Good'
    #              when 51..100
    #                'yellow',
    #                @api_description = 'Moderate'
    #              when 101..150
    #                'orange',
    #                @api_description = 'Unhealthy for Sensitive Groups (USG)'
    #              when 151..200
    #                'red',
    #                @api_description = 'Unhealthy'
    #              when 201..300
    #                'purple',
    #                @api_description = 'Very Unhealthy'
    #              when 301..500
    #                'maroon',
    #                @api_description = 'Hazardous'
    #              else
    #                'gray'
    #              end
  end
end
