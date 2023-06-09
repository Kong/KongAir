const RESTDataSource = require('@apollo/datasource-rest');

class CustomerAPI extends RESTDataSource {
  constructor(options) {
    super(options);
    this.baseURL = 'http://localhost:8082/';
  }

  //pass through security headers here?
  willSendRequest(request) {
    request.headers.set('Authorization', this.context.token);
  }

  async getCustomer() {
    return this.get('customer');
  }
}
