include ../../base.mk

routes_mkfile_dir := $(CURRDIR)

check-dependencies:
	@$(call check-dependency,go)
	@$(call check-dependency,jq)
	@$(call check-dependency,deck)
	@$(call check-dependency,cloudflared)
	@$(call check-dependency,docker)

test: check-dependencies
	@go test -v ./...

build: check-dependencies
	@go build .

build-docker:
	@docker build -t kong-air-routes-svc:dev .

run: check-dependencies build
	@./routes ${KONG_AIR_ROUTES_PORT}

docker: build-docker
	@docker run -d --name kong-air-routes-svc -p ${KONG_AIR_ROUTES_PORT}:${KONG_AIR_ROUTES_PORT} kong-air-routes-svc:dev

kill-docker:
	-@docker stop kong-air-routes-svc
	-@docker rm kong-air-routes-svc
	@if [ $$? -ne 0 ]; then $(call echo_fail,Failed to kill the docker containers); exit 1; else $(call echo_pass,Killed the docker container); fi

###############################################################################
# DEV Environment setup
TLS_KEY := $(CURDIR)/dev/kong/konnect/tf/tls.key
TLS_CRT := $(CURDIR)/dev/kong/konnect/tf/tls.crt
TF_OUT_LOG := $(CURDIR)/dev/kong/konnect/tf/.terraform.out.log
TF_ERR_LOG := $(CURDIR)/dev/kong/konnect/tf/.terraform.err.log

$(TLS_KEY) $(TLS_CRT):
	@openssl req -new -x509 -nodes -newkey rsa:2048 -subj "/CN=kongdp/C=US" -keyout $(TLS_KEY) -out $(TLS_CRT) > /dev/null 2>&1

konnect-dev-cert: $(TLS_KEY) $(TLS_CRT)
	@if [ $$? -ne 0 ]; then $(call echo_fail,Failed to create Konnect certificate); exit 1; else $(call echo_pass,Created Konnect certificate); fi

kill-konnect-dev-cert:
	@rm -f $(TLS_KEY) $(TLS_CRT)
	@if [ $$? -ne 0 ]; then $(call echo_fail,Failed to remove Konnect certificate); exit 1; else $(call echo_pass,Removed Konnect certificate); fi

konnect-dev-tf-init:
	@cd $(CURDIR)/dev/kong/konnect/tf && terraform init > $(TF_OUT_LOG) 2> $(TF_ERR_LOG)
	@if [ $$? -ne 0 ]; then $(call echo_fail,terraform failed to initialize); exit 1; else $(call echo_pass,terraform initialized); fi

konnect-dev-tf-apply:
	@cd $(CURDIR)/dev/kong/konnect/tf && KONNECT_TOKEN=`cat ~/.konnect/routes-dev.pat` terraform apply -auto-approve > $(TF_OUT_LOG) 2> $(TF_ERR_LOG) && \
		echo "KONG_GATEWAY_URL=$$(terraform output -json | jq -r .gateway_endpoint.value)" > $(CURDIR)/dev/kong/konnect/.kong-air-routes-svc.env && \
		echo "KONNECT_CONTROL_PLANE_NAME=$$(terraform output -json | jq -r .control_plane_name.value)" >> $(CURDIR)/dev/kong/konnect/.kong-air-routes-svc.env
	@if [ $$? -ne 0 ]; then $(call echo_fail,Failed to apply terraform manifests); exit 1; else $(call echo_pass,Konnect resources available); fi

konnect-dev-tf-destroy:
	@cd $(CURDIR)/dev/kong/konnect/tf && KONNECT_TOKEN=`cat ~/.konnect/routes-dev.pat` terraform destroy -auto-approve > $(TF_OUT_LOG) 2> $(TF_ERR_LOG)
	@if [ $$? -ne 0 ]; then $(call echo_fail,Failed to destroy terraform resources); exit 1; else $(call echo_pass,Destroyed Konnect resources); fi

konnect-dev-env: konnect-dev-cert konnect-dev-tf-init konnect-dev-tf-apply

kill-konnect-dev-env: konnect-dev-tf-destroy kill-konnect-dev-cert

cloudflare-tunnel:
	@cloudflared tunnel run routes > ~/Library/Logs/com.cloudflare.cloudflared.out.log 2> ~/Library/Logs/com.cloudflare.cloudflared.err.log & \
	echo $$! > $(CURDIR)/.cloudflared.pid
	@if [ $$? -ne 0 ]; then $(call echo_fail,Failed to run cloudflare tunnel); exit 1; \
	else $(call echo_pass,cloudflare tunnel running at PID $$(cat $(CURDIR)/.cloudflared.pid)); fi

kill-cloudflare-tunnel:
	@if [ -f $(CURDIR)/.cloudflared.pid ]; then \
		kill $$(cat $(CURDIR)/.cloudflared.pid) || true; \
		rm $(CURDIR)/.cloudflared.pid; \
		$(call echo_pass,Killed the cloudflare tunnel); \
	fi

routes-svc-kong-config:
	@deck file openapi2kong -s openapi.yaml | \
		deck file patch --output-file $(CURDIR)/dev/kong/.kong-routes-svc.yaml $(CURDIR)/dev/kong/patches.yaml
	@if [ $$? -ne 0 ]; then $(call echo_fail,Failed to create Kong configuration); exit 1; \
		else $(call echo_pass,Wrote Kong configuration to dev/kong/.kong-routes-svc.yaml); fi

kill-route-svc-kong-config:
	@rm -f $(CURDIR)/dev/kong/.kong-routes-svc.yaml

sync-routes-svc-kong-config:
	@source $(CURDIR)/dev/kong/konnect/.kong-air-routes-svc.env && \
	deck gateway sync \
		--konnect-token-file ~/.konnect/routes-dev.pat \
		--konnect-control-plane-name $$KONNECT_CONTROL_PLANE_NAME \
		$(CURDIR)/dev/kong/.kong-routes-svc.yaml
	@if [ $$? -ne 0 ]; then $(call echo_fail,Failed to sync Kong configuration); exit 1; \
		else $(call echo_pass,Synced Kong configuration); fi

.PHONY: dev-env
dev-env: check-dependencies
	@$(call echo_bull,Creating a kong-air routes team dev environment)
	@$(MAKE) docker
	@$(MAKE) konnect-dev-env
	@$(MAKE) cloudflare-tunnel
	@$(MAKE) routes-svc-kong-config
	@$(MAKE) sync-routes-svc-kong-config
	@echo
	@echo "Run the following command to load the dev environment variables"
	@echo "source dev/kong/konnect/.kong-air-routes-svc.env"
	@echo
	@echo "The Kong Gateway proxy endpoint is available in the variable KONG_GATEWAY_URL"
	@echo "Route a request to Kong Gateway with:"
	@echo "  curl `source $(CURDIR)/dev/kong/konnect/.kong-air-routes-svc.env && echo $$KONG_GATEWAY_URL`"
	@echo
	@echo "You can also route directly to your service from the Cloudflare public endpoint:"
	@echo "  curl https://routes.kong-air.dev/routes"

.PHONY: kill-dev-env
kill-dev-env: check-dependencies
	@$(MAKE) kill-route-svc-kong-config
	@$(MAKE) kill-cloudflare-tunnel
	@$(MAKE) kill-konnect-dev-env
	@$(MAKE) kill-docker
	@echo "Killed the dev environment"
###############################################################################
