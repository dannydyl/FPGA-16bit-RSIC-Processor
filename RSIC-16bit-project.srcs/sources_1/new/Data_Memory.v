`include "parameter.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/16/2024 05:23:48 PM
// Design Name: 
// Module Name: Data_Memory
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


module Data_Memory(
    input clk,
    input [15:0] mem_access_addr,   // address for both write and read
    
    input [15:0] mem_write_data,    // write data
    input   mem_write_en,           // write enable
    input   mem_read_en,            // read enable      
    output [15:0] mem_read_data     // read data
    );
    
    reg [`col - 1 : 0] memory [`row_d - 1 : 0];
    integer f;
    wire [2:0] ram_addr = mem_access_addr[2:0];
    
    initial
    begin
        $readmemb("filepath", memory);
        
        f = $fopen(`filename);
        $fmonitor(f, "time = %d\n", $time,
        "\tmemory[0] = %d\n", memory[0],
        "\tmemory[1] = %d\n", memory[1],
        "\tmemory[2] = %d\n", memory[2],
        "\tmemory[3] = %d\n", memory[3],
        "\tmemory[4] = %d\n", memory[4],
        "\tmemory[5] = %d\n", memory[5],
        "\tmemory[6] = %d\n", memory[6],
        "\tmemory[7] = %d\n", memory[7]
        );
        `simulation_time;
        $fclose(f);
    end
        
    always @(posedge clk) begin
        if (mem_write_en)
            memory[ram_addr] <= mem_write_data;
    end
    
    assign mem_read_data = (mem_read_en==1'b1) ? memory[ram_addr] : 16'd0;    // if mem_read_en is 1 then assign memory[ram_addr] is not then give others=>0
        
endmodule
