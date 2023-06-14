# Sweater Weather API

## About
This project is a RESTful API that provides weather forecast and road trip information. It offers the following endpoints:

* GET /api/v0/forecast?location=Denver, CO
  * Returns the current, daily, and hourly forecast for a specified city (example above). City and state required.

* POST /api/v0/users
  * Use this endpoint to create a new user. Email, password, and password confirmation must be included as a JSON payload in the body of the request. Upon a successful creation, a user id and API key will be generated and returned in the response.

* POST /api/v0/sessions
  * Use this endpoint to log in an existing user. Email and password must be included as a JSON payload in the body of the request. Upon successful login, user's id, email, and API key will be returned in the response.

* POST /api/v0/road_trip
  * Use this endpoint to create a new road trip. Origin city, destination city, and a valid API key must be included as a JSON payload in the body of the request. If a valid request is sent over, details for the new road trip will be returned, including travel time and the weather forecast for the estimated time of arrival in the destination city.

## Set Up
1. In your local files, navigate to the directory you want this repository to be stored in.
2. Clone this repository using the git clone command.
3. Install gems by running `bundle install`
4. Set up database by running `rails db:{drop,create,migrate}`
5. You will need API keys for the below. Figaro is included in the Gemfile and it is recommended you use it for secure API key storage.
  * [MapQuest Developer]("https://developer.mapquest.com/documentation/)
  * [Weather API]("https://www.weatherapi.com/docs/")
6. Run `rails s` to start your localhost:3000

## Learning Goals
* Expose an API that aggregates data from multiple external APIs
* Expose an API that requires an authentication token
* Expose an API for CRUD functionality
* Determine completion criteria based on the needs of other developers
* Test both API consumption and exposure, making use of at least one mocking tool (VCR, Webmock, etc).