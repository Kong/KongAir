const { ApolloServer } = require('@apollo/server');
const { startStandaloneServer } = require('@apollo/server/standalone');

const typeDefs = require('./schema');
const resolvers = require('./resolvers');

const CustomerAPI = require('./datasources/customer-api');
const BookingsAPI = require('./datasources/bookings-api');
const RoutesAPI = require('./datasources/routes-api');
const FlightsAPI = require('./datasources/flights-api');

require('dotenv').config()

async function startApolloServer() {
  const server = new ApolloServer({
    typeDefs,
    resolvers,
    dataSources: () => ({
      customerAPI: new CustomerAPI(),
      bookingsAPI: new BookingsAPI(),
      routesAPI: new RoutesAPI(),
      flightsAPI: new FlightsAPI(),
    }),
  });

  const port = process.argv[2] || 4000; // Getting port from command line arguments, with a default value of 4000

  const { url } = await startStandaloneServer(server, {
    context: async ({ req }) => {
      const { cache } = server;
      return {
        dataSources: {
          customerAPI: new CustomerAPI(req, { cache }),
          bookingsAPI: new BookingsAPI(req, { cache }),
          routesAPI: new RoutesAPI({ cache }),
          flightsAPI: new FlightsAPI({ cache }),
        },
      };
    },
    listen: { port: port },
  });

  console.log(`
    🚀  Server is running
    📭  Query at ${url}
  `);
}

startApolloServer();

