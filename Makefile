# Makefile for FPGA projects using apio via uv

# Project directory (can be overridden from command line)
# Usage: make build PROJ=example
PROJ ?= .

# Shared PCF file
PCF_FILE = pinout.pcf

# Apio project flags
PROJ_FLAGS = $(if $(filter-out .,$(PROJ)),-p $(PROJ))

all: build

# Copy shared PCF to project directory
setup-pcf:
	@if [ "$(PROJ)" != "." ] && [ -f "$(PCF_FILE)" ]; then \
		cp "$(PCF_FILE)" "$(PROJ)/$(PCF_FILE)"; \
		echo "Copied: $(PCF_FILE) -> $(PROJ)/$(PCF_FILE)"; \
	fi

# Build/synthesize with apio
build: setup-pcf
	uv run apio build $(PROJ_FLAGS)

# Upload to FPGA
upload: setup-pcf
	uv run apio upload $(PROJ_FLAGS)

# Verify the design
verify: setup-pcf
	uv run apio verify $(PROJ_FLAGS)

# Simulation
sim: setup-pcf
	uv run apio sim $(PROJ_FLAGS)

# Clean build files
clean:
	uv run apio clean $(PROJ_FLAGS)

# Initialize a new project
init:
	@if [ "$(PROJ)" = "." ]; then \
		echo "Please specify a project name: make init PROJ=myproject"; \
	else \
		mkdir -p $(PROJ); \
		uv run apio init -b Alchitry-Cu -p $(PROJ); \
		$(MAKE) setup-pcf PROJ=$(PROJ); \
	fi

.PHONY: all build upload verify sim clean setup-pcf init
