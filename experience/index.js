const { ApolloServer } = require('@apollo/server');
const { startStandaloneServer } = require("@apollo/server/standalone");
const typeDefs = require('./schema');
const axios = require('axios')
const { CustomerAPI } = require('./customer-api');

const resolvers = {
  Query: {
    me(parent, args, contextValue, info) {
      const config = {
        headers: {
         Authorization: "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJub25lIn0.eyJ1c2VybmFtZSI6Impkb2UifQ"
        }
      }
      axios.get('http://localhost:8082/customer', config)
        .then((res) => {
          console.log(res.data);
        });

      return {
        name: 'John Doe',
        username: 'jdoe'
      }
    }
 }
};

const server = new ApolloServer({
  typeDefs,
  resolvers});

async function startApolloServer() {

  const { url } = await startStandaloneServer(server, {
    context: async ( { res } ) => {
      const { cache } = server;
      return {
        dataSources: {
          customerAPI: new CustomerAPI({ cache, res }),
        }
      }
    }
    //context: async ({ req, res }) => {
    //  //throw new GraphQLError('User not authenticated');
    //  return { req };
    //},
  });

  console.log(`
    🚀  Server is running!
    📭  Query at ${url}
  `);
}

startApolloServer();
