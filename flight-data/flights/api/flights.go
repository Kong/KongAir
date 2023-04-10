//go:generate go run github.com/deepmap/oapi-codegen/cmd/oapi-codegen --config=models.cfg.yaml ../openapi.yaml
//go:generate go run github.com/deepmap/oapi-codegen/cmd/oapi-codegen --config=server.cfg.yaml ../openapi.yaml

package api

import (
	"github.com/Kong/KongAir/flight-data/flights/api/models"
	"github.com/labstack/echo/v4"
)

type FlightService struct {
	Flights []models.Flight
}

func NewFlightService() *FlightService {
	rv := FlightService{}
	rv.Flights = []models.Flight{
		//{Origin: "LHR", Destination: "JFK"},
	}
	return &rv
}

func (s *FlightService) GetFlights(ctx echo.Context, params models.GetFlightsParams) error {
	err := ctx.JSON(200, s.Flights)
	if err != nil {
		return err
	}
	return nil
}
