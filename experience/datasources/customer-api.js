const { RESTDataSource } = require('@apollo/datasource-rest');

class CustomerAPI extends RESTDataSource {
  baseURL = process.env.CUSTOMER_SVC_BASE_URL;

  constructor(req, options) {
    super(options);
    this.auth = req.headers.authorization;
  }

  getCustomer() {
    return this.get('customer', {
      headers: { authorization: this.auth }
    });
  }
}

module.exports = CustomerAPI;

