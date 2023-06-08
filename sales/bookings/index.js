const express = require('express');
const jwt = require('jsonwebtoken');
const YAML = require('yamljs');
const path = require('path');
const openapiValidator = require('express-openapi-validator');
const axios = require('axios'); // HTTP client

const app = express();
app.use(express.json());

// Load your OpenAPI spec file
const openApiSpecPath = path.join(__dirname, 'openapi.yaml');
const openApiDocument = YAML.load(openApiSpecPath);

let bookings = {}; // An object to store bookings per user

// Middleware to validate Requests and Responses per the OAS
app.use(
  openapiValidator.middleware({
    apiSpec: openApiDocument,
    validateRequests: true,
    validateResponses: true,
  }),
);

// Middleware to decode JWT and set req.user : NOTE does not verify any signature
app.use((req, res, next) => {
  // Extract token from Authorization header
  const authHeader = req.headers.authorization;

  if (authHeader) {
    let token = authHeader.split(' ')[1]; // Authorization: Bearer <token>

    // We are currently using unsigned tokens, so if the token does not end with a period, add one
    if (!token.endsWith('.')) {
      token += '.';
    }

    // Decode the token (without verification)
    const decoded = jwt.decode(token);

    // If a valid username is found, set it in the req object and continue
    if (decoded && typeof decoded.username === 'string') {
      req.user = decoded.username;
      next();
    } else {
      // If there is no valid username, reject the request
      res.status(401).end();
    }
  } else {
    // If there is no token, reject the request
    res.status(401).end();
  }
});

app.get('/bookings', (req, res) => {
  console.log(`bookings request for ${req.user}`);
  const userBookings = bookings[req.user];
  if (!userBookings) 
    return res.json([]); // Return empty array if no bookings for this user
  res.json(userBookings);
});

app.post('/bookings', async (req, res, next) => {
  try {
    const flightResponse = await axios.get(`http://localhost:8080/flights/${req.body.flight_number}`);

    const newBooking = {
      ticket_number: Math.random().toString(36).substr(2, 10).toUpperCase(),
      seat: req.body.seat,
      flight: flightResponse.data,
    };

    // If no bookings for this user yet, initialize array
    if (!bookings[req.user]) bookings[req.user] = [];

    bookings[req.user].push(newBooking);
    res.status(201).json({ ticket_number: newBooking.ticket_number });
  } catch (error) {
    if (error.response && error.response.status === 404) {
      res.status(404).json({ message: 'Flight not found' });
    } else {
      next(error);
    }
  }
});

// Error handler
app.use((err, req, res, next) => {
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

