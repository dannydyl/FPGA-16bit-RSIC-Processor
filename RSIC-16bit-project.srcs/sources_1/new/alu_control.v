`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2024 12:48:01 AM
// Design Name: 
// Module Name: alu_control
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


module alu_control(
    input [1:0] ALUOp,
    input [3:0] Opcode,
    output reg [2:0] ALU_Cnt
    );
    
    wire [5:0] ALUControlIn;
    
    assign ALUControlIn = {ALUOp, Opcode};
    
    always @(ALUControlIn)
    casex (ALUControlIn)
        6'b10xxxx: ALU_Cnt = 3'b000;
        6'b01xxxx: ALU_Cnt = 3'b001;
        6'b000010: ALU_Cnt = 3'b000;    // perform addition
        6'b000011: ALU_Cnt = 3'b001;    // perform subtraction
        6'b000100: ALU_Cnt = 3'b010;    // perform bitwise AND
        6'b000101: ALU_Cnt = 3'b011;    // perform bitwise OR
        6'b000110: ALU_Cnt = 3'b100;    // perform shift left
        6'b000111: ALU_Cnt = 3'b101;    // perform shift right
        6'b001000: ALU_Cnt = 3'b110;    // perform bitwise XOR
        6'b001001: ALU_Cnt = 3'b111;    // set less than
        default: ALU_Cnt = 3'b000;
     endcase
endmodule
