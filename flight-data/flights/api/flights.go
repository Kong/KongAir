//go:generate go run github.com/deepmap/oapi-codegen/cmd/oapi-codegen --config=models.cfg.yaml ../openapi.yaml
//go:generate go run github.com/deepmap/oapi-codegen/cmd/oapi-codegen --config=server.cfg.yaml ../openapi.yaml

package api

import (
	"time"

	"github.com/Kong/KongAir/flight-data/flights/api/models"
	"github.com/labstack/echo/v4"
  "net/http"
  "os"
)

func stringPtr(str string) *string {
	return &str
}
func boolPtr(b bool) *bool {
  return &b
}

func generateSampleFlightDetails() []models.FlightDetails {
	details := []models.FlightDetails{
		{
			AircraftType:          "Boeing 777",
			FlightNumber:          "KA0284",
			InFlightEntertainment: true,
			MealOptions:           &[]string{"Chicken", "Fish", "Vegetarian"},
		},
		{
			AircraftType:          "Airbus A380",
			FlightNumber:          "KA0285",
			InFlightEntertainment: true,
			MealOptions:           &[]string{"Vegetarian", "Beef"},
		},
		{
			AircraftType:          "Boeing 777",
			FlightNumber:          "KA0286",
			InFlightEntertainment: true,
			MealOptions:           &[]string{"Chicken", "Fish", "Vegetarian"},
		},
		{
			AircraftType:          "Airbus A380",
			FlightNumber:          "KA0287",
			InFlightEntertainment: true,
			MealOptions:           &[]string{"Vegetarian", "Beef"},
		},
		{
			AircraftType:          "Boeing 777",
			FlightNumber:          "KA0288",
			InFlightEntertainment: true,
			MealOptions:           &[]string{"Chicken", "Fish", "Vegetarian"},
		},
		{
			AircraftType:          "Airbus A380",
			FlightNumber:          "KA0289",
			InFlightEntertainment: true,
			MealOptions:           &[]string{"Vegetarian", "Beef"},
		},
		{
			AircraftType:          "Boeing 777",
			FlightNumber:          "KA0290",
			InFlightEntertainment: true,
			MealOptions:           &[]string{"Chicken", "Fish", "Vegetarian"},
		},
		{
			AircraftType:          "Airbus A380",
			FlightNumber:          "KA0291",
			InFlightEntertainment: true,
			MealOptions:           &[]string{"Vegetarian", "Beef"},
		},
		{
			AircraftType:          "Boeing 777",
			FlightNumber:          "KA0292",
			InFlightEntertainment: true,
			MealOptions:           &[]string{"Chicken", "Fish", "Vegetarian"},
		},
		{
			AircraftType:          "Airbus A380",
			FlightNumber:          "KA0293",
			InFlightEntertainment: true,
			MealOptions:           &[]string{"Vegetarian", "Beef"},
		},
	}
	return details
}

func NewFlight(number, routeId string, scheduledArrival, scheduledDeparture time.Time) models.Flight {
	return models.Flight{
		Number: number,
		RouteId: routeId,
		ScheduledArrival:   scheduledArrival,
		ScheduledDeparture: scheduledDeparture,
	}
}
func generateSampleFlights() []models.Flight {
	flights := []models.Flight{
		NewFlight("KA0284",
			"LHR-JFK",
			time.Date(2024, 4, 5, 8, 25, 0, 0, time.UTC),
			time.Date(2024, 4, 5, 16, 5, 0, 0, time.UTC)),
		NewFlight("KA0285",
			"LHR-SFO",
			time.Date(2024, 4, 3, 11, 10, 0, 0, time.UTC),
			time.Date(2024, 4, 3, 22, 15, 0, 0, time.UTC)),
		NewFlight("KA0286",
			"LHR-DXB",
			time.Date(2024, 3, 4, 12, 40, 0, 0, time.UTC),
			time.Date(2024, 3, 4, 19, 45, 0, 0, time.UTC)),
		NewFlight("KA0287",
			"LHR-HKG",
			time.Date(2024, 2, 10, 17, 40, 0, 0, time.UTC),
			time.Date(2024, 2, 11, 6, 20, 0, 0, time.UTC)),
		NewFlight("KA0288",
			"LHR-BOM",
			time.Date(2024, 2, 13, 9, 30, 0, 0, time.UTC),
			time.Date(2024, 2, 13, 18, 40, 0, 0, time.UTC)),
		NewFlight("KA0289",
			"LHR-HND",
			time.Date(2024, 4, 1, 8, 55, 0, 0, time.UTC),
			time.Date(2024, 4, 1, 22, 35, 0, 0, time.UTC)),
		NewFlight("KA0290",
			"LHR-CPT",
			time.Date(2024, 1, 1, 10, 0, 0, 0, time.UTC),
			time.Date(2024, 1, 1, 22, 35, 0, 0, time.UTC)),
		NewFlight("KA0291",
			"LHR-SYD",
			time.Date(2023, 12, 31, 11, 59, 0, 0, time.UTC),
			time.Date(2024, 1, 1, 22, 15, 0, 0, time.UTC)),
		NewFlight("KA0292",
			"LHR-SIN",
			time.Date(2024, 6, 1, 3, 0, 0, 0, time.UTC),
			time.Date(2024, 6, 1, 16, 15, 0, 0, time.UTC)),
		NewFlight("KA0293",
			"LHR-LAX",
			time.Date(2024, 4, 3, 11, 10, 0, 0, time.UTC),
			time.Date(2024, 4, 3, 22, 15, 0, 0, time.UTC)),
	}
	return flights
}

type FlightService struct {
	Flights []models.Flight
  FlightDetails []models.FlightDetails
}

func NewFlightService() *FlightService {
	rv := FlightService{}
	rv.Flights = generateSampleFlights()
  rv.FlightDetails = generateSampleFlightDetails()
	return &rv
}

func (s *FlightService) GetHealth(ctx echo.Context) error {

	hostname, err := os.Hostname()
	if err != nil {
		return err
	}
  ctx.Response().Header().Set("Hostname", hostname)

  return ctx.JSON(http.StatusOK, map[string]string{"status": "OK"})
}

func (s *FlightService) GetFlights(ctx echo.Context, params models.GetFlightsParams) error {

	hostname, err := os.Hostname()
	if err != nil {
		return err
	}
  ctx.Response().Header().Set("Hostname", hostname)

	return ctx.JSON(http.StatusOK, s.Flights)
}
func (s *FlightService) GetFlightByNumber(ctx echo.Context, flightNumber string) error {

	for _, flight := range s.Flights {
		if flight.Number == flightNumber {
	    hostname, err := os.Hostname()
	    if err != nil {
	    	return err
	    }
      ctx.Response().Header().Set("Hostname", hostname)
			return ctx.JSON(http.StatusOK, flight)
		}
	}

  // Include the hostname header in the response
	return ctx.JSON(http.StatusNotFound, map[string]string{"message": "Flight not found"})
}

func (s *FlightService) GetFlightDetails(ctx echo.Context, flightNumber string) error {

	for _, flight := range s.FlightDetails {
		if flight.FlightNumber == flightNumber {
	    hostname, err := os.Hostname()
	    if err != nil {
	    	return err
	    }
      ctx.Response().Header().Set("Hostname", hostname)
			return ctx.JSON(http.StatusOK, flight)
		}
	}

	return ctx.JSON(http.StatusNotFound, map[string]string{"message": "Flight not found"})
}
