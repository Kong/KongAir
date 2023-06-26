const { RESTDataSource } = require('@apollo/datasource-rest');

class FlightsAPI extends RESTDataSource {
  baseURL = process.env.FLIGHTS_SVC_BASE_URL;

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

