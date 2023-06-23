const { RESTDataSource } = require('@apollo/datasource-rest');

class FlightsAPI extends RESTDataSource {
  baseURL = 'http://localhost:8080/';

  getFlights() {
    return this.get('flights');
  }
  getFlight(id) {
    return this.get(`flights/${id}`);
  }
  getFlightDetails(id) {
    return this.get(`flights/${id}/details`);
  }
}

module.exports = FlightsAPI;

