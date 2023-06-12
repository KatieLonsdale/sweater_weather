class BriefForecast
  attr_reader :summary, :temperature

  def initialize(data)
    @summary = data.dig(:condition, :text)
    @temperature = data[:temp_f]
  end
end