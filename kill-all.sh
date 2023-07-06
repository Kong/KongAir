#!/bin/bash

source PORTS.env

echo "Killing routes service"
if [[ -f "./flight-data/routes/routes.pid" ]];
then
kill -15 $(cat ./flight-data/routes/routes.pid)
rm -f ./flight-data/routes/routes.pid
fi

echo "Killing flgiths service"
if [[ -f "./flight-data/flights/flights.pid" ]];
then
kill -15 $(cat ./flight-data/flights/flights.pid)
rm -f ./flight-data/flights/flights.pid
fi

echo "Killing customer service"
if [[ -f "./sales/customer/customer.pid" ]];
then
kill -15 $(cat ./sales/customer/customer.pid)
rm -f ./sales/customer/customer.pid
fi

echo "Killing bookings service"
if [[ -f "./sales/bookings/bookings.pid" ]];
then
kill -15 $(cat ./sales/bookings/bookings.pid)
rm -f ./sales/bookings/bookings.pid
fi
