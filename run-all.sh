#!/bin/bash

source PORTS.env

./kill-all.sh
echo "------------------------------------"

pushd ./flight-data/routes
echo "Running routes service"
make build
./routes "$KONG_AIR_ROUTES_PORT" > /tmp/routes.log 2>&1 &
echo $! > ./routes.pid
echo "Routes process ID:" $(cat ./routes.pid)
echo "------------------------------------"
popd

pushd ./flight-data/flights
echo "Running flights service"
make build
./flights "$KONG_AIR_FLIGHTS_PORT" > /tmp/flights.log 2>&1 &
echo $! > ./flights.pid
echo "Flights process ID:" $(cat ./flights.pid)
echo "------------------------------------"
popd

pushd ./sales/customer
echo "Running customer service"
make build
node ./main.js "$KONG_AIR_CUSTOMER_PORT" > /tmp/customer.log 2>&1 &
echo $! > ./customer.pid
echo "Customer process ID:" $(cat ./customer.pid)
echo "------------------------------------"
popd

pushd ./sales/bookings
echo "Running bookings service"
make build
node ./main.js "$KONG_AIR_BOOKINGS_PORT" > /tmp/bookings.log 2>&1 &
echo $! > ./bookings.pid
echo "Bookings process ID:" $(cat ./bookings.pid)
echo "------------------------------------"
popd

pushd ./experience
echo "Running experience service"
make build
node ./index.js "$KONG_AIR_EXPERIENCE_PORT" > /tmp/experience.log 2>&1 &
echo $! > ./experience.pid
echo "Experience process ID:" $(cat ./experience.pid)
echo "------------------------------------"
popd

