`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.02.2020 17:42:08
// Design Name: 
// Module Name: instruction
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


 
module instruction(input [63:0] pc,
                   output reg[31:0] data, output reg over);
 
  integer file,scan, i;
  reg [31:0] in [0:99];  
  initial begin
     file = $fopen("C:/Users/raghu/RISC/instruction.txt","r");
     i=0;
     while(!$feof(file)) begin
        scan = $fscanf(file, "%b\n", in[i]);
        i = i+1;
     end
  end
  always @(*)
  begin
    if (i == pc/4) over = 1;
    else begin
        data = in[pc/4]; 
        over = 0;
    end
  end

endmodule