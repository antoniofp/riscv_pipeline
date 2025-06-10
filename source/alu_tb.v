`timescale 1ns / 1ps

module alu_tb;

    reg [31:0] src_a;
    reg [31:0] src_b;
    reg [2:0] alu_control;
    wire [31:0] result;
    wire zero;

    alu DUT(
        .src_a(src_a),
        .src_b(src_b),
        .alu_control(alu_control),
        .result(result),
        .zero(zero)
    );

    initial begin
        // Test case 1: Suma
        src_a = 32'h00000001;
        src_b = 32'h00000002;
        alu_control = 3'b000; // suma
        #10;

        // Test case 2: Resta
        src_a = 32'h00000005;
        src_b = 32'h00000003;
        alu_control = 3'b001; // resta
        #10;

        // Test case 3: AND lógico
        src_a = 32'hF0F0F0F0;
        src_b = 32'h0F0F0F0F;
        alu_control = 3'b010; // and lógico
        #10;

        // Test case 4: OR lógico
        src_a = 32'hF0F0F0F0;
        src_b = 32'h0F0F0F0F;
        alu_control = 3'b011; // or lógico
        #10;

        // Test case 5: Set less than
        src_a = 32'h00000001;
        src_b = 32'h00000002;
        alu_control = 3'b101; // set less than
        #10;

    end

endmodule