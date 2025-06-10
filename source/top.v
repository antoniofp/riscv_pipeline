module top(
	input clk,
	input reset		
);

	// ========== SEÑALES DE FETCH (F) ==========
	wire [31:0] PCF, PCNextF, PCPlus4F;
	wire [31:0] InstrF;
	
	// ========== REGISTROS IF/ID ==========
	reg [31:0] InstrD, PCD, PCPlus4D;
	
	// ========== SEÑALES DE DECODE (D) ==========
	wire RegWriteD, ALUSrcD, MemWriteD, BranchD, JumpD;
	wire [1:0] ResultSrcD, ImmSrcD;
	wire [2:0] ALUControlD;
	wire [31:0] RD1D, RD2D, ImmExtD;
	
	// ========== REGISTROS ID/EX ==========
	reg RegWriteE, ALUSrcE, MemWriteE, BranchE, JumpE;
	reg [1:0] ResultSrcE;
	reg [2:0] ALUControlE;
	reg [31:0] RD1E, RD2E, PCE, ImmExtE, PCPlus4E;
	reg [4:0] Rs1E, Rs2E, RdE;	// direcciones de registros para forwarding 
	
	// ========== SEÑALES DE EXECUTE (E) ==========
	wire [31:0] SrcAE, SrcBE, ALUResultE, PCTargetE;
	wire ZeroE, PCSrcE;
	
	// ========== REGISTROS EX/MEM ==========
	reg RegWriteM, MemWriteM;
	reg [1:0] ResultSrcM;
	reg [31:0] ALUResultM, WriteDataM, PCPlus4M;
	reg [4:0] RdM;
	
	// ========== SEÑALES DE MEMORY (M) ==========
	wire [31:0] ReadDataM;
	
	// ========== REGISTROS MEM/WB ==========
	reg RegWriteW;
	reg [1:0] ResultSrcW;
	reg [31:0] ALUResultW, ReadDataW, PCPlus4W;
	reg [4:0] RdW;
	
	// ========== SEÑALES DE WRITEBACK (W) ==========
	wire [31:0] ResultW;

// ========== SEÑALES DE HAZARD UNIT ==========
	wire [1:0] ForwardAE, ForwardBE;
	wire StallF, StallD, FlushD, FlushE;
	wire [31:0] SrcAE_Forward, SrcBE_Forward;  // señales con forwarding aplicado



	// ========== FETCH STAGE ==========
	
	// program counter
	program_counter pc_reg(
		.clk(clk),
		.reset(reset),
		.pc_next(StallF ? PCF : PCNextF),   // si hay stall, mantener PC actual
		.pc(PCF)
	);
	
	// memoria de instrucciones
	instruction_memory imem(
		.addr(PCF),
		.instr(InstrF)
	);
	
	// sumador pc + 4
	assign PCPlus4F = PCF + 32'd4;
	
	// mux para siguiente pc (incluye lógica de branch/jump desde execute stage)
	assign PCNextF = PCSrcE ? PCTargetE : PCPlus4F;

	// ========== REGISTRO IF/ID ==========
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			InstrD <= 32'h00000000;
			PCD <= 32'h00000000;
			PCPlus4D <= 32'h00000000;
		end else if (FlushD) begin      // nuevo: flush tiene prioridad
			InstrD <= 32'h00000000;     // nop instruction
			PCD <= 32'h00000000;
			PCPlus4D <= 32'h00000000;
		end else if (!StallD) begin     // nuevo: solo actualizar si no hay stall
			InstrD <= InstrF;
			PCD <= PCF;
			PCPlus4D <= PCPlus4F;
		end
		// si hay stall pero no flush, mantiene valores actuales
	end
	// ========== DECODE STAGE ==========
	
	// unidad de control
	control_unit cu(
		.op(InstrD[6:0]),
		.funct3(InstrD[14:12]),
		.funct7_5(InstrD[30]),
		.reg_writeD(RegWriteD),
		.alu_srcD(ALUSrcD),
		.mem_writeD(MemWriteD),
		.branchD(BranchD),
		.jumpD(JumpD),
		.result_srcD(ResultSrcD),
		.imm_srcD(ImmSrcD),
		.alu_controlD(ALUControlD)
	);
	
	// banco de registros
	register_file rf(
		.clk(clk),
		.we3(RegWriteW),			// write enable viene de writeback stage
		.a1(InstrD[19:15]),			// rs1
		.a2(InstrD[24:20]),			// rs2
		.a3(RdW),					// rd viene de writeback stage
		.wd3(ResultW),				// write data viene de writeback stage
		.rd1(RD1D),
		.rd2(RD2D)
	);
	
	// extensor de inmediatos
	imm_extend extend(
		.instr(InstrD[31:7]),
		.imm_src(ImmSrcD),
		.imm_ext(ImmExtD)
	);

	// ========== REGISTRO ID/EX ==========
	always @(posedge clk or posedge reset) begin
		if (reset || FlushE) begin
			// control signals
			RegWriteE <= 1'b0;
			ALUSrcE <= 1'b0;
			MemWriteE <= 1'b0;
			BranchE <= 1'b0;
			JumpE <= 1'b0;
			ResultSrcE <= 2'b00;
			ALUControlE <= 3'b000;
			
			// data signals
			RD1E <= 32'h00000000;
			RD2E <= 32'h00000000;
			PCE <= 32'h00000000;
			ImmExtE <= 32'h00000000;
			PCPlus4E <= 32'h00000000;
			
			// register addresses para forwarding futuro
			Rs1E <= 5'b00000;
			Rs2E <= 5'b00000;
			RdE <= 5'b00000;
		end 
		else begin
			// control signals
			RegWriteE <= RegWriteD;
			ALUSrcE <= ALUSrcD;
			MemWriteE <= MemWriteD;
			BranchE <= BranchD;
			JumpE <= JumpD;
			ResultSrcE <= ResultSrcD;
			ALUControlE <= ALUControlD;
			
			// data signals
			RD1E <= RD1D;
			RD2E <= RD2D;
			PCE <= PCD;
			ImmExtE <= ImmExtD;
			PCPlus4E <= PCPlus4D;
			
			// register addresses
			Rs1E <= InstrD[19:15];
			Rs2E <= InstrD[24:20];
			RdE <= InstrD[11:7];
		end
	end

	// ========== EXECUTE STAGE ==========

	// muxes de forwarding para srcA
	assign SrcAE_Forward = (ForwardAE == 2'b10) ? ALUResultM :    // forward desde memory
						(ForwardAE == 2'b01) ? ResultW :       // forward desde writeback  
						RD1E;                                  // valor normal

	// muxes de forwarding para srcB
	assign SrcBE_Forward = (ForwardBE == 2'b10) ? ALUResultM :    // forward desde memory
						(ForwardBE == 2'b01) ? ResultW :       // forward desde writeback
						RD2E;                                  // valor normal

	// mux para segundo operando de alu (ahora usa forwarded value)
	assign SrcBE = ALUSrcE ? ImmExtE : SrcBE_Forward;
	assign SrcAE = SrcAE_Forward;
	
	// alu
	alu alu_unit(
		.src_a(SrcAE),
		.src_b(SrcBE),
		.alu_control(ALUControlE),
		.result(ALUResultE),
		.zero(ZeroE)
	);

		// hazard unit
	hazard_unit hu(
		.Rs1E(Rs1E),
		.Rs2E(Rs2E), 
		.RdE(RdE),
		.Rs1D(InstrD[19:15]),
		.Rs2D(InstrD[24:20]),
		.RdM(RdM),
		.RdW(RdW),
		.RegWriteM(RegWriteM),
		.RegWriteW(RegWriteW),
		.ResultSrcE(ResultSrcE),
		.PCSrcE(PCSrcE),
		.ForwardAE(ForwardAE),
		.ForwardBE(ForwardBE),
		.StallF(StallF),
		.StallD(StallD),
		.FlushD(FlushD),
		.FlushE(FlushE)
	);
	
	// lógica de branch/jump
	assign PCSrcE = (BranchE & ZeroE) | JumpE;
	assign PCTargetE = PCE + ImmExtE;

	// ========== REGISTRO EX/MEM ==========
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			// control signals
			RegWriteM <= 1'b0;
			MemWriteM <= 1'b0;
			ResultSrcM <= 2'b00;
			
			// data signals
			ALUResultM <= 32'h00000000;
			WriteDataM <= 32'h00000000;
			PCPlus4M <= 32'h00000000;
			RdM <= 5'b00000;
		end else begin
			// control signals
			RegWriteM <= RegWriteE;
			MemWriteM <= MemWriteE;
			ResultSrcM <= ResultSrcE;
			
			// data signals
			ALUResultM <= ALUResultE;
			WriteDataM <= RD2E;		// datos a escribir en memoria
			PCPlus4M <= PCPlus4E;
			RdM <= RdE;
		end
	end

	// ========== MEMORY STAGE ==========
	
	// memoria de datos
	data_memory dmem(
		.clk(clk),
		.we(MemWriteM),
		.addr(ALUResultM),
		.wd(WriteDataM),
		.rd(ReadDataM)
	);

	// ========== REGISTRO MEM/WB ==========
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			// control signals
			RegWriteW <= 1'b0;
			ResultSrcW <= 2'b00;
			
			// data signals
			ALUResultW <= 32'h00000000;
			ReadDataW <= 32'h00000000;
			PCPlus4W <= 32'h00000000;
			RdW <= 5'b00000;
		end else begin
			// control signals
			RegWriteW <= RegWriteM;
			ResultSrcW <= ResultSrcM;
			
			// data signals
			ALUResultW <= ALUResultM;
			ReadDataW <= ReadDataM;
			PCPlus4W <= PCPlus4M;
			RdW <= RdM;
		end
	end

	// ========== WRITEBACK STAGE ==========
	
	// mux para seleccionar resultado final
	assign ResultW = (ResultSrcW == 2'b00) ? ALUResultW :
					 (ResultSrcW == 2'b01) ? ReadDataW :
					 (ResultSrcW == 2'b10) ? PCPlus4W : ALUResultW;

endmodule