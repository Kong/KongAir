#!/bin/bash

source PORTS.env

./kill-all.sh

echo "Running routes service"
(cd ./flight-data/routes && make build)
./flight-data/routes/routes "$KONG_AIR_ROUTES_PORT" > /tmp/routes.log 2>&1 &
echo $! > ./flight-data/routes/routes.pid
echo "Routes process:" $(cat ./flight-data/routes/routes.pid)

echo "Running flights service"
(cd ./flight-data/flights && make build)
./flight-data/flights/flights "$KONG_AIR_FLIGHTS_PORT" > /tmp/flights.log 2>&1 &
echo $! > ./flight-data/flights/flights.pid
echo "Flights process:" $(cat ./flight-data/flights/flights.pid)

echo "Running customer service"
node ./sales/customer/main.js "$KONG_AIR_CUSTOMER_PORT" > /tmp/customer.log 2>&1 &
echo $! > ./sales/customer/customer.pid
echo "Customer process:" $(cat ./sales/customer/customer.pid)

echo "Running bookings service"
node ./sales/bookings/main.js "$KONG_AIR_BOOKINGS_PORT" > /tmp/bookings.log 2>&1 &
echo $! > ./sales/bookings/bookings.pid
echo "Bookings process:" $(cat ./sales/bookings/bookings.pid)
