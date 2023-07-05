const express = require('express');
const jwt = require('jsonwebtoken');
const YAML = require('yamljs');
const path = require('path');
const openapiValidator = require('express-openapi-validator');
const fs = require('fs');

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

// Load the customer data from the JSON file
let customerData = [];
fs.readFile(path.join(__dirname, 'customers.json'), 'utf8', (err, data) => {
  if (err) throw err;
  customerData = JSON.parse(data);
});

app.get('/customer', (req, res) => {
  const customer = customerData.find(c => c.username === req.user);
  if (customer) {
    res.json(customer);
  } else {
    res.status(404).end();
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

module.exports = app;
