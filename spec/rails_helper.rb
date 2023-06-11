# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
require 'simplecov'
SimpleCov.start
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end
RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # You can uncomment this line to turn off ActiveRecord support entirely.
  # config.use_active_record = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, type: :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://rspec.info/features/6-0/rspec-rails
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
end

# vcr
VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock
  config.filter_sensitive_data('MAPQUEST_API_KEY') { ENV['MAPQUEST_API_KEY'] }
  config.filter_sensitive_data('WEATHER_API_KEY') { ENV['WEATHER_API_KEY'] }
  config.default_cassette_options = { re_record_interval: 7.days }
  config.default_cassette_options = { allow_playback_repeats: true }
  config.configure_rspec_metadata!
end

# shouldamatchers
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

def current_weather
  @data = {:last_updated_epoch=>1686441600,
  :last_updated=>"2023-06-10 20:00",
  :temp_c=>23.9,
  :temp_f=>75.0,
  :is_day=>1,
  :condition=>{:text=>"Partly cloudy", :icon=>"//cdn.weatherapi.com/weather/64x64/day/116.png", :code=>1003},
  :wind_mph=>2.2,
  :wind_kph=>3.6,
  :wind_degree=>263,
  :wind_dir=>"W",
  :pressure_mb=>1010.0,
  :pressure_in=>29.82,
  :precip_mm=>0.0,
  :precip_in=>0.0,
  :humidity=>37,
  :cloud=>50,
  :feelslike_c=>24.9,
  :feelslike_f=>76.9,
  :vis_km=>14.0,
  :vis_miles=>8.0,
  :uv=>6.0,
  :gust_mph=>7.2,
  :gust_kph=>11.5}
end

def daily_weather
  @data = {:date=>"2023-06-10",
      :date_epoch=>1686355200,
      :day=>
       {:maxtemp_c=>26.5,
        :maxtemp_f=>79.7,
        :mintemp_c=>14.2,
        :mintemp_f=>57.6,
        :avgtemp_c=>20.6,
        :avgtemp_f=>69.1,
        :maxwind_mph=>12.3,
        :maxwind_kph=>19.8,
        :totalprecip_mm=>0.2,
        :totalprecip_in=>0.01,
        :totalsnow_cm=>0.0,
        :avgvis_km=>10.0,
        :avgvis_miles=>6.0,
        :avghumidity=>50.0,
        :daily_will_it_rain=>1,
        :daily_chance_of_rain=>79,
        :daily_will_it_snow=>0,
        :daily_chance_of_snow=>0,
        :condition=>{:text=>"Patchy rain possible", :icon=>"//cdn.weatherapi.com/weather/64x64/day/176.png", :code=>1063},
        :uv=>5.0},
      :astro=>{:sunrise=>"05:25 AM", :sunset=>"08:26 PM", :moonrise=>"01:20 AM", :moonset=>"12:33 PM", :moon_phase=>"Last Quarter", :moon_illumination=>"59", :is_moon_up=>0, :is_sun_up=>1}
  }
end

def hourly_weather
  @data = {:time_epoch=>1686369600,
  :time=>"2023-06-10 00:00",
  :temp_c=>17.1,
  :temp_f=>62.8,
  :is_day=>0,
  :condition=>{:text=>"Partly cloudy", :icon=>"//cdn.weatherapi.com/weather/64x64/night/116.png", :code=>1003},
  :wind_mph=>7.4,
  :wind_kph=>11.9,
  :wind_degree=>324,
  :wind_dir=>"NW",
  :pressure_mb=>1008.0,
  :pressure_in=>29.75,
  :precip_mm=>0.0,
  :precip_in=>0.0,
  :humidity=>60,
  :cloud=>51,
  :feelslike_c=>17.1,
  :feelslike_f=>62.8,
  :windchill_c=>17.1,
  :windchill_f=>62.8,
  :heatindex_c=>17.1,
  :heatindex_f=>62.8,
  :dewpoint_c=>9.4,
  :dewpoint_f=>48.9,
  :will_it_rain=>0,
  :chance_of_rain=>0,
  :will_it_snow=>0,
  :chance_of_snow=>0,
  :vis_km=>10.0,
  :vis_miles=>6.0,
  :gust_mph=>10.1,
  :gust_kph=>16.2,
  :uv=>1.0}
end

def forecast
  current_weather
  cw = CurrentWeather.new(@data)
  daily_weather
  dw = DailyWeather.new(@data)
  hourly_weather
  hw = HourlyWeather.new(@data)

  @forecast = Forecast.new(cw, dw, hw)
end