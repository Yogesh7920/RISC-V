`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.02.2020 05:40:42
// Design Name: 
// Module Name: Imm_Gen
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


module Imm_Gen(

input [6:0] f7,
input [4:0] rs2, rs1,
input [2:0] f3,
input [4:0] rd,
input [6:0] opcode,
output reg [63:0] imm
    );
    
    always @ (*) begin
    
        if(opcode == 7'b0010011 || opcode == 7'b0000011) begin  //I type
        
            if (f7 == 7'b0100000 && f3 == 3'b101) imm = rs2; // shamt
            
            else imm = $signed({f7, rs2});
        end
        else if(opcode == 7'b0100011) begin// S type
            imm = $signed({f7, rd});
        end
        else if(opcode == 7'b1100011) begin // B Type
            imm = $signed({f7[6], rd[0], f7[5:0], rd[4:1], 1'b0});
        end
        else if(opcode == 7'b1101111) begin // JAL
            imm = $signed({f7[6], rs1, f3, rs2[0], f7[5:0], rs2[4:1], 1'b0});
        end
        else if(opcode == 7'b1100111) begin // JALR
            imm = $signed({f7, rs2});
        end
    
    end
    
endmodule
