class DailyWeather
  attr_reader :date, 
              :sunrise, 
              :sunset, 
              :max_temp, 
              :min_temp, 
              :condition, 
              :icon
            
  def initialize(data)
    @date = data[:date] 
    @sunrise = data.dig(:astro, :sunrise)
    @sunset = data.dig(:astro, :sunset)
    @max_temp = data.dig(:day, :maxtemp_f)
    @min_temp = data.dig(:day, :mintemp_f)
    @condition = data.dig(:day, :condition, :text)
    @icon = data.dig(:day, :condition, :icon)
  end
end