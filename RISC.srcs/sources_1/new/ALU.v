`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.02.2020 17:46:43
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [63:0] a1,a2, imm,
    input [63:0] ex_c, mem_c,
    input ALUsrc,
    input [63:0] pc,
    input [3:0] ctrl,
    input [1:0] dg1, dg2,
    output reg [63:0] c,
    output reg zero
    );
    
    reg [63:0] a,b;
    
    initial begin
        zero = 1'b0;
    end
    always @ (*) begin
        
        zero = 0;
        a = a1;
        if (dg1[1] == 1) a = ex_c;
        else if(dg2[1] == 1) a = mem_c;
        
        
        if (ALUsrc) b = imm;
        else begin
            b = a2;
            if (dg1[0] == 1) b = ex_c;
            else if(dg2[0] == 1) b = mem_c;
        end
        
        if (ctrl == 4'b0000) c = a&b;
        else if(ctrl == 4'b0001) c = a|b;
        else if(ctrl == 4'b0010) c = a+b;
        else if(ctrl == 4'b0110) c = a-b;
        
        else if(ctrl == 4'b0011) c = a^b;
        else if(ctrl == 4'b0100) c = a<<b;
        else if(ctrl == 4'b0101) c = a>>>b;
        else if(ctrl == 4'b0111) c = a>>b;
        
        else if(ctrl == 4'b1111) begin // BEQ
            if (a == b) zero = 1;
            else zero = 0;
        end
        else if(ctrl == 4'b1110) begin // BNE
            if (a==b) zero = 0;
            else zero = 1;
        end
        else if(ctrl == 4'b1101) begin // BLT
            if (a < b) zero = 1;
            else zero = 0;
        end
        else if(ctrl == 4'b1100) begin // BGE
            if (a < b) zero = 0;
            else zero = 1;
        end
        else if(ctrl == 4'b1011) begin // JAL
            c = pc+3'b100;
            zero = 1;
        end
        
    end
  
 endmodule