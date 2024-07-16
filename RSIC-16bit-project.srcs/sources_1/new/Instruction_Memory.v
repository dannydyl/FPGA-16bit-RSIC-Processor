`include "parameter.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/15/2024 11:36:37 PM
// Design Name: 
// Module Name: Instruction_Memory
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// instructions are in the memory and the pc[4:1] is going to point at the address where the instruction is stored
module Instruction_Memory(
        input[15:0] pc,     // program counter
        output[15:0] instruction
    );
    
    reg [`col - 1:0] memory [`row_i - 1:0];
    
    wire [3:0] rom_addr = pc[4:1]; // same as delcaring signal rom_addr and do rom_addr <= pc(4 downto 1);
    
    initial begin
        $readmemb("C:\Users\danny\OneDrive\Desktop\FPGA\RSIC-16bit-project\test\test.prog", memory, 0, 14);  // verilog's %readmemb is a system task to load binary data into an array
    end
    assign instruction = memory[rom_addr]; // equivalent to instruction <= memory(to_integer(unsigned(rom_addr))); 
endmodule
