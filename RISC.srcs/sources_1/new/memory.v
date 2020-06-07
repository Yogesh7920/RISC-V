`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.02.2020 18:37:19
// Design Name: 
// Module Name: memory
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


module memory(
    input Memread,
    input Memwrite,
    input [63:0] adrs,
    input [63:0] MWD,
    output reg [63:0] value
    );
    
    integer file, scan, i;
    reg [63:0] M [0:99];
    always @(*) begin
        if(Memread == 1'b1) begin
            file = $fopen("C:/Users/raghu/RISC/memory.txt","r");
            for(i=0;i<100;i=i+1) begin
                scan = $fscanf(file, "%b\n", M[i]);
            end 
            value = M[adrs];
        end
        
        if (Memwrite == 1'b1) begin // store
            M[adrs] = MWD;
            file = $fopen("C:/Users/raghu/RISC/memory.txt","w");
            for(i=0;i<100;i=i+1) begin
                $fwrite(file, "%b\n", M[i]);
            end 
        end
    end
endmodule
