const gql = require('graphql-tag');

const typeDefs = gql`
  type Query {
    # An 'experience' API that allows a client app to pick and choose what data
    # it wants to retrieve for the current user. The user's identity will be
    # provided in Authorization headers
    me: Me!
  }

  type Me {
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
    route_id: String!
    route: Route!
    scheduled_departure: String!
    scheduled_arrival: String!
    details: FlightDetails!
  }

  type Route {
    id: String!
    origin: String!
    destination: String!
    avg_duration: Int!
  }

  type FlightDetails {
    aircraft_type: String!
    flight_number: String!
    in_flight_entertainment: Boolean!
    meal_options: [String!]!
  }

  type MyInfo {
    address: String!
    phone_number: String!
    email: String!
    frequent_flier_number: String
    payment_methods: [PaymentMethod!]!
  }

  type PaymentMethod {
    id: ID!
    redacted_card_number: String!
    card_holder_name: String!
    expiration_date: String!
  }
`;

module.exports = typeDefs;
