package api_test

import (
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/Kong/KongAir/flight-data/routes/api"
	"github.com/Kong/KongAir/flight-data/routes/api/models"
	"github.com/labstack/echo/v4"
	"github.com/stretchr/testify/assert"
)

func TestGetRoutes(t *testing.T) {
	// Create a new Echo instance
	e := echo.New()

	// Create a new RouteService
	routeService := api.NewRouteService()

	// Create a new HTTP request
	req := httptest.NewRequest(http.MethodGet, "/routes", nil)

	// Create a new HTTP response recorder
	rec := httptest.NewRecorder()

	// Create an Echo context
	ctx := e.NewContext(req, rec)

	// Call the GetRoutes function
	err := routeService.GetRoutes(ctx, models.GetRoutesParams{})

	// Assert that no error occurred
	assert.NoError(t, err)

	// Assert that the response status code is 200
	assert.Equal(t, http.StatusOK, rec.Code)
}

