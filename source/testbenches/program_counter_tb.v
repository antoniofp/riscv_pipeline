`timescale 1ns / 1ps

module program_counter_tb;

    reg clk;
    reg reset;
    reg [31:0] pc_next;
    wire [31:0] pc;

    program_counter DUT (
        .clk(clk),
        .reset(reset),
        .pc_next(pc_next),
        .pc(pc)
    );

    // Generador de reloj
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        // Inicialización y reset
        reset = 1;
        pc_next = 32'h00000010;
        #10;
        // Quitar reset y avanzar PC
        reset = 0;
        pc_next = 32'h00000020;
        #10;

        // Cambiar PC de nuevo
        pc_next = 32'h00000030;
        #10;
        // Activar reset otra vez
        reset = 1;
        #10;
    end

endmodule