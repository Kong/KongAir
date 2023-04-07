package main

import (
	"testing"

	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

func TestRoutes(t *testing.T) {
	// Echo instance
	e := echo.New()

	// Middleware
	e.Use(middleware.Logger())
	e.Use(middleware.Recover())

	// Routes
	//var ourRoutes Route
	//e.GET("/", hello)

	// Start server
	e.Logger.Fatal(e.Start(":1323"))
}
