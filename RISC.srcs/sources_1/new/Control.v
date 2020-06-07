`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.02.2020 04:47:40
// Design Name: 
// Module Name: Control
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


module Control(input [6:0] opcode,
output reg [5:0] controls,
output reg [2:0] ALUop
);
reg branch;
reg Memread;
reg MemtoReg;
reg Memwrite;
reg ALUsrc;
reg Regwrite;

initial begin
   ALUsrc = 0;
    MemtoReg = 0;
    Regwrite = 0;
    Memread = 0;
    Memwrite = 0;
    branch = 0;
    ALUop = 3'b000;     

end

always @ (opcode) begin
    if(opcode == 7'b0110011) begin // Rtype
        ALUsrc = 0;
        MemtoReg = 0;
        Regwrite = 1;
        Memread = 0;
        Memwrite = 0;
        branch = 0;
        ALUop = 3'b010;
    end
    else if(opcode == 7'b0000011) begin // Ld
        ALUsrc = 1;
        MemtoReg = 1;
        Regwrite = 1;
        Memread = 1;
        Memwrite = 0;
        branch = 0;
        ALUop = 3'b000;
    end
    else if(opcode == 7'b0100011) begin // SD
        ALUsrc = 1;
        Regwrite = 0;
        Memread = 0;
        Memwrite = 1;
        branch = 0;
        ALUop = 3'b000;
    end
    else if(opcode == 7'b1100011) begin // BEQ
        ALUsrc = 0;
        Regwrite = 0;
        Memread = 0;
        Memwrite = 0;
        branch = 1;
        ALUop = 3'b001;
    end
    else if(opcode == 7'b0010011) begin // I type
        ALUsrc = 1;
        MemtoReg = 0;
        Regwrite = 1;
        Memread = 0;
        Memwrite = 0;
        branch = 0;
        ALUop = 3'b011;
    end
    
    else if(opcode == 7'b1101111 || opcode == 7'b1100111) begin // JAL or JALR
        ALUsrc = 1;
        MemtoReg = 0;
        Regwrite = 1;
        Memread = 0;
        Memwrite = 0;
        branch = 1;
        ALUop = 3'b100;
    end
    
    controls = {branch, Memread, Memwrite, MemtoReg, Regwrite, ALUsrc};
end


endmodule
