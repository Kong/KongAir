const { RESTDataSource } = require('@apollo/datasource-rest');

class RoutesAPI extends RESTDataSource {
  baseURL = process.env.ROUTES_SVC_BASE_URL;

  getRoutes() {
    return this.get('routes');
  }
  getRoute(id) {
    return this.get(`routes/${id}`);
  }
}

module.exports = RoutesAPI;

