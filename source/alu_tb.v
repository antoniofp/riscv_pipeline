`timescale 1ns / 1ps

module alu_tb;

    reg [31:0] src_a;
    reg [31:0] src_b;
    reg [2:0] alu_control;
    wire [31:0] result;
    wire zero;

    alu uut (
        .src_a(src_a),
        .src_b(src_b),
        .alu_control(alu_control),
        .result(result),
        .zero(zero)
    );

    initial begin
        // Test suma
        src_a = 32'd10; src_b = 32'd5; alu_control = 3'b000;
        #10;
        $display("SUMA: %d + %d = %d, zero = %b", src_a, src_b, result, zero);

        // Test resta
        src_a = 32'd10; src_b = 32'd10; alu_control = 3'b001;
        #10;
        $display("RESTA: %d - %d = %d, zero = %b", src_a, src_b, result, zero);

        // Test AND
        src_a = 32'hF0F0F0F0; src_b = 32'h0F0F0F0F; alu_control = 3'b010;
        #10;
        $display("AND: %h & %h = %h, zero = %b", src_a, src_b, result, zero);

        // Test OR
        src_a = 32'hF0F0F0F0; src_b = 32'h0F0F0F0F; alu_control = 3'b011;
        #10;
        $display("OR: %h | %h = %h, zero = %b", src_a, src_b, result, zero);

        // Test SLT
        src_a = 32'd5; src_b = 32'd10; alu_control = 3'b101;
        #10;
        $display("SLT: %d < %d = %d, zero = %b", src_a, src_b, result, zero);

        // Test default
        src_a = 32'd1; src_b = 32'd1; alu_control = 3'b100;
        #10;
        $display("DEFAULT: %d, zero = %b", result, zero);

        $finish;
    end

endmodule