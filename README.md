# Less Horrible Building of EDKII
This repo provides some Make targets for building the EDKII Emulator platform
using the Tiano-core Ubuntu container.

## Quick Start
```
git clone
make sync
make build-tools
make build
make run
```

## Details
* `make sync` gets git submodules recursively. This should only need to be done
    once.
* `make build-tools` makes the EDKII build tools in a Docker container.
    This should only have to be done once.
* `make build` builds the Emulator platform for the X64 architecture in a
    Docker container. Run this whenever you wish to re-compile your changes.
* `make run` runs a previously built Emulator platform _not_ in the Docker
    container.

## Other Makefile Targets
* `make shell` drops you into a Docker container.
