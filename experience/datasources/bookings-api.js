const { RESTDataSource } = require('@apollo/datasource-rest');

class BookingsAPI extends RESTDataSource {
  baseURL = 'http://localhost:8082/';

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

