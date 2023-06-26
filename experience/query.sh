#!/bin/bash

curl -s -X POST \
  -H 'Accept: application/json' -H 'Content-Type: application/json' \
  -H "Authorization: Bearer $1" \
  --data "$2" \
  http://localhost:4000/
