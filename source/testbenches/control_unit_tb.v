`timescale 1ns / 1ps

module control_unit_tb;

    reg [6:0] op;
    reg [2:0] funct3;
    reg funct7_5;

    wire reg_writeD, alu_srcD, mem_writeD, branchD, jumpD;
    wire [1:0] result_srcD, imm_srcD;
    wire [2:0] alu_controlD;

    control_unit DUT (
        .op(op),
        .funct3(funct3),
        .funct7_5(funct7_5),
        .reg_writeD(reg_writeD),
        .alu_srcD(alu_srcD),
        .mem_writeD(mem_writeD),
        .branchD(branchD),
        .jumpD(jumpD),
        .result_srcD(result_srcD),
        .imm_srcD(imm_srcD),
        .alu_controlD(alu_controlD)
    );

    initial begin
        // Test tipo R (ADD)
        op = 7'b0110011; funct3 = 3'b000; funct7_5 = 0;
        #10;
        // Test tipo R (SUB)
        op = 7'b0110011; funct3 = 3'b000; funct7_5 = 1;
        #10;
        // Test tipo I (LW)
        op = 7'b0000011; funct3 = 3'b010; funct7_5 = 0;
        #10;
        // Test tipo S (SW)
        op = 7'b0100011; funct3 = 3'b010; funct7_5 = 0;
        #10;
        // Test tipo B (BEQ, branch no tomado)
        op = 7'b1100011; funct3 = 3'b000; funct7_5 = 0;
        #10;
        // Test tipo B (BEQ, branch tomado)
        op = 7'b1100011; funct3 = 3'b000; funct7_5 = 0;
        #10;
        // Test tipo J (JAL)
        op = 7'b1101111; funct3 = 3'b000; funct7_5 = 0;
        #10;
    end

endmodule