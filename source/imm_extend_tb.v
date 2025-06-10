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
        // Test I-TYPE (ejemplo: addi x1, x2, -1)
        instr = 25'b1111111111111111111111111; // instr[31]=1, instr[31:20]=12'hFFF (-1)
        imm_src = 2'b00;
        #10;
        $display("I-TYPE: imm_ext = %h (esperado: FFFFFFFF)", imm_ext);

        // Test S-TYPE (ejemplo: sw x1, -4(x2))
        instr = {7'b1111111, 5'b00000, 5'b00000, 5'b00100}; // instr[31]=1, instr[31:25]=7'b1111111, instr[11:7]=5'b00100
        imm_src = 2'b01;
        #10;
        $display("S-TYPE: imm_ext = %h", imm_ext);

        // Test B-TYPE (ejemplo: beq x1, x2, -8)
        instr = {1'b1, 6'b000000, 4'b0000, 1'b1, 6'b000000, 5'b1000}; // instr[31]=1, instr[7]=1, instr[30:25]=6'b000000, instr[11:8]=4'b1000
        imm_src = 2'b10;
        #10;
        $display("B-TYPE: imm_ext = %h", imm_ext);

        // Test J-TYPE (ejemplo: jal x0, 0x100)
        instr = {1'b0, 8'b00000001, 1'b0, 10'b0000000000, 5'b00000}; // instr[31]=0, instr[19:12]=8'b00000001, instr[20]=0, instr[30:21]=10'b0000000000
        imm_src = 2'b11;
        #10;
        $display("J-TYPE: imm_ext = %h", imm_ext);

    end

endmodule