`timescale 1ns / 1ps

module imm_extend_tb;

    reg [31:7] instr;
    reg [1:0] imm_src;
    wire [31:0] imm_ext;

    imm_extend DUT (
        .instr(instr),
        .imm_src(imm_src),
        .imm_ext(imm_ext)
    );

    initial begin
        // Test I-TYPE 
        instr = 25'b1111111111111111111111111;
        imm_src = 2'b00;
        #10;
        // Test S-TYPE 
        instr = {7'b1111111, 5'b00000, 5'b00000, 5'b00100}; 
        imm_src = 2'b01;
        #10;
        // Test B-TYPE 
        instr = {1'b1, 6'b000000, 4'b0000, 1'b1, 6'b000000, 5'b1000}; 
        imm_src = 2'b10;
        #10;
        // Test J-TYPE
        instr = {1'b0, 8'b00000001, 1'b0, 10'b0000000000, 5'b00000}; 
        imm_src = 2'b11;
        #10;
    end

endmodule