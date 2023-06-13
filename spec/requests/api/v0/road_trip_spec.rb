require 'rails_helper'

RSpec.describe 'Road trip endpoints' do
  describe 'create road trip' do
    describe 'happy path' do
      before(:all) do
        @keys = [:id, :type, :attributes]
        @attribute_keys = [:start_city, :end_city, :travel_time, :weather_at_eta]
        @weather_keys = [:datetime, :temperature, :condition]
      end
      it 'creates a road trip and returns the details', :vcr do
        user_1 = User.create!(email: "whatever@example.com", password: "password", password_confirmation: "password")
        user_1.api_key = "t1h2i3s4_i5s6_l7e8g9i10t11"

        road_trip_params = {
          origin: "Cincinatti,OH",
          destination: "Chicago,IL",
          api_key: "t1h2i3s4_i5s6_l7e8g9i10t11"
        }
        header = {'CONTENT_TYPE' => 'application/json'}
        post '/api/v0/road_trip', headers: header, params: JSON.generate(road_trip_params)

        expect(response.status).to eq(200)
        data = JSON.parse(response.body, symbolize_names: true)

        @keys.each do |key|
          expect(data[:data]).to have_key(key)
        end

        @attribute_keys.each do |key|
          expect(data.dig(:data, :attributes)).to have_key(key)
        end

        @weather_keys.each do |key|
          expect(data.dig(:data, :attributes, :weather_at_eta)).to have_key(key)
        end

        expect(data.dig(:data, :id)).to eq(nil)
        expect(data.dig(:data, :attributes, :start_city)).to eq("Cincinatti,OH")
        expect(data.dig(:data, :attributes, :end_city)).to eq("Chicago,IL")
      end
    end
  end
end