# Sweater Weather API

## About
This project is a RESTful API that provides weather forecast and road trip information. It offers the following endpoints:

# API Endpoints

## **GET /api/v0/forecast**
Fetches the current, daily, and hourly forecast for a specified city. 

**Query Parameters:**
- `location`: Required. City and state in the format `City, State`.

**Example Request:**
```http
GET /api/v0/forecast?location=Denver, CO
```

**Example Response:**
```http
{
  "current": {
    "temperature": 72,
    "conditions": "Partly Cloudy"
  },
  "daily": [
    {
      "date": "2025-01-24",
      "high": 75,
      "low": 50,
      "conditions": "Sunny"
    }
  ],
  "hourly": [
    {
      "time": "13:00",
      "temperature": 72,
      "conditions": "Partly Cloudy"
    }
  ]
}
```

## POST /api/v0/users
Use this endpoint to create a new user.

Request Body:

- email (string): Required. The user's email.
- password (string): Required. The user's password.
- password_confirmation (string): Required. Must match the password.

Example Request:

```http
POST /api/v0/users
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "securepassword123",
  "password_confirmation": "securepassword123"
}
```

Example Response:

```http
{
  "user_id": "12345",
  "api_key": "abcdef1234567890"
}
```
## POST /api/v0/sessions
Use this endpoint to log in an existing user.

Request Body:

- email (string): Required. The user's email.
- password (string): Required. The user's password.
Example Request:

```http
POST /api/v0/sessions
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "securepassword123"
}
```
Example Response:
```http
{
  "user_id": "12345",
  "email": "user@example.com",
  "api_key": "abcdef1234567890"
}
```

## POST /api/v0/road_trip
Use this endpoint to create a new road trip.

Request Body:

- origin (string): Required. The starting city.
- destination (string): Required. The destination city.
- api_key (string): Required. A valid API key for the user.


Example Request:

```http
POST /api/v0/road_trip
Content-Type: application/json

{
  "origin": "Denver, CO",
  "destination": "Boulder, CO",
  "api_key": "abcdef1234567890"
}
```

Example Response:
```http
{
  "origin": "Denver, CO",
  "destination": "Boulder, CO",
  "travel_time": "45 minutes",
  "forecast": {
    "temperature": 65,
    "conditions": "Sunny"
  }
}
```

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
