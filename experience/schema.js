const gql = require('graphql-tag');

const typeDefs = gql`
  type Query {
    # An 'experience' API that allows a client app to pick and choose what data
    # it wants to retrieve for the current user. The user's identity will be
    # provided in Authorization headers
    me: Customer!
  }

  type Customer {
    name: String!
    username: String!
    bookings: [Booking!]!
    information: MyInfo!
  }

  type Booking {
    ticket_number: String!
    flight: Flight!
    seat: String!
  }

  type Flight {
    number: String!
    origin: String!
    destination: String!
    scheduled_departure: String!
    scheduled_arrival: String!
    details: FlightDetails!
  }

  type FlightDetails {
    aircraft_type: String!
    flight_number: String!
    in_flight_entertainment: Boolean!
    meal_options: [String!]!
  }

  type MyInfo {
    address: String!
    phoneNumber: String!
    email: String!
    frequentFlierNumber: String
    paymentMethods: [PaymentMethod!]!
  }

  type PaymentMethod {
    id: ID!
    redactedCardNumber: String!
    cardholderName: String!
    expirationDate: String!
  }
`;

module.exports = typeDefs;

