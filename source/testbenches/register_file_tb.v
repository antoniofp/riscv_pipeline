`timescale 1ns / 1ps

module register_file_tb;

    reg clk;
    reg we3;
    reg [4:0] a1, a2, a3;
    reg [31:0] wd3;
    wire [31:0] rd1, rd2;

    register_file DUT (
        .clk(clk),
        .we3(we3),
        .a1(a1),
        .a2(a2),
        .a3(a3),
        .wd3(wd3),
        .rd1(rd1),
        .rd2(rd2)
    );

    // Generador de reloj
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        // Escribir 0xDEADBEEF en el registro 1
        we3 = 1;
        a3 = 5'd1;
        wd3 = 32'hDEADBEEF;
        #10;
        we3 = 0;
        // Leer el registro 1 en rd1 y el registro 0 en rd2
        a1 = 5'd1;
        a2 = 5'd0;
        #10;
        // Escribir 0x12345678 en el registro 2
        we3 = 1;
        a3 = 5'd2;
        wd3 = 32'h12345678;
        #10;
        we3 = 0;

        // Leer el registro 2 en rd2
        a1 = 5'd0;
        a2 = 5'd2;
        #10;
        // Intentar escribir en x0 (no se debe poder)
        we3 = 1;
        a3 = 5'd0;
        wd3 = 32'hFFFFFFFF;
        #10;
        we3 = 0;

        // Leer x0 en ambos puertos
        a1 = 5'd0;
        a2 = 5'd0;
        #10;
    end

endmodule