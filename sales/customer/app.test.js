const express = require('express');
const { expect } = require('chai');
const supertest = require('supertest');

const app = require('./app');

describe('Customer API', () => {
  let server;
  let request;
  let port;

  before(async () => {
    const getPort = await import('get-port');
    port = await getPort.default();
    server = app.listen(port);
    request = supertest(app);
  });

  after((done) => {
    server.close(done);
  });

  it('should return customer data when authenticated', (done) => {
    request
      .get('/customer')
      .set('Authorization', 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJub25lIn0.eyJ1c2VybmFtZSI6Impkb2UifQ')
      .expect(200)
      .end((err, res) => {
        expect(err).to.be.null;
        expect(res.body).to.have.property('username');
        done();
      });
  });

  it('should return 401 unauthorized when not authenticated', (done) => {
    request
      .get('/customer')
      .expect(401)
      .end((err, res) => {
        expect(err).to.be.null;
        done();
      });
  });

});
