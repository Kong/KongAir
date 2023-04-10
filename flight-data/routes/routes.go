package main

import (
	"github.com/Kong/KongAir/flight-data/routes/api"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

func main() {
	//var port = flag.Int("port", 8080, "Port for test HTTP server")
	//flag.Parse()

	//swagger, err = api.GetSwagger()
	//if err != nil {
	//	fmt.Fprintf(os.Stderr, "Error loading swagger spec\n: %s", err)
	//	os.Exit(1)
	//}

	routeService := api.NewRouteService()

	// Echo instance
	e := echo.New()

	// Middleware
	e.Use(middleware.Logger())
	e.Use(middleware.Recover())

	api.RegisterHandlers(e, routeService)

	// Start server
	e.Logger.Fatal(e.Start(":1323"))
}
