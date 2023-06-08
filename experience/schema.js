const gql = require('graphql-tag');

const typeDefs = gql`
  type Query {
    me: Customer!
    Bookings: [Booking!]!
  }

  type Route {
    origin: String!
    destination: String!
  }
  
  type Flight {
    number: String!
    route: Route!
    scheduled_departure: String!
    scheduled_arrival: String!
  }
  
  type Booking {
    ticket_number: String!
    flight: Flight!
    seat: String!
  }
  
  type Customer {
    id: ID!
    name: String!
    bookings: [Booking!]!
    information: CustomerInformation!
  }
  
  type CustomerInformation {
    address: String!
    phoneNumber: String!
    email: String!
    frequentFlierNumber: String
    paymentMethods: [PaymentMethod!]!
  }
  
  type PaymentMethod {
    id: ID!
    cardNumber: String!
    cardholderName: String!
    expirationDate: String!
  }
`;

module.exports = typeDefs;

