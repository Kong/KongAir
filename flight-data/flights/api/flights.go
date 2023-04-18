//go:generate go run github.com/deepmap/oapi-codegen/cmd/oapi-codegen --config=models.cfg.yaml ../openapi.yaml
//go:generate go run github.com/deepmap/oapi-codegen/cmd/oapi-codegen --config=server.cfg.yaml ../openapi.yaml

package api

import (
	"time"

	"github.com/Kong/KongAir/flight-data/flights/api/models"
	"github.com/labstack/echo/v4"
)

func NewFlight(number, destination, origin string, scheduledArrival, scheduledDeparture time.Time) models.Flight {
	return models.Flight{
		Number: number,
		Route: struct {
			Destination *string `json:"destination,omitempty"`
			Origin      *string `json:"origin,omitempty"`
		}{
			Destination: stringPtr(destination),
			Origin:      stringPtr(origin),
		},
		ScheduledArrival:   timePtr(scheduledArrival),
		ScheduledDeparture: timePtr(scheduledDeparture),
	}
}
func generateSampleFlights() []models.Flight {
	/*
			London (LHR) to New York (JFK)
		London (LHR) to Los Angeles (LAX)
		London (LHR) to Dubai (DXB)
		London (LHR) to Hong Kong (HKG)
		London (LHR) to Mumbai (BOM)
		London (LHR) to Tokyo (HND)
		London (LHR) to Cape Town (CPT)
		London (LHR) to Sydney (SYD)
		London (LHR) to San Francisco (SFO)
		London (LHR) to Singapore (SIN)
	*/
	flights := []models.Flight{
		NewFlight("KA123",
			"LHR", "JFK",
			time.Date(2024, 4, 5, 8, 25, 0, 0, time.UTC),
			time.Date(2023, 4, 5, 16, 5, 0, 0, time.UTC)),
		NewFlight("KA0285",
			"LHR", "SFO",
			time.Date(2024, 4, 3, 11, 10, 0, 0, time.UTC),
			time.Date(2024, 4, 3, 22, 15, 0, 0, time.UTC)),
	}
	return flights
}

func stringPtr(str string) *string {
	return &str
}
func timePtr(t time.Time) *time.Time {
	return &t
}

type FlightService struct {
	Flights []models.Flight
}

func NewFlightService() *FlightService {
	rv := FlightService{}
	rv.Flights = generateSampleFlights()
	return &rv
}

func (s *FlightService) GetFlights(ctx echo.Context, params models.GetFlightsParams) error {
	err := ctx.JSON(200, s.Flights)
	if err != nil {
		return err
	}
	return nil
}
