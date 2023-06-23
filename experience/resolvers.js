const resolvers = {
  // parmeters are like:
  //  parent, args, contextValue, info
  Query: {
    me: (_, __, { dataSources }) => dataSources.customerAPI.getCustomer()
  },
  Me: {
    name: (parent) => parent.name,
    username: (parent) => parent.username,
    information: (parent) => parent.information,
    bookings: (_, __, { dataSources }) => dataSources.bookingsAPI.getBookings()
  },
};

module.exports = resolvers;

