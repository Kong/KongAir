include ../../base.mk

check-dependencies:
	@$(call check-dependency,node)
	@$(call check-dependency,npm)

test: check-dependencies
	npm run test

build: check-dependencies
	npm install

run: check-dependencies
	npm run start

