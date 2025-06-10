module top(
	input clk,
	input reset		
);

	// señales del program counter
	wire [31:0] pc, pc_next, pc_plus4, pc_target;
	
	// señales de la memoria de instrucciones
	wire [31:0] instr;
	
	// señales del control unit
	wire pc_src, mem_write, alu_src, reg_write;
	wire [1:0] result_src, imm_src;
	wire [2:0] alu_control;
	
	// señales del register file
	wire [31:0] rd1, rd2, result;
	
	// señal del immediate extend
	wire [31:0] imm_ext;
	
	// señales de la alu
	wire [31:0] alu_result, src_a, src_b;
	wire zero;
	
	// señales de la memoria de datos
	wire [31:0] read_data;
	
	// oa asi a instanciar
	
	// program counter
	program_counter pc_reg(
		.clk(clk),
		.reset(reset),		// nueva conexión
		.pc_next(pc_next),
		.pc(pc)
	);
	
	// memoria de instrucciones
	instruction_memory imem(
		.addr(pc),
		.instr(instr)
	);
	
	// unidad de control
	control_unit cu(
		.clk(clk),
		.op(instr[6:0]),
		.funct3(instr[14:12]),
		.funct7_5(instr[30]),
		.zero(zero),
		.pc_src(pc_src),
		.mem_write(mem_write),
		.alu_src(alu_src),
		.reg_write(reg_write),
		.result_src(result_src),
		.imm_src(imm_src),
		.alu_control(alu_control)
	);
	
	// banco de registros
	register_file rf(
		.clk(clk),
		.we3(reg_write),
		.a1(instr[19:15]),		// rs1
		.a2(instr[24:20]),		// rs2
		.a3(instr[11:7]),		// rd
		.wd3(result),
		.rd1(rd1),
		.rd2(rd2)
	);
	
	// extensor de inmediatos
	imm_extend extend(
		.instr(instr[31:7]),
		.imm_src(imm_src),
		.imm_ext(imm_ext)
	);
	
	// alu
	alu alu_unit(
		.src_a(src_a),
		.src_b(src_b),
		.alu_control(alu_control),
		.result(alu_result),
		.zero(zero)
	);
	
	// memoria de datos
	data_memory dmem(
		.clk(clk),
		.we(mem_write),
		.addr(alu_result),
		.wd(rd2),
		.rd(read_data)
	);
	
	// muxes y lógica combinacional (muy simples para ser un módulo aparte)
	
	// sumador pc + 4
	assign pc_plus4 = pc + 32'd4;
	
	// sumador pc + imm (para branches y jumps)
	assign pc_target = pc + imm_ext;
	
	// mux para seleccionar siguiente valor del pc
	assign pc_next = pc_src ? pc_target : pc_plus4;
	
	// mux para seleccionar operando b de la alu
	assign src_b = alu_src ? imm_ext : rd2;
	
	// src_a siempre viene del register file, es para mantener los nombres igual al diagraam
	assign src_a = rd1;
	
	// mux para seleccionar el resultado a escribir en el register file
	assign result = (result_src == 2'b00) ? alu_result :
						(result_src == 2'b01) ? read_data :
						(result_src == 2'b10) ? pc_plus4 : alu_result;

endmodule