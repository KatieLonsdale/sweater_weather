require 'rails_helper'

RSpec.describe 'User endpoints' do
  describe 'create new user' do
    describe 'happy path' do
      it 'creates user and returns user info' do
        user_params = {
          "email": "whatever@example.com",
          "password": "password",
          "password_confirmation": "password"
          }
        headers = {"CONTENT_TYPE" => "application/json"}
        
        post '/api/v0/users', headers: headers, params: JSON.generate(user: user_params)

        expect(response.status).to eq(201)
        data = JSON.parse(response.body, symbolize_names: true)

        expect(data[:data]).to have_key(:type)
        expect(data[:data]).to have_key(:id)
        expect(data[:data]).to have_key(:attributes)
        expect(data.dig(:data, :attributes)).to have_key(:email)
        expect(data.dig(:data, :attributes)).to have_key(:api_key)
        expect(data.dig(:data, :attributes)).to_not have_key(:password_digest)
      end
    end
  end
end