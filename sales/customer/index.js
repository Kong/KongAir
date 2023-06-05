const express = require('express');
const YAML = require('yamljs');
const path = require('path');
const openapiValidator = require('express-openapi-validator');
const fs = require('fs');

const app = express();

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

// Load the customer data from the JSON file
let customerData = [];
fs.readFile(path.join(__dirname, 'customers.json'), 'utf8', (err, data) => {
  if (err) throw err;
  customerData = JSON.parse(data);
});

app.get('/customer/:custId', (req, res) => {
  const customer = customerData.find(c => c.id === req.params.custId);
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

// Use the third command-line argument as the port number, or default to 3000
const port = process.argv[2] || 3000;

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});

