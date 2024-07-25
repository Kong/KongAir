
# Steps

## Initialize Konnect Resources
1. `terraform init`
1. `openssl req -new -x509 -nodes -newkey rsa:2048 -subj "/CN=kongdp/C=US" -keyout ./tls.key -out ./tls.crt`
1. `KONNECT_TOKEN=$(cat ~/.konnect/routes-dev.pat ) terraform apply -auto-approve`

## Run the application
1. `make run`

## Run the cloudflared tunnel

Requires some initial setup including an authenticated cloudflared installation and local configuration. See
https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/get-started/create-local-tunnel/

`~/.cloudflared/config.yml`
```yaml
url: http://localhost:8081
tunnel: 82ad4f45-149a-41e9-b026-90ab432c8804
credentials-file: $HOME/.cloudflared/82ad4f45-149a-41e9-b026-90ab432c8804.json
```

1. `cloudflared tunnel run routes`
