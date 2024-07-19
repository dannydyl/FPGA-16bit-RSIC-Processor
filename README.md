# 16-Bit RISC Processor in Verilog

## Overview
This repository hosts the design and implementation of a custom 5 Stages 16-bit RISC processor, developed using Verilog. This processor is specifically designed using a Harvard-type datapath structure, which separates the memory storage for instructions and data, enhancing the processing speed and efficiency. The architecture is ideal for illustrating foundational concepts in computer architecture and digital design, particularly suited for educational purposes.

- **Opcode List**: _[<img width="339" alt="Screenshot of Google Chrome at Jul 18, 2024 at 9_50_34 PM" src="https://github.com/user-attachments/assets/a6de1b93-7d89-4cb4-b2e6-d57b4fc1abd4">]_
- **Control Signals Chart**: _[<img width="774" alt="Screenshot of Google Chrome at Jul 18, 2024 at 6_42_09 PM" src="https://github.com/user-attachments/assets/2fab0bf8-d43f-4567-91d8-6a6163ee0086">]_
- **ALU Controls Chart**: _[<img width="716" alt="Screenshot of Google Chrome at Jul 18, 2024 at 6_42_45 PM" src="https://github.com/user-attachments/assets/330e586c-1d54-49cb-a63b-ce3d8aeadb10">]_

## Features
### Instruction Set Architecture (ISA)
The processor supports a streamlined ISA optimized for educational use, featuring:
- **Arithmetic Instructions**: Perform addition, subtraction, and other basic arithmetic operations. Each instruction is crafted to demonstrate fundamental ALU operations.
- **Logical Instructions**: Includes AND, OR, XOR, and NOT operations, showcasing the ability to execute bitwise manipulations directly within the processor.
- **Control Flow Instructions**: Implements jumps and conditional branches, facilitating the understanding of program flow control within a CPU architecture.

## Project Structure
The project is organized into several key modules, each corresponding to a component of the processor:

- **`ALU.v`**
  - The Arithmetic Logic Unit (ALU) performs all the arithmetic and logical operations required by the processor.
The `ALU` module performs arithmetic and logical operations, essential for the processor's computation capabilities. It accepts two 16-bit inputs, `a` and `b`, which represent the operands for the operations. The operation to be performed is selected by a 3-bit control signal (`alu_control`).

The module supports the following operations:
- **Addition (3'b000)**: Computes the sum of `a` and `b`.
- **Subtraction (3'b001)**: Computes the difference between `a` and `b`.
- **Bitwise NOT (3'b010)**: Performs bitwise negation on `a`.
- **Left Shift (3'b011)**: Shifts `a` left by the number of positions specified in `b`.
- **Right Shift (3'b100)**: Shifts `a` right by the number of positions specified in `b`.
- **Bitwise AND (3'b101)**: Performs a bitwise AND between `a` and `b`.
- **Bitwise OR (3'b110)**: Performs a bitwise OR between `a` and `b`.
- **Set on Less Than (3'b111)**: Sets `result` to 1 if `a` is less than `b`, otherwise sets it to 0.

The `result` is a 16-bit output that holds the outcome of the selected operation. Additionally, the module outputs a `zero` flag, which is set to 1 if the result is zero, providing a useful condition flag for branching and comparison operations.

- **`ALU_Control.v`**
  - Controls the ALU by decoding instructions to generate the necessary control signals for operations.
The `ALU_Control` module is responsible for determining the specific operation the Arithmetic Logic Unit (ALU) should perform based on the current instruction's opcode and the ALU operation code (`ALUOp`). It takes a 2-bit `ALUOp` and a 4-bit `Opcode` as inputs, and outputs a 3-bit control signal (`ALU_Cnt`) which directly controls the ALU's behavior.

The decision logic combines the `ALUOp` and `Opcode` into a 6-bit input (`ALUControlIn`), which is then evaluated to set the `ALU_Cnt` output. The module handles various cases:
- **Addition and Subtraction**: If `ALUOp` indicates an arithmetic operation (binary `10` or `01`), `ALU_Cnt` is set to perform addition or subtraction, respectively.
- **Specific Operations**: For explicit opcodes (`000010` to `001001`), `ALU_Cnt` is set to corresponding functions like bitwise NOT, shifts, AND, OR, and comparison operations.

This setup allows the ALU to perform a variety of functions necessary for different instructions, adapting dynamically to the needs of the processor based on the decoded instruction.

- **`Control_Unit.v`**
  - Manages the overall operation of the processor by decoding instructions and orchestrating the flow of data and controls across the processor.
The `Control_Unit` module dictates the operational behavior of the RISC processor by decoding the opcode of each instruction and setting the appropriate control signals that govern the execution of operations within the processor. Based on the 4-bit `opcode` input, the module sets various flags such as `jump`, `beq` (branch if equal), `bne` (branch if not equal), `mem_read`, `mem_write`, `alu_src`, `reg_dst`, `mem_to_reg`, and `reg_write` to control the flow of data and instructions across the processor's datapath. This includes determining whether operations are arithmetic or logical, if memory should be accessed, or if the instruction is a branch or jump type, thereby enabling the processor to execute a wide range of instructions effectively. For specific opcode values and their corresponding control settings, refer to the opcode list provided earlier.

- **`Data_Memory.v`**
  - Simulates the data memory component of the Harvard architecture, handling data storage and retrieval operations.
The `Data_Memory` module acts as the data storage unit in the RISC processor. It utilizes a parameterized register array to hold data, allowing read and write operations based on the processor's needs. The module is clocked (`clk`) to synchronize data storage and retrieval operations. Memory addressing is managed by a subset of the address input (`mem_access_addr[2:0]`), which selects one of eight possible locations in a reduced address space for data access.

Write operations are enabled through `mem_write_en`; when active, the data (`mem_write_data`) is stored at the specified address (`mem_access_addr`). For read operations, the data at the memory address is output through `mem_read_data` only if the `mem_read` signal is active, ensuring controlled access to stored data. The module also includes initialization from a file and monitoring functionalities to assist in simulation and debugging, reading initial data from a file and logging changes to the memory states at specified simulation times.

- **`Datapath_Unit.v`**
  - Integrates the ALU, registers, and control logic to process data and execute instructions.
The `Datapath_Unit` orchestrates the core functionality of the RISC processor, integrating instruction fetching, decoding, execution, and memory interactions. It utilizes a program counter (PC) to manage instruction flow, fetching instructions from memory, decoding them via an integrated register file and ALU control unit, and executing them within the ALU. The unit handles data and instruction flow using multiple control signals to direct operations such as jumps, branches, and data memory access, ensuring instructions are executed and data is stored or retrieved based on the outcomes of ALU operations and branch conditions. This module effectively ties together all functional aspects of the processor, from instruction fetch to execution and memory management, under various control signals.

- **`General_Purpose_Registers.v`**
  - Implements the general-purpose registers that store data temporarily during instruction execution.
The `GPRs` module in the RISC processor architecture functions as the register file, storing data temporarily for processor operations. It includes a set of eight 16-bit registers, initialized to zero. The module operates on a clock signal (`clk`) and handles both read and write operations. Write operations are controlled by an enable signal (`reg_write_en`); when enabled, data (`reg_write_data`) is written to the register specified by the destination address (`reg_write_dest`). For read operations, the module outputs data from two registers simultaneously based on addresses (`reg_read_addr_1` and `reg_read_addr_2`), providing the data through `reg_read_data_1` and `reg_read_data_2`. This dual-read capability supports instructions requiring multiple operands.

- **`Instruction_Memory.v`**
  - Stores the set of instructions that the processor can execute, accessed by the control unit to fetch instructions.
The `Instruction_Memory` module manages a register array that stores the processor's instruction set, loaded from a file during the initial setup. It accepts a 16-bit program counter (`pc`) as input and uses the middle four bits (`pc[4:1]`) to calculate a memory address within a reduced address space. This memory address is used to fetch the corresponding 16-bit instruction from the memory array, which is then provided as output. The logic ensures that instructions are retrieved accurately and efficiently for processor execution.

- **`Parameters.v`**
  - Contains parameter definitions used across various modules for configuration and settings.

- **`RISC_Processor.v`**
  - The top-level module that encapsulates all the other modules, forming the complete RISC processor architecture.

### Pipelined Architecture
The processor employs a simple pipelining strategy to improve instruction throughput and efficiency:
- **Stages**: Divided into 5 classic stages such as Instruction Fetch (IF), Instruction Decode (ID), Execute (EX), Memory Access (MEM), and Write Back (WB).
- **Functionality**: Each stage is designed to operate in parallel with others, reducing clock cycles per instruction and boosting overall performance. This also serves as an excellent practical example of pipelining in modern CPUs.

## License
This project is distributed under the MIT License, which allows modification and distribution of the project with proper attribution.

## Contact
For queries, suggestions, or contributions, please feel free to open an issue in this repository.
