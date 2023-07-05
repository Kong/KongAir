module.exports = function (bookingsStore) {
  const express = require('express');
  const jwt = require('jsonwebtoken');
  const YAML = require('yamljs');
  const path = require('path');
  const openapiValidator = require('express-openapi-validator');
  const axios = require('axios'); // HTTP client

  require('dotenv').config()

  const app = express();
  app.use(express.json());

  // Load the OpenAPI spec file
  const openApiSpecPath = path.join(__dirname, 'openapi.yaml');
  const openApiDocument = YAML.load(openApiSpecPath);

  // Middleware to validate Requests and Responses per the OAS
  app.use(
    openapiValidator.middleware({
      apiSpec: openApiDocument,
      validateRequests: true,
      validateResponses: true,
    }),
  );

  // Middleware to decode JWT and set req.user
  //  WARN!! this code does not verify any signature and should
  //  not be used in production scenarios
  app.use((req, res, next) => {
    // Extract token from Authorization header
    const authHeader = req.headers.authorization;

    if (authHeader) {
      let token = authHeader.split(' ')[1]; // Bearer <token>

      // This example uses unsigned tokens,
      //   so if the token does not end with a period, add one
      if (!token.endsWith('.')) {
        token += '.';
      }

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

  // Routes
  // ********* GET /bookings *********
  app.get('/bookings', (req, res) => {
    const userBookings = bookingsStore.getUserBookings(req.user);
    if (!userBookings)
      return res.json([]); // Return empty array if no bookings for this user
    res.json(userBookings);
  });

  // ********* POST /bookings *********
  app.post('/bookings', async (req, res, next) => {
    try {
      const flightResponse = await axios.get(
        `${process.env.FLIGHT_SVC_ENDPOINT}${req.body.flight_number}`);

      const newBooking = {
        ticket_number:
          Math.random()
            .toString(36)
            .substring(2, 12)
            .toUpperCase(),
        seat: req.body.seat,
        flight: flightResponse.data,
      };

      bookingsStore.addBooking(req.user, newBooking);

      res.status(201).json({ ticket_number: newBooking.ticket_number });

    } catch (error) {
      if (error.response && error.response.status === 404) {
        res.sendStatus(404);
      } else {
        next(error);
      }
    }
  });

  // Error handler
  app.use((err, _, res, __) => {
    // format error
    res.status(err.status || 500).json({
      message: err.message,
      errors: err.errors,
    });
  });

  return app;
};
