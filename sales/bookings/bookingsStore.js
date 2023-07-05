// bookingsStore.js
const fs = require('fs');

class BookingsStore {
  constructor(filePath) {
    this.filePath = filePath;
    this.bookings = {};

    if (fs.existsSync(this.filePath)) {
      try {
        const data = fs.readFileSync(this.filePath, 'utf8');
        this.bookings = JSON.parse(data);
      } catch (err) {
        console.error(`Error reading file from disk: ${err}`);
      }
    }
  }

  getUserBookings(username) {
    return this.bookings[username] || [];
  }

  addBooking(username, booking) {
    if (!this.bookings[username]) this.bookings[username] = [];
    this.bookings[username].push(booking);
    this._writeBookingsToFile();
  }

  _writeBookingsToFile() {
    fs.writeFile(this.filePath, JSON.stringify(this.bookings), (err) => {
      if (err) console.error(err);
    });
  }
}

module.exports = BookingsStore;
