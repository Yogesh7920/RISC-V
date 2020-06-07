`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.02.2020 17:45:47
// Design Name: 
// Module Name: register
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


module register(
input [63:0] c, RM,
input MemtoReg,
input Regwrite,
input [4:0] rd, rs1, rs2,
output reg [63:0] rdv, a, b
);
    reg [0:63] x [0:31];
    integer i, file, scan;
    reg [63:0] value;
   
    always @(*)
    begin        
        
        if (MemtoReg) value = RM;
        else value = c;
          
        x[rd] = value; // load    
        rdv = x[rd];
        x[0] = 0;        
        file = $fopen("C:/Users/raghu/RISC/register.txt","w");
        for(i = 0;i<32;i=i+1) begin
            $fwrite(file, "%b\n", x[i]);            
        end
        $fclose(file);
    end
    
    always @ (*) begin
    
    file = $fopen("C:/Users/raghu/RISC/register.txt","r");
    for(i=0;i<32;i=i+1) begin
        scan = $fscanf(file, "%b\n", x[i]);
    end
    a = x[rs1];
    b = x[rs2];
    
    $fclose(file);
  end
   
endmodule
