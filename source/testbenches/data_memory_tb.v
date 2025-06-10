`timescale 1ns / 1ps

module data_memory_tb;

    reg clk;
    reg we;
    reg [31:0] addr;
    reg [31:0] wd;
    wire [31:0] rd;

    data_memory DUT (
        .clk(clk),
        .we(we),
        .addr(addr),
        .wd(wd),
        .rd(rd)
    );

    // Generador de reloj
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        // Escritura en la dirección 0x04
        we = 1;
        addr = 32'h00000004;
        wd = 32'hDEADBEEF;
        #10;
        we = 0;
        #10;

        // Lectura de la dirección 0x04
        addr = 32'h00000004;
        #10;
        // Escritura en la dirección 0x08
        we = 1;
        addr = 32'h00000008;
        wd = 32'h12345678;
        #10;
        we = 0;
        #10;

        // Lectura de la dirección 0x08
        addr = 32'h00000008;
        #10;
        // Lectura de una dirección no escrita (0x0C)
        addr = 32'h0000000C;
        #10;
    end

endmodule