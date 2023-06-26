const { RESTDataSource } = require('@apollo/datasource-rest');

class BookingsAPI extends RESTDataSource {
  baseURL = process.env.BOOKINGS_SVC_BASE_URL;

  constructor(req, options) {
    super(options);
    this.auth = req.headers.authorization;
  }

  getBookings() {
    return this.get('bookings', {
      headers: { authorization: this.auth }
    });
  }
}

module.exports = BookingsAPI;

