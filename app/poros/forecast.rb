class Forecast
  attr_reader :id, :current_weather, :daily_weather, :hourly_weather

  def initialize(cw, dw, hw)
    @id = nil
    @current_weather = cw
    @daily_weather = dw
    @hourly_weather = hw
  end
end