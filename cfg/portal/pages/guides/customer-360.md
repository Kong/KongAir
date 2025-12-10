# Customer 360

Blend booking history and customer profiles to deliver personalized travel
experiences across channels.

::snippet
---
name: "kongair-page-toc"
---
::

## Data Sources

- `GET /customer` for preferences, loyalty tier, and stored payment options.
- `GET /bookings` for active itineraries and seat assignments.
- Internal CRM for ancillary purchases or previous disruptions.

## Integration Blueprint

1. Authenticate the traveler and exchange an OAuth token with the scopes
   `customer.read` and `bookings.read`.
2. Retrieve the customer profile and active bookings in parallel.
3. Merge the data into a 360° view that powers your UI and downstream
   personalization services.
4. Store a hashed customer identifier to reference the composite record later.

## Personalization Ideas

- Suggest seat upgrades when the loyalty tier qualifies for complimentary
  benefits.
- Recommend airport lounge access when a traveler has a long layover.
- Prefill payment forms using the masked card data from the Customer Information
  API.

## Governance

- Ensure you have documented consent before storing loyalty or payment data.
- Audit access logs monthly. Include the `x-request-id` for every API call.
- Honor data deletion requests by removing cached copies within 30 days.
