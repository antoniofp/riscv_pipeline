`timescale 1ns / 1ps

module control_unit_tb;

    reg clk;
    reg [6:0] op;
    reg [2:0] funct3;
    reg funct7_5;
    reg zero;
    wire pc_src;
    wire mem_write, alu_src, reg_write;
    wire [1:0] result_src, imm_src;
    wire [2:0] alu_control;

    control_unit DUT (
        .clk(clk),
        .op(op),
        .funct3(funct3),
        .funct7_5(funct7_5),
        .zero(zero),
        .pc_src(pc_src),
        .mem_write(mem_write),
        .alu_src(alu_src),
        .reg_write(reg_write),
        .result_src(result_src),
        .imm_src(imm_src),
        .alu_control(alu_control)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        // Test tipo R (ADD)
        op = 7'b0110011; funct3 = 3'b000; funct7_5 = 0; zero = 0;
        #10;
        // Test tipo R (SUB)
        op = 7'b0110011; funct3 = 3'b000; funct7_5 = 1; zero = 0;
        #10;
        // Test tipo I (LW)
        op = 7'b0000011; funct3 = 3'b010; funct7_5 = 0; zero = 0;
        #10;
        // Test tipo S (SW)
        op = 7'b0100011; funct3 = 3'b010; funct7_5 = 0; zero = 0;
        #10;
        // Test tipo B (BEQ, branch no tomado)
        op = 7'b1100011; funct3 = 3'b000; funct7_5 = 0; zero = 0;
        #10;
        // Test tipo B (BEQ, branch tomado)
        op = 7'b1100011; funct3 = 3'b000; funct7_5 = 0; zero = 1;
        #10;
        // Test tipo J (JAL)
        op = 7'b1101111; funct3 = 3'b000; funct7_5 = 0; zero = 0;
        #10;
    end

endmodule