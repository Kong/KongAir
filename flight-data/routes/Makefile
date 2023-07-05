include ../../base.mk

check-dependencies:
	@$(call check-dependency,go)

test: check-dependencies
	go test -v ./...

build: check-dependencies
	go build .

run: check-dependencies build
	./routes ${KONG_AIR_ROUTES_PORT}
