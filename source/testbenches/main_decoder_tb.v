`timescale 1ns / 1ps

module main_decoder_tb;

    reg [6:0] op;
    wire branch, jump, mem_write, alu_src, reg_write;
    wire [1:0] result_src, imm_src, alu_op;

    main_decoder DUT (
        .op(op),
        .branch(branch),
        .jump(jump),
        .mem_write(mem_write),
        .alu_src(alu_src),
        .reg_write(reg_write),
        .result_src(result_src),
        .imm_src(imm_src),
        .alu_op(alu_op)
    );

    initial begin
        // LW
        op = 7'b0000011;
        #10;
        // SW
        op = 7'b0100011;
        #10;
        // R-type
        op = 7'b0110011;
        #10;
        // BEQ
        op = 7'b1100011;
        #10;
        // I-type
        op = 7'b0010011;
        #10;
        // JAL
        op = 7'b1101111;
        #10;
        // Default
        op = 7'b1111111;
        #10;
    end

endmodule