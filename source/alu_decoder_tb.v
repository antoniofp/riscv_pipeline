`timescale 1ns / 1ps

module alu_decoder_tb;

    reg [1:0] alu_op;
    reg [2:0] funct3;
    reg op_5;
    reg funct7_5;
    wire [2:0] alu_control;

    alu_decoder DUT (
        .alu_op(alu_op),
        .funct3(funct3),
        .op_5(op_5),
        .funct7_5(funct7_5),
        .alu_control(alu_control)
    );

    initial begin
        // Test suma para lw/sw
        alu_op = 2'b00; funct3 = 3'b000; op_5 = 0; funct7_5 = 0;
        #10;
        // Test resta para beq
        alu_op = 2'b01; funct3 = 3'b000; op_5 = 0; funct7_5 = 0;
        #10;
        // Test suma (add)
        alu_op = 2'b10; funct3 = 3'b000; op_5 = 0; funct7_5 = 0;
        #10;
        // Test resta (sub)
        alu_op = 2'b10; funct3 = 3'b000; op_5 = 1; funct7_5 = 1;
        #10;
        // Test slt
        alu_op = 2'b10; funct3 = 3'b010; op_5 = 0; funct7_5 = 0;
        #10;
        // Test or
        alu_op = 2'b10; funct3 = 3'b110; op_5 = 0; funct7_5 = 0;
        #10;
        // Test and
        alu_op = 2'b10; funct3 = 3'b111; op_5 = 0; funct7_5 = 0;
        #10;
        // Test default
        alu_op = 2'b10; funct3 = 3'b001; op_5 = 0; funct7_5 = 0;
        #10;
    end

endmodule