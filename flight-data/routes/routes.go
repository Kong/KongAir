package main

import (
	"fmt"
	"os"

	"github.com/Kong/KongAir/flight-data/routes/api"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

func main() {
	// set default port number to 8080
	port := "8080"

	// check if a port number was provided on the command line
	if len(os.Args) > 1 {
		port = os.Args[1]
	}

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
	e.Logger.Fatal(e.Start(fmt.Sprintf(":%s", port)))
}
