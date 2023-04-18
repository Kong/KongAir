//go:generate go run github.com/deepmap/oapi-codegen/cmd/oapi-codegen --config=models.cfg.yaml ../openapi.yaml
//go:generate go run github.com/deepmap/oapi-codegen/cmd/oapi-codegen --config=server.cfg.yaml ../openapi.yaml

package api

import (
	"github.com/Kong/KongAir/flight-data/routes/api/models"
	"github.com/labstack/echo/v4"
)

type RouteService struct {
	Routes []models.Route
}

func NewRouteService() *RouteService {
	rv := RouteService{}
	rv.Routes = []models.Route{
		{Origin: "LHR", Destination: "JFK"},
		{Origin: "LHR", Destination: "SFO"},
	}
	return &rv
}

func (s *RouteService) GetRoutes(ctx echo.Context, params models.GetRoutesParams) error {
	err := ctx.JSON(200, s.Routes)
	if err != nil {
		return err
	}
	return nil
}
