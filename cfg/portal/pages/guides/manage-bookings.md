# Booking Automation

Automate end-to-end booking flows using the Bookings API plus supporting flight
data services.

::snippet
---
name: "kongair-page-toc"
---
::

## Flow Overview

1. Traveler searches for flights. Use the [Flights API](../../apis/flights/openapi.yaml)
   to provide live schedules.
2. Present available seats and fare classes sourced from your inventory system.
3. Create the booking via `POST /bookings`.
4. Confirm the reservation with a branded email that includes the ticket number
   and key flight details.

## Handling Failures

- Retry transient errors using the strategy in [Errors and Retries](../../apis/bookings/docs/error-handling.md).
- When seat selection fails, show the traveler remaining options before
  restarting the booking call.
- Log the `ticket_number` and `flight_number` for each booking to reconcile with
  the KongAir settlement feed.

## Related Guides

- [Real-time Booking Updates](./real-time-updates) — Subscribe to webhook events
  when bookings are created, changed, or canceled.
- [Flight Operations](../flight-operations) — Combine booking data with schedule
  feeds to predict load factors.
