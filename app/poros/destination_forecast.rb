class DestinationForecast
  attr_reader :datetime, :temperature, :condition

  def initialize(data)
    @datetime = data[:time]
    @temperature = data[:temp_f]
    @condition = data.dig(:condition, :text)
  end
end