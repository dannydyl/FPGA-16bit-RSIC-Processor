`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/16/2024 11:37:20 PM
// Design Name: 
// Module Name: ALU_tb
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


module ALU_tb;

    // declare testbench signals
    reg [15:0] a, b;    // inputs are reg because there are in the initial block
    reg [2:0] alu_control;
    wire [15:0] result;
    wire zero;
    
    // Instantiate the ALU module
    ALU uut (
        .a(a),
        .b(b),
        .alu_control(alu_control),
        .result(result),
        .zero(zero)
    );

    // Initialize inputs
    initial begin
        a = 0; b = 0; alu_control = 0;
    end

    // Generate input stimulus
    initial begin
        // Test Addition
        #10 a = 16'd10; b = 16'd5; alu_control = 3'b000;
        #10 a = 16'd20; b = 16'd15; alu_control = 3'b001; // Subtraction
        #10 a = 16'd25; alu_control = 3'b010;             // NOT
        #10 b = 16'd3; alu_control = 3'b011;              // Shift left
        #10 b = 16'd2; alu_control = 3'b100;              // Shift right
        #10 a = 16'hAAAA; b = 16'h5555; alu_control = 3'b101; // AND
        #10 a = 16'hFFFF; b = 16'h0000; alu_control = 3'b110; // OR
        #10 a = 16'd2; b = 16'd3; alu_control = 3'b111;   // Compare
        #20 $stop; // End simulation
    end

    // Monitor changes
    initial begin
        $monitor("Time = %t, Control = %b, A = %d, B = %d, Result = %d, Zero = %b",
                 $time, alu_control, a, b, result, zero);
    end

endmodule
