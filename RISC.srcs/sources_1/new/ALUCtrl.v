`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.02.2020 05:11:38
// Design Name: 
// Module Name: ALUCtrl
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


module ALUCtrl(input [2:0] ALUop, input [6:0] f7, input [2:0] f3,
 output reg [3:0] ALUc
    );
    
    always @(*) begin
    
        if(ALUop == 3'b000) ALUc = 4'b0010; // ld|sd,  add
        else if(ALUop == 3'b010) begin // R Type
        
            if(f7 == 7'b0000000) begin // R type not sub
                if(f3 == 3'b000) ALUc = 4'b0010 ;// add
                else if(f3 == 3'b111) ALUc = 4'b0000; // and 
                else if(f3 == 3'b110) ALUc = 4'b0001; // OR 
                else if(f3 == 3'b100) ALUc = 4'b0011; // XOR 
                else if(f3 == 3'b001) ALUc = 4'b0100; // SLL
                else if(f3 == 3'b101) ALUc = 4'b0111; // SRL
            end
            else if(f7 == 7'b0100000) begin
                if(f3 == 3'b000) ALUc = 4'b0110; // SUB
                else if(f3 == 3'b101) ALUc = 4'b0101; // SRA
            end
        end 
        else if(ALUop == 3'b011) begin // I type
            if(f3 == 3'b000) ALUc = 4'b0010 ;// addi
            else if(f3 == 3'b111) ALUc = 4'b0000; // andi
            else if(f3 == 3'b110) ALUc = 4'b0001; // ORi 
            else if(f3 == 3'b100) ALUc = 4'b0011; // XORi
            else if(f3 == 3'b001) ALUc = 4'b0100; // SLLi 
            else if(f3 == 3'b101) begin
                if (f7 == 7'b0100000 ) ALUc = 4'b0101; // SRAi
                else if (f7 == 7'b0000000) ALUc = 4'b0111; //SRLi
            end
        end
        else if(ALUop == 3'b001) begin // B Type
            if(f3 == 3'b000) ALUc = 4'b1111; // BEQ
            else if(f3 == 3'b001) ALUc = 4'b1110; // BNE
            else if (f3 == 3'b100) ALUc = 4'b1101; // BLT
            else if (f3 == 3'b101) ALUc = 4'b1100; // BGE
        end 
        else if(ALUop == 3'b100) begin
            ALUc = 4'b1011;
        end
    end
    
    
endmodule
