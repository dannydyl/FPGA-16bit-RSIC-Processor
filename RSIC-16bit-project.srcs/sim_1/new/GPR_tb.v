`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/16/2024 04:31:30 PM
// Design Name: 
// Module Name: GPR_tb
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


module GPR_tb;

    //testbench signals
    reg clk;
    reg reg_write_en;
    reg [2:0] reg_write_dest;
    reg [15:0] reg_write_data;
    reg [2:0] reg_read_addr_1;
    wire [15:0] reg_read_data_1;
    reg [2:0] reg_read_addr_2;
    wire [15:0] reg_read_data_2;
    
    // instantiate the UUT
    GPR uut(
        .clk(clk),
        .reg_write_en(reg_write_en),
        .reg_write_dest(reg_write_dest),
        .reg_write_data(reg_write_data),
        .reg_read_addr_1(reg_read_addr_1),
        .reg_read_data_1(reg_read_data_1),
        .reg_read_addr_2(reg_read_addr_2),
        .reg_read_data_2(reg_read_data_2)
    );

    // clock generation
    initial begin
        clk = 0;
        forever #5 clk = !clk; // generate a clock with a period of 10ns;
    end
    
    // initial setup and tests
    initial begin
        reg_write_en = 0;
        reg_write_dest = 0;
        reg_write_data = 0;
        reg_read_addr_1 = 0;
        reg_read_addr_2 = 0;
        
        #100;   // wait for global reset
        
        reg_write_en = 1;
        reg_write_dest = 3;
        reg_write_data = 16'hA5A5;
        #10;
        
        reg_write_en = 0;
        reg_read_addr_1 = 3;
        #10;
        
     end
endmodule
