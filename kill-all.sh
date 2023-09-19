#!/bin/bash

source PORTS.env

if [[ -f "./flight-data/routes/routes.pid" ]];
then
  pid=$(cat ./flight-data/routes/routes.pid)
  echo "Killing routes service $pid"
  kill $pid
  rm -f ./flight-data/routes/routes.pid
else
  echo "No routes service pid found"
fi

if [[ -f "./flight-data/flights/flights.pid" ]];
then
  pid=$(cat ./flight-data/flights/flights.pid)
  echo "Killing flights service $pid"
  kill $pid
  rm -f ./flight-data/flights/flights.pid
else
  echo "No flights service pid found"
fi

if [[ -f "./sales/customer/customer.pid" ]];
then
  pid=$(cat ./sales/customer/customer.pid)
  echo "Killing customer service $pid"
  kill $pid
  rm -f ./sales/customer/customer.pid
else
  echo "No customer service pid found"
fi

if [[ -f "./sales/bookings/bookings.pid" ]];
then
  pid=$(cat ./sales/bookings/bookings.pid)
  echo "Killing bookings service $pid"
  kill $pid
  rm -f ./sales/bookings/bookings.pid
else
  echo "No bookings service pid found"
fi

if [[ -f "./experience/experience.pid" ]];
then
  pid=$(cat ./experience/experience.pid)
  echo "Killing experience service $pid"
  kill $pid
  rm -f ./experience/experience.pid
else
  echo "No experience service pid found"
fi
