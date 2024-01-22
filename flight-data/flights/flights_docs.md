
# KongAir Flights Service API Documentation

## Overview
KongAir Flights service offers information about scheduled flights for KongAir. This documentation provides details on various endpoints and their responses.

### API Information
- **Version:** 0.1.0
- **Title:** Flights Service
- **Contact:** Kong Education (learn@konghq.com)

## Endpoints

### Health Check
- **Endpoint:** `/health`
- **Method:** GET
- **Description:** Checks the health status of the service. Suitable for Kubernetes health checks.
- **Responses:**
  - `200`: Service is healthy.
  - `500`: Service is unhealthy.

### Get All Flights
- **Endpoint:** `/flights`
- **Method:** GET
- **Description:** Retrieves all scheduled flights for a given day.
- **Query Parameters:**
  - `date`: Filter by date (defaults to current day)
- **Responses:**
  - `200`: Successful response with scheduled flights.

### Get Specific Flight
- **Endpoint:** `/flights/{flightNumber}`
- **Method:** GET
- **Description:** Fetches a specific flight using its flight number.
- **Path Parameters:**
  - `flightNumber`: The flight number.
- **Responses:**
  - `200`: Successful response with the requested flight.
  - `404`: Flight not found.

### Fetch Flight Details
- **Endpoint:** `/flights/{flightNumber}/details`
- **Method:** GET
- **Description:** Provides more detailed information about a specific flight.
- **Path Parameters:**
  - `flightNumber`: The flight number.
- **Responses:**
  - `200`: Successful response with detailed flight information.
  - `404`: Flight not found.

## Schemas

### Flight
- **Properties:**
  - `number`: Flight number.
  - `route_id`: Route identifier.
  - `scheduled_departure`: Scheduled departure time.
  - `scheduled_arrival`: Scheduled arrival time.

### Flight Details
- **Properties:**
  - `flight_number`: Flight number.
  - `in_flight_entertainment`: Availability of in-flight entertainment.
  - `meal_options`: Available meal options.
  - `aircraft_type`: Type of aircraft.

## Server Information
- **URL:** [https://api.kong-air.com](https://api.kong-air.com)
- **Description:** KongAir API Server
