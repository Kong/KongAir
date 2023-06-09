#!/bin/bash

curl -X POST \
  -H 'Accept: application/json' -H 'Content-Type: application/json' \
  -H "Authorization: Bearer ${JWT}" \
  --data "$1" \
  http://localhost:4000/
