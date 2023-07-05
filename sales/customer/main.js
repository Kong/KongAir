// Use the third command-line argument as the port number, or default to 3000
const port = process.argv[2] || 3000;

const app = require('./app');

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
