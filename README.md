# RISC-V Single-Cycle Core (Verilog)

This project implements a **32-bit RISC-V single-cycle processor core** in Verilog.  
The design executes each instruction—**fetch, decode, execute, memory access, and write-back**—within a single clock cycle.

The primary focus of this project is to **design and trace the datapath** for **LOAD WORD (lw)** and **STORE WORD (sw)** instructions, while also supporting basic arithmetic operations.



##  Architecture Overview

The processor follows a **single-cycle datapath**, where all combinational logic completes within one clock period.  
The clock period is therefore determined by the **longest instruction path**, which in this design is the `lw` instruction.

### Core Blocks
- **Program Counter (PC)** – Holds the address of the current instruction
- **Instruction Memory** – Fetches the instruction corresponding to the PC
- **Control Unit (CU)** – Decodes the instruction opcode and generates control signals
- **Register File** – Provides source operands and receives write-back data
- **Immediate Generator (Sign Extend)** – Generates sign-extended immediates
- **ALU** – Performs arithmetic and address calculations
- **Data Memory** – Supports load and store operations

---

## 📌 Supported Instruction Types

Instruction Type  Description 
 R-type - Register-to-register arithmetic operations 
 I-type  -Immediate arithmetic and `lw` 
 S-type - `sw` (store word) 

---

## 🧠 Datapath Focus

- **Load Word (lw)**  
  Computes the effective address using the ALU, reads data from memory, and writes it back to the register file.

- **Store Word (sw)**  
  Computes the effective address and writes register data to memory, with no register write-back.

---

## 🛠 Design Highlights

- **Single-cycle execution** with CPI = 1
- Explicit tracing of `lw` and `sw` datapaths
- Debugging performed using waveform analysis
- Instruction Register (`IR_dbg`) introduced to stabilize instruction decoding during debugging

---

## 🚧 Limitations & Future Work

- No branch or jump instructions
- No pipelining or hazard handling
-** Future extensions may include:**
  - Pipelined implementation
  - Branch support
  - Hazard detection and forwarding
  - Performance comparison (single-cycle vs pipelined)

---

## 📂 Language & Tools

- **Language:** Verilog HDL
- Vivado
