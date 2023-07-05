include ../../base.mk

check-dependencies:
	@$(call check-dependency,go)

test: check-dependencies
	go test -v ./...

build: check-dependencies
	go build .

run: check-dependencies build
	./flights ${KONG_AIR_FLIGHTS_PORT}

