module hazard_unit(
	// entradas para data forwarding
	input [4:0] Rs1E, Rs2E, RdE,		// registros en execute stage
	input [4:0] Rs1D, Rs2D,				// registros en decode stage  
	input [4:0] RdM, RdW,				// registros destino en memory y writeback
	input RegWriteM, RegWriteW,			// señales de escritura en memory y writeback
	
	// entradas para load-word stall detection
	input [1:0] ResultSrcE,				// para detectar si es instrucción lw
	
	// entrada para control hazards
	input PCSrcE,						// indica si hay branch tomado
	
	// salidas para data forwarding
	output reg [1:0] ForwardAE, ForwardBE,	// seleccionan de donde viene el dato
	
	// salidas para stalling
	output StallF, StallD,				// detienen fetch y decode
	
	// salidas para flushing  
	output FlushD, FlushE				// limpian decode y execute
);

	// señal interna para detectar load-word stall
	wire lwStall;
	
	// ========== DATA FORWARDING LOGIC ==========
	
	// forwarding para srcA (Rs1E)
	always @(*) begin
		// caso 1: forward desde memory stage (tiene prioridad)
		if ((Rs1E == RdM) && RegWriteM && (Rs1E != 5'b00000))
			ForwardAE = 2'b10;	// forward desde ALUResultM
		// caso 2: forward desde writeback stage
		else if ((Rs1E == RdW) && RegWriteW && (Rs1E != 5'b00000))
			ForwardAE = 2'b01;	// forward desde ResultW
		// caso 3: usar valor normal del register file
		else
			ForwardAE = 2'b00;	// usar RD1E
	end
	
	// forwarding para srcB (Rs2E)
	always @(*) begin
		// caso 1: forward desde memory stage (tiene prioridad)
		if ((Rs2E == RdM) && RegWriteM && (Rs2E != 5'b00000))
			ForwardBE = 2'b10;	// forward desde ALUResultM
		// caso 2: forward desde writeback stage
		else if ((Rs2E == RdW) && RegWriteW && (Rs2E != 5'b00000))
			ForwardBE = 2'b01;	// forward desde ResultW
		// caso 3: usar valor normal del register file
		else
			ForwardBE = 2'b00;	// usar RD2E
	end
	
	// ========== LOAD-WORD STALL DETECTION ==========
	
	// detecta si hay dependencia de datos con instrucción lw
	// ResultSrcE[0] = 1 indica que es una instrucción load
	assign lwStall = ((Rs1D == RdE) || (Rs2D == RdE)) && ResultSrcE[0] && (RdE != 5'b00000);
	
	// cuando hay lwStall, detenemos fetch y decode
	assign StallF = lwStall;
	assign StallD = lwStall;
	
	// ========== CONTROL HAZARD FLUSHING ==========
	
	// flush decode cuando hay branch tomado
	assign FlushD = PCSrcE;
	
	// flush execute cuando hay lwStall o branch tomado
	assign FlushE = lwStall || PCSrcE;

endmodule