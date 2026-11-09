# APB-Protocol-Verification-

A SystemVerilog-based design and verification project for an AMBA APB (Advanced Peripheral Bus) slave, developed using RTL and a class-based SystemVerilog testbench.

The project demonstrates practical Design Verification (DV) concepts, including directed testing, constrained-random stimulus generation, mailbox-based communication, scoreboard-based checking, SystemVerilog Assertions, and functional coverage.

## Overview

This project consists of two major parts:

### 1. RTL Development

An APB slave design was developed with:

- APB read and write operations
- FSM-based control logic
- Address decoding
- Register and memory access
- Write data handling
- Read data generation
- Wait-state support
- Error response generation
- Reset handling

The APB protocol uses three phases:

- **IDLE:** No transfer is active.
- **SETUP:** The master asserts `PSEL` and provides address and control information.
- **ACCESS:** The master asserts `PENABLE`. The transfer completes when the slave asserts `PREADY`.

### 2. Verification

The DUT is verified using a class-based SystemVerilog testbench supporting:

- Directed testing
- Constrained-random testing
- Read/write verification
- Register and memory access verification
- Wait-state verification
- Error response verification
- Reset testing
- Protocol monitoring
- Scoreboard-based data checking
- SystemVerilog Assertions
- Functional coverage

## APB Features Verified

### Write Channel

- `PSEL`
- `PENABLE`
- `PADDR`
- `PWRITE`
- `PWDATA`
- `PREADY`
- `PSLVERR`

### Read Channel

- `PSEL`
- `PENABLE`
- `PADDR`
- `PWRITE`
- `PRDATA`
- `PREADY`
- `PSLVERR`

## Verification Methodology

The verification environment follows a modular, class-based SystemVerilog testbench architecture.

### Testbench Architecture

```text
Testbench
   |
   ├── DUT
   |
   └── APB Environment
          |
          ├── APB Agent
          |      |
          |      ├── Generator
          |      ├── Driver
          |      └── Monitor
          |
          ├── Scoreboard
          |
          └── Coverage
```

### Testbench Components

- **Transaction:** Defines APB transaction properties, including address, write data, read/write control, and response information.
- **Generator:** Generates directed and constrained-random APB transactions.
- **Driver:** Drives APB signals to the DUT according to the APB protocol.
- **Monitor:** Observes APB transactions and collects DUT response information.
- **Agent:** Groups the generator, driver, and monitor into a reusable verification component.
- **Scoreboard:** Maintains expected transaction results and compares them against DUT responses.
- **Coverage:** Collects functional coverage for the exercised APB scenarios.
- **Environment:** Integrates the APB agent, scoreboard, and coverage components.
- **Test:** Controls test execution and initiates the verification environment.
- **Testbench Top:** Instantiates the DUT, interface, and testbench environment.

### Communication

Mailboxes are used for communication between the generator, driver, monitor, and scoreboard.

## Stimulus Generation

Directed and constrained-random transactions are generated to exercise different combinations of:

- Read and write operations
- APB addresses
- Write data
- Read and write control signals
- Wait-state conditions
- Valid and invalid address accesses
- Response conditions

## Scoreboard

The scoreboard performs self-checking verification by comparing expected results with the DUT responses.

It checks:

- Write operation correctness
- Read data integrity
- Address-based access
- Register and memory data
- Read and write response behavior
- Error response conditions

## Functional Coverage

Functional coverage is collected to evaluate the exercised APB scenarios.

Coverage includes:

- Read and write operations
- Address accesses
- Wait-state conditions
- `PREADY` behavior
- `PSLVERR` response conditions
- Normal and error transactions

## Assertions

SystemVerilog Assertions are used to verify APB protocol behavior, including:

- SETUP and ACCESS phase sequencing
- Valid control-signal behavior
- Address and control-signal stability during wait states
- Transfer completion using `PREADY`
- Response behavior
- Reset behavior

## Verification Scenarios

| Scenario | Description |
|---|---|
| Basic Write | Verify normal APB write operation |
| Basic Read | Verify normal APB read operation |
| Write → Read | Verify written data can be read back correctly |
| Register Access | Verify register read and write operations |
| Memory Access | Verify memory read and write operations |
| Wait States | Verify transfers with wait-state insertion |
| Zero Wait State | Verify transfer completion without additional wait cycles |
| Invalid Address | Verify error response for invalid address access |
| Reset | Verify correct DUT behavior during reset |
| Reset Recovery | Verify normal transactions after reset |
| Protocol Checks | Verify APB SETUP and ACCESS handshaking |

## Project Structure

```text
apb-slave-design-verification/
│
├── design/
│   └── design.sv
│
├── testbench/
│   ├── apb_interface.sv
│   │
│   ├── apb_transaction.sv
│   ├── apb_generator.sv
│   ├── apb_driver.sv
│   ├── apb_monitor.sv
│   │
│   ├── apb_agent.sv
│   ├── apb_scoreboard.sv
│   ├── apb_coverage.sv
│   │
│   ├── apb_env.sv
│   ├── apb_test.sv
│   └── testbench.sv
│
├── output/
│   ├── apb_output.png
|   ├── apb_coverage_report.png
│   └── apb_waveform.png
│
└── README.md
```

## Tools & Technologies

| Category | Technology |
|---|---|
| RTL Design | SystemVerilog |
| Verification | SystemVerilog |
| Testbench Methodology | Class-based SystemVerilog |
| Communication | Mailboxes |
| Stimulus Generation | Constrained-Random Verification |
| Protocol Checking | SystemVerilog Assertions |
| Coverage | Functional Coverage |
| Simulation | SystemVerilog-compatible Simulator |

## Simulation

The testbench can be executed using a SystemVerilog-compatible simulator.

General simulation steps:

1. Add the DUT and testbench source files.
2. Compile the SystemVerilog files.
3. Run the APB test.
4. Observe transaction-level messages.
5. Check scoreboard results and assertion reports.
6. Review functional coverage and waveforms.

## Key Verification Objectives

The primary objectives of this project are to ensure:

- Correct APB protocol implementation
- Correct read and write operations
- Proper SETUP and ACCESS phase sequencing
- Correct wait-state handling
- Correct register and memory access
- Proper error response generation
- Data integrity across transactions
- Correct reset and recovery behavior
- APB protocol compliance

## Skills Demonstrated

This project demonstrates practical experience with:

**Design Verification**

- AMBA APB Protocol
- SystemVerilog
- Class-Based Testbench Architecture
- Constrained-Random Verification
- Mailbox Communication
- Functional Coverage
- SystemVerilog Assertions
- Agent and Environment Development
- Scoreboard Development
- Reference Data Checking
- Protocol Verification

## Author

**CHANDU B V**

Electronics & Telecommunication Engineering  
VLSI Design Verification

📧 chandubadakegudlu@gmail.com
