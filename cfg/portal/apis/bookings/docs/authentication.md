# Bookings API: Authentication

The Bookings API enforces OAuth 2.0 with the Authorization Code grant to ensure
that customers explicitly consent to booking operations. The same flow is used
in sandbox and production.

## Authorization Server

- **Issuer**: `https://identity.kong-air.com`
- **Token endpoint**: `POST /oauth2/token`
- **Authorization endpoint**: `GET /oauth2/authorize`
- **Scopes**:
  - `bookings.read` — retrieve the traveler's active bookings
  - `bookings.write` — create new bookings on behalf of the traveler

## Sequence

1. Redirect the traveler to the authorization endpoint with the requested
   scopes.
2. Receive the authorization `code` on your registered redirect URI.
3. Exchange the code for an access token:
   ```bash
   curl -u $CLIENT_ID:$CLIENT_SECRET \
        -d "grant_type=authorization_code" \
        -d "code=$CODE" \
        -d "redirect_uri=$REDIRECT_URI" \
        https://identity.kong-air.com/oauth2/token
   ```
4. Store the access token securely (short-lived, 15 minutes) and refresh token
   if provided. Issue new tokens when required.

## Best Practices

- Always request the minimal scope. Read-only history views should not request
  `bookings.write`.
- The Bookings API does **not** accept API keys. Anonymous calls return `401`.
- Handle MFA challenges presented by the identity platform by whitelisting your
  redirect URI and respecting the `acr_values` requested by KongAir.
- Propagate the `x-request-id` header when it is returned. This accelerates
  support investigations if travelers report booking discrepancies.
