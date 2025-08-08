# -Pipeline-Processor-Design
A 4-stage pipelined processor in Verilog with support for ADD, SUB, and LOAD instructions. Includes testbench and simulation results.

# Pipeline Processor Design

This project implements a **4-stage pipelined processor** using Verilog HDL. The design supports basic instructions like:

- `LOAD`
- `ADD`
- `SUB`

##  Pipeline Stages

1. **Instruction Fetch (IF)**
2. **Instruction Decode (ID)**
3. **Execution (EX)**
4. **Write Back (WB)**

##  Included Files

- `pipeline_processor.v` — Main processor module
- `tb_pipeline_processor.v` — Testbench to simulate processor
- `pipeline_sim.vcd` — (optional) Waveform output for visualization

##   How to Run (Using Icarus Verilog)

```bash
iverilog -o pipeline_sim tb_pipeline_processor.v pipeline_processor.v
vvp pipeline_sim
