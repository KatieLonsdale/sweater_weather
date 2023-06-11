class Forecast
  attr_reader :current_weather, :daily_weather, :hourly_weather

  def initialize(cw, dw, hw)
    @current_weather = cw
    @daily_weather = dw
    @hourly_weather = hw
  end
end