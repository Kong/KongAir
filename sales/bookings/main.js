
const appFactory = require('./app');
const path = require('path');
const BookingsStore = require('./bookingsStore');

const bookingsStore = new BookingsStore(path.join(__dirname, 'bookings.json'));

const app = appFactory(bookingsStore);

// Use the third command-line argument as the port number
//  or default to 3000
const port = process.argv[2] || 3000;

app.listen(port, () => {
  console.log(`Booking service is running on port ${port}`);
});
