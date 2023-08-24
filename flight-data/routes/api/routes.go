//go:generate go run github.com/deepmap/oapi-codegen/cmd/oapi-codegen --config=models.cfg.yaml ../openapi.yaml
//go:generate go run github.com/deepmap/oapi-codegen/cmd/oapi-codegen --config=server.cfg.yaml ../openapi.yaml

package api

import (
	"github.com/Kong/KongAir/flight-data/routes/api/models"
	"github.com/labstack/echo/v4"
  "net/http"
)

type RouteService struct {
	Routes []models.Route
}

func NewRouteService() *RouteService {
	rv := RouteService{}
	rv.Routes = []models.Route{
    {Id: "LHR-JFK", Origin: "LHR", Destination: "JFK", AvgDuration: 470},
    {Id: "LHR-SFO", Origin: "LHR", Destination: "SFO", AvgDuration: 660},
    {Id: "LHR-DXB", Origin: "LHR", Destination: "DXB", AvgDuration: 420},
    {Id: "LHR-HKG", Origin: "LHR", Destination: "HKG", AvgDuration: 745},
    {Id: "LHR-BOM", Origin: "LHR", Destination: "BOM", AvgDuration: 540},
    {Id: "LHR-HND", Origin: "LHR", Destination: "HND", AvgDuration: 830},
    {Id: "LHR-CPT", Origin: "LHR", Destination: "CPT", AvgDuration: 700},
    {Id: "LHR-SYD", Origin: "LHR", Destination: "SYD", AvgDuration: 1320},
    {Id: "LHR-SIN", Origin: "LHR", Destination: "SIN", AvgDuration: 800},
    {Id: "LHR-LAX", Origin: "LHR", Destination: "LAX", AvgDuration: 675},
	}
	return &rv
}

func (s *RouteService) GetHealth(ctx echo.Context) error {
  return ctx.JSON(http.StatusOK, map[string]string{"status": "OK"})
}

func (s *RouteService) GetRoutes(ctx echo.Context, params models.GetRoutesParams) error {
	err := ctx.JSON(200, s.Routes)
	if err != nil {
		return err
	}
	return nil
}
func (s *RouteService) GetRoute(ctx echo.Context, id string) error {
  for _, route := range s.Routes {
    if route.Id == id {
      err := ctx.JSON(200, route)
      if err != nil {
        return err
      }
      return nil
    }
  }
  return ctx.JSON(404, nil)
}
