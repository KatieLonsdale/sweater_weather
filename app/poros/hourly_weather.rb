class HourlyWeather
  attr_reader :time, 
              :temperature, 
              :condition, 
              :icon
  def initialize(data)
    @time = format_time(data[:time])
    @temperature = data[:temp_f]
    @condition = data.dig(:condition, :text)
    @icon = data.dig(:condition, :icon)
  end

  def format_time(time)
    DateTime.parse(time).strftime("%-l:%M %p")
  end
end