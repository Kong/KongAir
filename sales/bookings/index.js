const express = require('express');
const YAML = require('yamljs');
const path = require('path');
const openapiValidator = require('express-openapi-validator');
const fs = require('fs');
const axios = require('axios'); // HTTP client

const app = express();

app.use(express.json());

// Load your OpenAPI spec file
const openApiSpecPath = path.join(__dirname, 'openapi.yaml');
const openApiDocument = YAML.load(openApiSpecPath);

app.use(
  openapiValidator.middleware({
    apiSpec: openApiDocument,
    validateRequests: true, // (default)
    validateResponses: true, // false by default
  }),
);

let bookings = []; // We will use this as a simple in-memory database

app.get('/bookings', (req, res) => {
  res.json(bookings);
});

app.post('/bookings', async (req, res, next) => {
  try {
    const flightResponse = await axios.get(`http://localhost:8080/flights/${req.body.flight_number}`);

    const newBooking = {
      ticket_number: Math.random().toString(36).substr(2, 10).toUpperCase(), // Random ticket number
      seat: req.body.seat,
      flight: flightResponse.data, // Include the returned flight data
    };

    bookings.push(newBooking);
    res.status(201).json({ ticket_number: newBooking.ticket_number });
  } catch (error) {
    if (error.response && error.response.status === 404) {
      res.status(404).json({ message: 'Flight not found' });
    } else {
      next(error); // Other errors are forwarded to the error handler
    }
  }
});

// Error handler
app.use((err, _, res) => {
  // format error
  res.status(err.status || 500).json({
    message: err.message,
    errors: err.errors,
  });
});

// Use the third command-line argument as the port number, or default to 3000
const port = process.argv[2] || 3000;

app.listen(port, () => {
  console.log(`Booking service is running on port ${port}`);
});

