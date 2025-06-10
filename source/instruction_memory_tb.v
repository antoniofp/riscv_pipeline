`timescale 1ns / 1ps

module instruction_memory_tb;

    reg [31:0] addr;
    wire [31:0] instr;

    instruction_memory DUT (
        .addr(addr),
        .instr(instr)
    );

    initial begin
        // Test lectura de la dirección 0x00
        addr = 32'h00000000;
        #10;

        // Test lectura de la dirección 0x04
        addr = 32'h00000004;
        #10;

        // Test lectura de la dirección 0x08
        addr = 32'h00000008;
        #10;

        // Test lectura fuera de rango
        addr = 32'h00100000;
        #10;

    end

endmodule