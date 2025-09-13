# Serial Protocols Verilog

FPGA development repository for serial protocol implementations using apio and uv.

## Prerequisites

- Python with `uv` package manager
- `apio` (installed via uv)

## Usage

### Build the current directory
```bash
make build
```

### Work with a specific project
```bash
make build PROJ=example
make upload PROJ=example
make verify PROJ=example
make sim PROJ=example
```

### Create a new project
```bash
make init PROJ=myproject
```

### Available commands

- `make build` - Synthesize the Verilog code
- `make upload` - Upload to Alchitry Cu FPGA board
- `make verify` - Verify the design
- `make sim` - Run simulation
- `make clean` - Clean build artifacts
- `make init PROJ=name` - Initialize new project

All commands support the `PROJ` parameter to target specific project directories. Without it, commands operate on the current directory.