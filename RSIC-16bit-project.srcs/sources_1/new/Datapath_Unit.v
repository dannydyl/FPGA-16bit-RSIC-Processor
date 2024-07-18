`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2024 06:01:15 PM
// Design Name: 
// Module Name: Datapath_Unit
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


module Datapath_Unit(
    input clk,
    input jump, mem_read, mem_write, alu_src, reg_dst, mem_to_reg, reg_write, bne, beq,
    input [1:0] alu_op,
    output [3:0] opcode
    );
    
    reg [15:0] pc_current;
    wire [15:0] pc_next, pc2;
    wire [15:0] instr;
    wire [2:0] reg_write_dest;
    wire [15:0] reg_write_data;
    wire [2:0] reg_read_addr_1;
    wire [15:0] reg_read_data_1;
    wire [2:0] reg_read_addr_2;
    wire [15:0] reg_read_data_2;
    wire [15:0] ext_im, read_data2; // ext_im is extended immediate value, (I-type)
    wire [2:0] ALU_Control;
    wire [15:0] ALU_out;
    wire zero_flag;
    wire [15:0] PC_j, PC_beq, PC_2beq, PC_bne, PC_2bne; // beq = branch if equal  | bne = branch if not equal
    wire beq_control;
    wire [12:0] jump_shift;
    wire [15:0] mem_read_data;
    
    initial begin
        pc_current <= 16'd0;
    end
    
    always @(posedge clk)
    begin
        pc_current <= pc_next;
    end
   
   assign pc2 = pc_current + 16'd2;
   
   // instruction memory
   Instruction_Memory im(.pc(pc_current), .instruction(instr)); 
   
   // jump shift left 2
   assign jump_shift = {instr[11:0], 1'b0};
   
   // mux regdest
   assign reg_write_dest = (reg_dst==1'b0) ? instr[5:3] : instr[8:6];   // if reg_dst is 1 then it uses instr[5:3] (for R-type instruction), otherwise uses instr[8:6] (for I-type instructions)
   
   // register file
   assign reg_read_addr_1 = instr[11:9];
   assign reg_read_addr_2 = instr[8:6];
   
   // General Purpos Registers
   GPR reg_file // reg_file is just user define naming
   (
      .clk(clk),
      .reg_write_en(reg_write),
      .reg_write_dest(reg_write_dest),
      .reg_write_data(reg_write_data),
      .reg_read_addr_1(reg_read_addr_1),
      .reg_read_data_1(reg_read_data_1),
      .reg_read_addr_2(reg_read_addr_2),
      .reg_read_data_2(reg_read_data_2)
    ); 
    
    // immediate extend
    assign ext_im = {{10{instr[5]}}, instr[5:0]};
    
    // ALU control unit
    alu_control ALU_Control_Unit
    (
        .ALUOp(alu_op),
        .Opcode(instr[15:12]),
        .ALU_Cnt(ALU_Control)
    );
    
    // mux alu_src
    assign read_data2 = (alu_src == 1'b1) ? ext_im : reg_read_data_2;
    
    // ALU
    ALU alu_unit
    (
        .a(reg_read_data_1),
        .b(read_data2),
        .alu_control(ALU_Control),
        .result(ALU_out),
        .zero(zero_flag)
    );
    
   // PC beq add
   assign PC_beq = pc2 + {ext_im[14:0], 1'b0};
   assign PC_bne = pc2 + {ext_im[14:0], 1'b0};
   
   // beq control
   assign beq_control = beq & zero_flag;
   assign bne_control = bne & (~zero_flag);
   
   // PC beq
   assign PC_2beq = (beq_control == 1'b1) ? PC_beq : pc2;
   // PC bne
   assign PC_2bne = (bne_control == 1'b1) ? PC_bne : PC_2beq;
   
   // PC_j
   assign PC_j = {pc2[15:13], jump_shift};
   
   // PC_next
   assign pc_next = (jump == 1'b1) ? PC_j : PC_2bne;
   
   // Data Memory
   Data_Memory dm
   (
    .clk(clk),
    .mem_access_addr(ALU_out),
    .mem_write_data(reg_read_data_2),
    .mem_write_en(mem_write),
    .mem_read_en(mem_read),
    .mem_read_data(mem_read_data)
    );
    
    // write back
    assign reg_write_data = (mem_to_reg == 1'b1) ? mem_read_data : ALU_out;
    
    // output to control unit
    assign opcode = instr[15:12];
    
endmodule
