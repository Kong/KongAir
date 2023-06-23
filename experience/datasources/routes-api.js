const { RESTDataSource } = require('@apollo/datasource-rest');

class RoutesAPI extends RESTDataSource {
  baseURL = 'http://localhost:8081/';

  getRoutes() {
    return this.get('routes');
  }
  getRoute(id) {
    return this.get(`routes/${id}`);
  }
}

module.exports = RoutesAPI;

