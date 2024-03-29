// Package api provides primitives to interact with the openapi HTTP API.
//
// Code generated by github.com/deepmap/oapi-codegen version v1.13.0 DO NOT EDIT.
package api

import (
	"bytes"
	"compress/gzip"
	"encoding/base64"
	"fmt"
	"net/http"
	"net/url"
	"path"
	"strings"

	. "github.com/Kong/KongAir/flight-data/flights/api/models"
	"github.com/deepmap/oapi-codegen/pkg/runtime"
	"github.com/getkin/kin-openapi/openapi3"
	"github.com/labstack/echo/v4"
)

// ServerInterface represents all server handlers.
type ServerInterface interface {
	// Get KongAir planned flights
	// (GET /flights)
	GetFlights(ctx echo.Context, params GetFlightsParams) error
	// Get a specific flight by flight number
	// (GET /flights/{flightNumber})
	GetFlightByNumber(ctx echo.Context, flightNumber string) error
	// Fetch more details about a flight
	// (GET /flights/{flightNumber}/details)
	GetFlightDetails(ctx echo.Context, flightNumber string) error
	// Health check endpoint for Kubernetes
	// (GET /health)
	GetHealth(ctx echo.Context) error
}

// ServerInterfaceWrapper converts echo contexts to parameters.
type ServerInterfaceWrapper struct {
	Handler ServerInterface
}

// GetFlights converts echo context to params.
func (w *ServerInterfaceWrapper) GetFlights(ctx echo.Context) error {
	var err error

	// Parameter object where we will unmarshal all parameters from the context
	var params GetFlightsParams
	// ------------- Optional query parameter "date" -------------

	err = runtime.BindQueryParameter("form", true, false, "date", ctx.QueryParams(), &params.Date)
	if err != nil {
		return echo.NewHTTPError(http.StatusBadRequest, fmt.Sprintf("Invalid format for parameter date: %s", err))
	}

	// Invoke the callback with all the unmarshalled arguments
	err = w.Handler.GetFlights(ctx, params)
	return err
}

// GetFlightByNumber converts echo context to params.
func (w *ServerInterfaceWrapper) GetFlightByNumber(ctx echo.Context) error {
	var err error
	// ------------- Path parameter "flightNumber" -------------
	var flightNumber string

	err = runtime.BindStyledParameterWithLocation("simple", false, "flightNumber", runtime.ParamLocationPath, ctx.Param("flightNumber"), &flightNumber)
	if err != nil {
		return echo.NewHTTPError(http.StatusBadRequest, fmt.Sprintf("Invalid format for parameter flightNumber: %s", err))
	}

	// Invoke the callback with all the unmarshalled arguments
	err = w.Handler.GetFlightByNumber(ctx, flightNumber)
	return err
}

// GetFlightDetails converts echo context to params.
func (w *ServerInterfaceWrapper) GetFlightDetails(ctx echo.Context) error {
	var err error
	// ------------- Path parameter "flightNumber" -------------
	var flightNumber string

	err = runtime.BindStyledParameterWithLocation("simple", false, "flightNumber", runtime.ParamLocationPath, ctx.Param("flightNumber"), &flightNumber)
	if err != nil {
		return echo.NewHTTPError(http.StatusBadRequest, fmt.Sprintf("Invalid format for parameter flightNumber: %s", err))
	}

	// Invoke the callback with all the unmarshalled arguments
	err = w.Handler.GetFlightDetails(ctx, flightNumber)
	return err
}

// GetHealth converts echo context to params.
func (w *ServerInterfaceWrapper) GetHealth(ctx echo.Context) error {
	var err error

	// Invoke the callback with all the unmarshalled arguments
	err = w.Handler.GetHealth(ctx)
	return err
}

// This is a simple interface which specifies echo.Route addition functions which
// are present on both echo.Echo and echo.Group, since we want to allow using
// either of them for path registration
type EchoRouter interface {
	CONNECT(path string, h echo.HandlerFunc, m ...echo.MiddlewareFunc) *echo.Route
	DELETE(path string, h echo.HandlerFunc, m ...echo.MiddlewareFunc) *echo.Route
	GET(path string, h echo.HandlerFunc, m ...echo.MiddlewareFunc) *echo.Route
	HEAD(path string, h echo.HandlerFunc, m ...echo.MiddlewareFunc) *echo.Route
	OPTIONS(path string, h echo.HandlerFunc, m ...echo.MiddlewareFunc) *echo.Route
	PATCH(path string, h echo.HandlerFunc, m ...echo.MiddlewareFunc) *echo.Route
	POST(path string, h echo.HandlerFunc, m ...echo.MiddlewareFunc) *echo.Route
	PUT(path string, h echo.HandlerFunc, m ...echo.MiddlewareFunc) *echo.Route
	TRACE(path string, h echo.HandlerFunc, m ...echo.MiddlewareFunc) *echo.Route
}

// RegisterHandlers adds each server route to the EchoRouter.
func RegisterHandlers(router EchoRouter, si ServerInterface) {
	RegisterHandlersWithBaseURL(router, si, "")
}

// Registers handlers, and prepends BaseURL to the paths, so that the paths
// can be served under a prefix.
func RegisterHandlersWithBaseURL(router EchoRouter, si ServerInterface, baseURL string) {

	wrapper := ServerInterfaceWrapper{
		Handler: si,
	}

	router.GET(baseURL+"/flights", wrapper.GetFlights)
	router.GET(baseURL+"/flights/:flightNumber", wrapper.GetFlightByNumber)
	router.GET(baseURL+"/flights/:flightNumber/details", wrapper.GetFlightDetails)
	router.GET(baseURL+"/health", wrapper.GetHealth)

}

// Base64 encoded, gzipped, json marshaled Swagger object
var swaggerSpec = []string{

	"H4sIAAAAAAAC/9xX32/bNhD+V4jbHjZAthU3BVa9dWizFgmaIenT4sCgpZPFViJV8uhNCPy/D6Qo/4hk",
	"x2n6MOzFJqT78fHu+8jTA6SqqpVESQaSBzBpgRX3y4tSLAtyq1qrGjUJ9M+lrRao3YqaGiEBQ1rIJawj",
	"0MoSzkU2+NKFzmyJ2ZxrLVa8dFa50hUnSCDjhCMSFUJ0zDXDmmuyGk91dqjwmxUaM0juOvA7UIejD8G9",
	"3wRXiy+YkkPWFukdEhel6deKC51qntO8dRyoSu4DzI8UVch5MEJJqIkLWaGkHduFUiVy6Ywr5OVc1SSU",
	"9AAEYWUGw4YHXGve9Mq0j+owBp9QbhJGjzbcr9jabyhXDlKGJtXCu0ICl0ou3wrN2ooaZlCvRIqs1mol",
	"MjSMCmSbprA8mOVKs+Dqmi+odOm6ILdtEIhghdq0ieLx2Th2FVA1Sl4LSODVOB7HEEHNqfDVmoTwbr1E",
	"6qO9QbJaGsbL8ggwzpZihZJlvJlJ8Bk1dxE+ZpDAH0gBp0+teYWE2kBy9zjbhSgJNVs0zDGd/ZJhzm1J",
	"hpFiqdUaJbkcv/pOQQLfLOoGIpC8wiCPwOiK94QzKDhqfB2dIazvHTlMraRpWT2NY/eXKkmBiLyuS5H6",
	"rU2+GIf5AfAfXtVl6/G+XW+aeyWM91vx0ro8dzPJGHvwv4zNgkxnkLAZXL57Mz2fQbR52Um3fX314WZ0",
	"e3G9azAg6NZ2Gk/PR/Gr0TT+HL9JzqbJ9Le/hh2D5ntuZ1s377WOnkD++jDy24vr0dWHm+chP/s+5Gd9",
	"5DN5P5Ne+VtibI6LnzXmkMBPk+31MAl3wyRcDP0zZB094u2tTVM0JrclawmE7G9BRV8tLQxbVVw3rTI6",
	"UbO65FLuWEZAfGm2h9Qo48Th3gXoVDt5aBeffC/WT4uYmRpTkYs0ZAmyFU7G7YPQ1iMi/r351J2WR7X8",
	"ucD9oJ1o3eGz1ezuDmD3cCZtcbdlB7VrhJPcj1cv84LcVa9n/2HRHlfs98n12Vpd97h+CsVPoLQJnHa3",
	"gOsSGtqw1bXjPD4/odxbWPsDRIXG8OXQ6LAevFsf3RuBZ4pYrqzMBmTW5/6i6fHzuYqbZNuBaFB5F0hp",
	"wSqlkQVTxhfKOjihcgd11s1a/w+ZPYeO3c5fysqu5P9xdp7CkcPELJCXVBwk4HuZ1UpIYlRwYjpcBH6S",
	"C3NnG4AZ4mTNeIiPH9oUL+z7fkXbdDsHMCRwfTn4WfNkfcPwy4QJm2lcx1//cHxWduFfCnMbaZ8KbaVZ",
	"WmD6lWHXOj/62wVqiYRBFq57wwdCN0+8/fOj/yzwere6hAQKotokkwmvxfirkssRF3qcKjf5rv8NAAD/",
	"/ykOwQQhDwAA",
}

// GetSwagger returns the content of the embedded swagger specification file
// or error if failed to decode
func decodeSpec() ([]byte, error) {
	zipped, err := base64.StdEncoding.DecodeString(strings.Join(swaggerSpec, ""))
	if err != nil {
		return nil, fmt.Errorf("error base64 decoding spec: %s", err)
	}
	zr, err := gzip.NewReader(bytes.NewReader(zipped))
	if err != nil {
		return nil, fmt.Errorf("error decompressing spec: %s", err)
	}
	var buf bytes.Buffer
	_, err = buf.ReadFrom(zr)
	if err != nil {
		return nil, fmt.Errorf("error decompressing spec: %s", err)
	}

	return buf.Bytes(), nil
}

var rawSpec = decodeSpecCached()

// a naive cached of a decoded swagger spec
func decodeSpecCached() func() ([]byte, error) {
	data, err := decodeSpec()
	return func() ([]byte, error) {
		return data, err
	}
}

// Constructs a synthetic filesystem for resolving external references when loading openapi specifications.
func PathToRawSpec(pathToFile string) map[string]func() ([]byte, error) {
	var res = make(map[string]func() ([]byte, error))
	if len(pathToFile) > 0 {
		res[pathToFile] = rawSpec
	}

	return res
}

// GetSwagger returns the Swagger specification corresponding to the generated code
// in this file. The external references of Swagger specification are resolved.
// The logic of resolving external references is tightly connected to "import-mapping" feature.
// Externally referenced files must be embedded in the corresponding golang packages.
// Urls can be supported but this task was out of the scope.
func GetSwagger() (swagger *openapi3.T, err error) {
	var resolvePath = PathToRawSpec("")

	loader := openapi3.NewLoader()
	loader.IsExternalRefsAllowed = true
	loader.ReadFromURIFunc = func(loader *openapi3.Loader, url *url.URL) ([]byte, error) {
		var pathToFile = url.String()
		pathToFile = path.Clean(pathToFile)
		getSpec, ok := resolvePath[pathToFile]
		if !ok {
			err1 := fmt.Errorf("path not found: %s", pathToFile)
			return nil, err1
		}
		return getSpec()
	}
	var specData []byte
	specData, err = rawSpec()
	if err != nil {
		return
	}
	swagger, err = loader.LoadFromData(specData)
	if err != nil {
		return
	}
	return
}
