require 'rails_helper'

RSpec.describe 'User endpoints' do
  describe 'create new user' do
    describe 'happy path' do
      it 'creates user and returns user info' do
        user_params = {
          email: "whatever@example.com",
          password: "password",
          password_confirmation: "password"
          }
        headers = {"CONTENT_TYPE" => "application/json"}
        post '/api/v0/users', headers: headers, params: JSON.generate(user_params)

        expect(response.status).to eq(201)
        data = JSON.parse(response.body, symbolize_names: true)

        expect(data[:data]).to have_key(:type)
        expect(data.dig(:data, :type)).to eq('user')
        expect(data[:data]).to have_key(:id)
        expect(data[:data]).to have_key(:attributes)
        expect(data.dig(:data, :attributes)).to have_key(:email)
        expect(data.dig(:data, :attributes, :email)).to eq(user_params[:email])
        expect(data.dig(:data, :attributes)).to have_key(:api_key)
        expect(data.dig(:data, :attributes)).to_not have_key(:password_digest)
      end
    end
    describe 'sad path' do
      it 'returns an error if the email already exists' do
        user_1 = User.create!(email: "whatever@example.com", password: "password", password_confirmation: "password")

        user_params = {
          email: user_1.email,
          password: "password",
          password_confirmation: "password"
          }
        headers = {"CONTENT_TYPE" => "application/json"}
        post '/api/v0/users', headers: headers, params: JSON.generate(user_params)

        expect(response.status).to eq(422)
        data = JSON.parse(response.body, symbolize_names: true)

        expect(data.dig(:error, :message)).to eq("Validation failed: Email has already been taken")
      end
      it 'returns an error if passwords dont match' do
        user_params = {
          email: 'something@example.com',
          password: "password",
          password_confirmation: "password1"
          }
        headers = {"CONTENT_TYPE" => "application/json"}
        post '/api/v0/users', headers: headers, params: JSON.generate(user_params)

        expect(response.status).to eq(422)
        data = JSON.parse(response.body, symbolize_names: true)

        expect(data.dig(:error, :message)).to eq("Validation failed: Password confirmation doesn't match Password")
      end
      it 'returns an error if a field is blank' do
        user_params = {
          email: '',
          password: "password",
          password_confirmation: "password"
          }
        headers = {"CONTENT_TYPE" => "application/json"}
        post '/api/v0/users', headers: headers, params: JSON.generate(user_params)

        expect(response.status).to eq(422)
        data = JSON.parse(response.body, symbolize_names: true)

        expect(data.dig(:error, :message)).to eq("Validation failed: Email can't be blank")
      end
    end
  end
  describe 'log in user' do
    describe 'happy path' do
      it 'returns successful response with user information' do
        user_1 = User.create!(email: "whatever@example.com", password: "password", password_confirmation: "password")
        user_params = {
            email: "whatever@example.com",
            password: "password"
          }
        headers = {"CONTENT_TYPE" => "application/json"}
        
        post '/api/v0/sessions', headers: headers, params: JSON.generate(user_params)
        data = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(200)

        expect(data[:data]).to have_key(:type)
        expect(data.dig(:data, :type)).to eq('user')

        expect(data[:data]).to have_key(:id)
        expect(data.dig(:data, :id)).to eq(user_1.id.to_s)

        expect(data[:data]).to have_key(:attributes)
        expect(data.dig(:data, :attributes)).to have_key(:email)
        expect(data.dig(:data, :attributes, :email)).to eq(user_1.email)
        expect(data.dig(:data, :attributes)).to have_key(:api_key)
        expect(data.dig(:data, :attributes, :api_key)).to eq(user_1.api_key)
        expect(data.dig(:data, :attributes)).to_not have_key(:password_digest)
      end
    end
  end
end