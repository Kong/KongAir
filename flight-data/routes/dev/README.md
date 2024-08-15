
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

1. cloudflared tunnel login
1. cloudflared tunnel create routes
1. cloudflared tunnel route dns 55f23fbd-9104-4b47-a14b-d068f9b980aa routes
1. Setup a configuration file: `~/.cloudflared/config.yml`

```yaml
url: http://localhost:8081
tunnel: 55f23fbd-9104-4b47-a14b-d068f9b980aa
credentials-file: $HOME/.cloudflared/55f23fbd-9104-4b47-a14b-d068f9b980aa.json
```

## Run the tunnel
1. `cloudflared tunnel run routes`
