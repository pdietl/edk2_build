DOCKER_REPOSITORY := ghcr.io/tianocore/containers
DOCKER_IMAGE_NAME := ubuntu-22-dev
DOCKER_IMAGE_SHA := sha256:754f99abf93dccc260bd17783ff5f1bf3852fd6e10ff418a182fc678f1bf6cbe
DOCKER_IMAGE_URL := $(DOCKER_REPOSITORY)/$(DOCKER_IMAGE_NAME)@$(DOCKER_IMAGE_SHA)

MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MKFILE_DIR := $(dir $(MKFILE_PATH))

DOCKER_ARGS := \
	-ti \
	-v "$(MKFILE_DIR)":"$(HOME)" \
	-e EDK2_DOCKER_USER_HOME="$(HOME)" \
	-w "$(HOME)/edk2" \
	$(DOCKER_IMAGE_URL)


.PHONY: all build
all build:
	docker run $(DOCKER_ARGS) /bin/bash -c '. edksetup.sh BaseTools && build -t GCC5 -p EmulatorPkg/EmulatorPkg.dsc -a X64 -b DEBUG'

# Enter Docker shell
.PHONY: shell
shell:
	docker run $(DOCKER_ARGS) /bin/bash

.PHONY: sync
sync:
	git submodule update --init --recursive

.PHONY: build-tools
build-tools:
	docker run $(DOCKER_ARGS) make -j$(shell nproc) -C edk2/BaseTools

.PHONY: run
run:
	cd ./edk2/Build/EmulatorX64/DEBUG_GCC5/X64 && ./Host
