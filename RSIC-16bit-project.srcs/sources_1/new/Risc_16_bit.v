`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/18/2024 03:52:12 PM
// Design Name: 
// Module Name: Risc_16_bit
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


module Risc_16_bit(
    input clk
    );
    
    wire jump, bne, beq, mem_read, mem_write, alu_src, reg_dst, mem_to_reg, reg_write;
    wire [1:0] alu_op;
    wire [3:0] opcode;
    
    // Datapath
    Datapath_Unit DU
    (
        .clk(clk),
        .jump(jump),
        .beq(beq),
        .bne(bne),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .alu_src(alu_src),
        .reg_dst(reg_dst),
        .mem_to_reg(mem_to_reg),
        .reg_write(reg_write),
        .alu_op(alu_op),
        .opcode(opcode)
    );
   
    // control unit
    Control_Unit control
    (
        .opcode(opcode),
        .jump(jump),
        .beq(beq),
        .bne(bne),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .alu_src(alu_src),
        .reg_dst(reg_dst),
        .mem_to_reg(mem_to_reg),
        .reg_write(reg_write),
        .alu_op(alu_op)
    );
    
    
endmodule
