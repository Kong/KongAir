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

app.use((req, res, next) => {
  // Extract username from X-Consumer-Username header
  const usernameHeader = req.headers['x-consumer-username'];

  if (usernameHeader) {
    // If a valid username is found, set it in the req object and continue
    if (typeof usernameHeader === 'string') {
      req.user = usernameHeader;
      next();
    } else {
      // If there is no valid username, reject the request
      res.status(401).end();
    }
  } else {
    // If there is no username, reject the request
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
