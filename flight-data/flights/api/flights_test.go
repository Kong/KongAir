package api_test

import (
	"testing"
	"net/http"
	"net/http/httptest"

	"github.com/Kong/KongAir/flight-data/flights/api"
	"github.com/Kong/KongAir/flight-data/flights/api/models"
	"github.com/labstack/echo/v4"
	"github.com/stretchr/testify/assert"
)

func TestGetFlights(t *testing.T) {
	// Create a new Echo instance
	e := echo.New()

	// Create a new FlightService
	flightService := api.NewFlightService()

	// Create a new HTTP request
	req := httptest.NewRequest(http.MethodGet, "/flights", nil)

	// Create a new HTTP response recorder
	rec := httptest.NewRecorder()

	// Create an Echo context
	ctx := e.NewContext(req, rec)

	// Call the GetFlights method
	err := flightService.GetFlights(ctx, models.GetFlightsParams{})

	// Assert that no error occurred
	assert.NoError(t, err)

	// Assert that the response status code is 200
	assert.Equal(t, http.StatusOK, rec.Code)
}

func TestGetFlightByNumber(t *testing.T) {
	// Create a new Echo instance
	e := echo.New()

	// Create a new FlightService
	flightService := api.NewFlightService()

	// Create a new HTTP request with the flight number "KA0284"
	req := httptest.NewRequest(http.MethodGet, "/flights/KA0284", nil)

	// Create a new HTTP response recorder
	rec := httptest.NewRecorder()

	// Create an Echo context
	ctx := e.NewContext(req, rec)
	ctx.SetParamNames("flightNumber")
	ctx.SetParamValues("KA0284")

	// Call the GetFlightByNumber method
	err := flightService.GetFlightByNumber(ctx, "KA0284")

	// Assert that no error occurred
	assert.NoError(t, err)

	// Assert that the response status code is 200
	assert.Equal(t, http.StatusOK, rec.Code)
}

func TestGetFlightDetails(t *testing.T) {
	// Create a new Echo instance
	e := echo.New()

	// Create a new FlightService
	flightService := api.NewFlightService()

	// Create a new HTTP request with the flight number "KA0284"
	req := httptest.NewRequest(http.MethodGet, "/flights/KA0284/details", nil)

	// Create a new HTTP response recorder
	rec := httptest.NewRecorder()

	// Create an Echo context
	ctx := e.NewContext(req, rec)
	ctx.SetParamNames("flightNumber")
	ctx.SetParamValues("KA0284")

	// Call the GetFlightDetails method
	err := flightService.GetFlightDetails(ctx, "KA0284")

	// Assert that no error occurred
	assert.NoError(t, err)

	// Assert that the response status code is 200
	assert.Equal(t, http.StatusOK, rec.Code)
}

