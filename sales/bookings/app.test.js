// app.test.js
const request = require('supertest');
const axios = require('axios');
const BookingsStore = require('./bookingsStore');

let app;
let mockStore;

jest.mock('axios');
jest.mock('./bookingsStore');

beforeEach(() => {
  // Mock the BookingsStore methods
  BookingsStore.prototype.getUserBookings = jest.fn();
  BookingsStore.prototype.addBooking = jest.fn();

  // Create an instance of BookingsStore
  mockStore = new BookingsStore();

  // Clear axios mocks
  axios.get.mockClear();

  app = require('./app')(mockStore);
});

test('GET /bookings returns bookings for user', async () => {
  const mockBookings = [
    {
      ticket_number:"RIN74XEJWG",
      seat:"18A",
      flight:{
        number:"KA0288",
        route_id:"LHR-BOM",
        scheduled_arrival:"2024-02-13T09:30:00Z",
        scheduled_departure:"2024-02-13T18:40:00Z"
      }
    }
  ];

  mockStore.getUserBookings.mockReturnValue(mockBookings);

  const jwt='eyJ0eXAiOiJKV1QiLCJhbGciOiJub25lIn0.eyJ1c2VybmFtZSI6ImRmcmVlc2UifQ'
  const res = await request(app)
    .get('/bookings').set('Authorization', `Bearer ${jwt}`);

  expect(res.statusCode).toEqual(200);
  expect(res.body).toEqual(mockBookings);
  expect(mockStore.getUserBookings).toHaveBeenCalledTimes(1);
});


