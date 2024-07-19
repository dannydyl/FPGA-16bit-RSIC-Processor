# 16-Bit RISC Processor in Verilog

## Overview
This repository hosts the design and implementation of a custom 5 Stages 16-bit RISC processor, developed using Verilog. This processor is specifically designed using a Harvard-type datapath structure, which separates the memory storage for instructions and data, enhancing the processing speed and efficiency. The architecture is ideal for illustrating foundational concepts in computer architecture and digital design, particularly suited for educational purposes.

- **Opcode List**: <img width="339" alt="Screenshot of Google Chrome at Jul 18, 2024 at 9_50_34 PM" src="https://github.com/user-attachments/assets/a6de1b93-7d89-4cb4-b2e6-d57b4fc1abd4">
- **Control Signals Chart**: <img width="774" alt="Screenshot of Google Chrome at Jul 18, 2024 at 6_42_09 PM" src="https://github.com/user-attachments/assets/2fab0bf8-d43f-4567-91d8-6a6163ee0086">
- **ALU Controls Chart**: <img width="716" alt="Screenshot of Google Chrome at Jul 18, 2024 at 6_42_45 PM" src="https://github.com/user-attachments/assets/330e586c-1d54-49cb-a63b-ce3d8aeadb10">

## Features
### Instruction Set Architecture (ISA)
The processor supports a streamlined ISA optimized for educational use, featuring:
- **Arithmetic Instructions**: Perform addition, subtraction, and other basic arithmetic operations. Each instruction is crafted to demonstrate fundamental ALU operations.
- **Logical Instructions**: Includes AND, OR, XOR, and NOT operations, showcasing the ability to execute bitwise manipulations directly within the processor.
- **Control Flow Instructions**: Implements jumps and conditional branches, facilitating the understanding of program flow control within a CPU architecture.

## Project Structure
The project is organized into 8 key modules, each corresponding to a component of the processor:

- **`ALU.v`**
  - The `ALU` performs arithmetic and logical operations, accepting two 16-bit inputs (`a` and `b`) and using a control signal (`alu_control`) to select the operation. The result is output along with a zero flag indicating if the result is zero.

- **`ALU_Control.v`**
  - The `ALU_Control` module decodes instruction opcodes and ALU operation codes (`ALUOp`) to set the operation type of the ALU. It outputs a control signal that dictates the specific arithmetic or logical function to be performed.

- **`Control_Unit.v`**
  - The `Control_Unit` decodes the opcode for each instruction, setting control signals that dictate processor behavior such as data movement, arithmetic operations, and branching. It manages flags for operations like jump, branch, memory access, and execution.

- **`Data_Memory.v`**
  - The `Data_Memory` module serves as the processor's data storage, handling read and write operations based on control signals. It synchronizes data access with the processor's operational cycle, ensuring data is available when needed.

- **`Datapath_Unit.v`**
  - The `Datapath_Unit` integrates major components such as the ALU, registers, and control logic, managing the flow of data and instructions within the processor. It coordinates between fetching, decoding, executing, and storing instructions.

- **`General_Purpose_Registers.v`**
  - This module functions as the register file, storing data temporarily for quick access during operations. It supports read and write operations to multiple registers based on the processor's instruction requirements.

- **`Instruction_Memory.v`**
  - The `Instruction_Memory` stores and retrieves instructions based on the program counter, utilizing a memory array that optimizes instruction access for efficient execution.
    
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
