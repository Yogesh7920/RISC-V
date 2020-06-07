`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.02.2020 17:47:35
// Design Name: 
// Module Name: decoder
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


module decoder(
input [31:0] data,
input [4:0] ex_rd, mem_rd,
output reg [4:0] rd, rs1, rs2,
output [63:0] imm,
output [5:0] controls,
output [3:0] ALUc,
output reg [1:0] dg1, dg2
);

integer file, i, scan;
reg [0:63] x [0:31];
reg [6:0] f7;
reg [2:0] f3;
reg [6:0] opcode;

wire [2:0] ALUop;
    
  always @(*)
  begin

    f7 = data[31:25];
    rs2 = data[24:20];
    rs1 = data[19:15];
    f3 = data[14:12];
    rd = data[11:7];
    opcode = data[6:0];
    
    dg1 = 0;
    dg2 = 0;
    
    if (rs1 == ex_rd) dg1[1] = 1;
    if (rs2 == ex_rd) dg1[0] = 1;
    if (rs1 == mem_rd) dg2[1] = 1;
    if (rs2 == mem_rd) dg2[0] = 1;
  
  end
  
  Imm_Gen IG(f7, rs2, rs1, f3, rd, opcode, imm);
  Control C(opcode, controls, ALUop);
  ALUCtrl AC(ALUop, f7, f3, ALUc);
  
endmodule
