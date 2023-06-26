const resolvers = {
  // parmeters are like:
  //  parent, args, contextValue, info
  Query: {
    me: (_, __, { dataSources }) => dataSources.customerAPI.getCustomer()
  },
  Me: {
    bookings: (_, __, { dataSources }) => dataSources.bookingsAPI.getBookings()
  },
  Flight: {
    route: (parent, _, { dataSources }) => {
      return dataSources.routesAPI.getRoute(parent.route_id);
    },
    details: (parent, _, { dataSources }) => {
      return dataSources.flightsAPI.getFlightDetails(parent.number);
    }
  },
};

module.exports = resolvers;

