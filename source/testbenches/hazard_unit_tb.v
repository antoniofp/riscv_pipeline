`timescale 1ns / 1ps

module hazard_unit_tb;

    // Entradas
    reg [4:0] Rs1E, Rs2E, RdE;
    reg [4:0] Rs1D, Rs2D;
    reg [4:0] RdM, RdW;
    reg RegWriteM, RegWriteW;
    reg [1:0] ResultSrcE;
    reg PCSrcE;

    // Salidas
    wire [1:0] ForwardAE, ForwardBE;
    wire StallF, StallD;
    wire FlushD, FlushE;

    // Instancia del DUT
    hazard_unit dut (
        .Rs1E(Rs1E), .Rs2E(Rs2E), .RdE(RdE),
        .Rs1D(Rs1D), .Rs2D(Rs2D),
        .RdM(RdM), .RdW(RdW),
        .RegWriteM(RegWriteM), .RegWriteW(RegWriteW),
        .ResultSrcE(ResultSrcE),
        .PCSrcE(PCSrcE),
        .ForwardAE(ForwardAE), .ForwardBE(ForwardBE),
        .StallF(StallF), .StallD(StallD),
        .FlushD(FlushD), .FlushE(FlushE)
    );

    initial begin
        // Caso 1: Sin forwarding ni stall
        Rs1E = 5'd1; Rs2E = 5'd2; RdE = 5'd0;
        Rs1D = 5'd3; Rs2D = 5'd4;
        RdM = 5'd0; RdW = 5'd0;
        RegWriteM = 0; RegWriteW = 0;
        ResultSrcE = 2'b00;
        PCSrcE = 0;
        #10;

        // Caso 2: Forwarding desde Memory (Rs1E == RdM)
        Rs1E = 5'd5; RdM = 5'd5; RegWriteM = 1;
        #10;

        // Caso 3: Forwarding desde Writeback (Rs2E == RdW)
        Rs2E = 5'd6; RdW = 5'd6; RegWriteW = 1;
        #10;

        // Caso 4: Stall por LW (Rs1D == RdE y ResultSrcE[0] == 1)
        Rs1D = 5'd7; RdE = 5'd7; ResultSrcE = 2'b01;
        #10;

        // Caso 5: Flush por branch tomado
        PCSrcE = 1;
        #10;

        // Caso 6: FlushE por lwStall y branch
        Rs2D = 5'd8; RdE = 5'd8; ResultSrcE = 2'b01; PCSrcE = 1;
        #10;

        $finish;
    end

endmodule