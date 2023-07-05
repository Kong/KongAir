SHELL=/bin/bash -o pipefail

mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
mkfile_dir := $(dir $(mkfile_path))

BASE_MAKEFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
BASE_MAKEFILE_DIR  := $(dir $(BASE_MAKEFILE_PATH))
PORTS_FILE := $(BASE_MAKEFILE_DIR)PORTS.env

echo_fail = printf "\e[31m✘ \033\e[0m$(1)\n"
echo_pass = printf "\e[32m✔ \033\e[0m$(1)\n"

check-dependency = $(if $(shell command -v $(1)),$(call echo_pass,found $(1)),$(call echo_fail,$(1) not installed);exit 1)

include $(PORTS_FILE)
export
