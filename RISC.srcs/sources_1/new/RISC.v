`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 14.01.2020 12:37:26
// Design Name:
// Module Name: RISC
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


module RISC(input clk);

    wire [31:0] ins; // if_id
    
    // ID_EX
    
    wire [5:0] controls;
    wire [3:0] ALUc;
    wire [63:0] a, b;
    wire [63:0] imm;
    wire [4:0] rd;
    wire [4:0] rs1, rs2;
 
    wire [63:0] c;
    wire [31:0] rdv;  
    wire [63:0] RM;

    wire [63:0] pc;
    
    wire over;
    wire [1:0] dg1, dg2;

    wire branch_mux, zero;
    
    
    reg [31:0] if_id;
    reg [210:0] id_ex;
    reg [138:0] ex_mem;
    reg [138:0] mem_reg;
    
    
    always @ (posedge clk) begin

        if_id <= ins;

        ex_mem <= {c, id_ex[202:197], id_ex[132:69], id_ex[4:0]}; // c, controls, b, rd

        mem_reg <= {RM, ex_mem[74:69], ex_mem[138:75], ex_mem[4:0]}; // RM ,controls, c, rd
    
    end
    always @ (negedge clk) begin
        id_ex <= {dg1, dg2, ALUc ,controls, a, b, imm, rd};
    end
    
//    assign if_id = ins;
//    assign id_ex = {ALUc ,controls, a, b, imm, rd};
//    assign ex_mem = {c, id_ex[202:197], id_ex[132:69], id_ex[4:0]}; // c, controls, b, rd
//    assign mem_reg = {RM, ex_mem[74:69], ex_mem[138:75], ex_mem[4:0]}; // RM ,controls, c, rd

    assign branch_mux = controls[5] & zero;
        
    PC P(clk, imm, branch_mux, a, over, pc);
    
    instruction IS(pc, ins, over);
    
    decoder D1(if_id, ex_mem[4:0], mem_reg[4:0], rd, rs1, rs2, imm, controls, ALUc, dg1, dg2);
    
    ALU A1(id_ex[196:133], id_ex[132:69], id_ex[68:5], ex_mem[138:75], mem_reg[68:5],id_ex[197], pc, id_ex[206:203], id_ex[210:209], id_ex[208:207], c, zero);
    //ALU A1(state, a, b, imm, ALUsrc, pc, ALUc, c, zero);

    memory M1(ex_mem[73], ex_mem[72], ex_mem[138:75], ex_mem[68:5], RM);
    
    register RS(mem_reg[68:5], mem_reg[138:75], mem_reg[71], mem_reg[70], mem_reg[4:0], rs1, rs2, rdv, a, b);
//  register(clk, state, c, RM, MemtoReg, Regwrite, rd, rs1, rs2, rdv, a, b)

    
    endmodule
