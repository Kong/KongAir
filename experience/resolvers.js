const resolvers = {
  Query: {
    // returns a customer
    me: (_, __, { dataSources }) => {
      return dataSources.customerAPI.getCustomer();
    },
  },
};

module.exports = resolvers;

