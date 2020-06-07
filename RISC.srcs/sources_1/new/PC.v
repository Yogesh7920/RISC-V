`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.02.2020 18:12:23
// Design Name: 
// Module Name: PC
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


module PC(
input clk,
input [63:0] imm,
input branch,
input [63:0] a,
//input [6:0] opcode,
input over,
output reg [63:0] pc
);


initial begin
    pc = 1'd0;
end

always @(posedge clk) begin
    if (pc == 7'd99) pc = 7'd99;

    if (over == 1) pc = 7'd99;
    else if(branch == 0) pc = pc+3'b100;
//        else begin
//            if (opcode == 7'b1100111) pc = a+imm;
//            else pc = pc+imm;
//        end

end

endmodule
