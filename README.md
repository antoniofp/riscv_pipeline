# RISC-V 5 Stage Pipelined Processor

A 32-bit 5 stage pipelined RISC-V processor implementation supporting a subset of the RV32I instruction set.

## Overview

This project implements a 5 stage pipelined RISC-V processor in Verilog, based on the RV32I instruction set architecture. The design follows the principles described in "Digital Design and Computer Architecture" by Sarah L. Harris and David Harris.

### Implementation Details

- 5 stage pipelined execution (multiple instructions in flight simultaneously)
- 32-bit data path
- Separate instruction and data memories
- Basic control unit
- ALU supporting all necessary operations
- Hazard units to handle data and control hazards

## Organization

- All of the verilog and simulation related files can be found on source directory and its subdirectories
- In the simulation folder the waveform generated by the tesbench of the top module can be found
- there is a testbench folder with testbenches for each submodule
- Screenshots showing simulation results for top and submodules are in the report's pdf

