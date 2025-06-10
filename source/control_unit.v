module control_unit(
	input clk,
	input [6:0] op,
	input [2:0] funct3,
	input funct7_5,
	input zero,					// señal zero de la alu para branches
	output pc_src,				// señal de control del pc (branch tomado o jump)
	output mem_write, alu_src, reg_write,
	output [1:0] result_src, imm_src,
	output [2:0] alu_control
);

	// señales internas para conectar los decodificadores
	wire [1:0] alu_op;
	wire branch, jump;
	
	// instancia del decodificador principal
	main_decoder md(
		.op(op),
		.branch(branch),
		.jump(jump),
		.mem_write(mem_write),
		.alu_src(alu_src),
		.reg_write(reg_write),
		.result_src(result_src),
		.imm_src(imm_src),
		.alu_op(alu_op)
	);
	
	// instancia del decodificador alu
	alu_decoder ad(
		.alu_op(alu_op),
		.funct3(funct3),
		.op_5(op[5]),
		.funct7_5(funct7_5),
		.alu_control(alu_control)
	);
	
	// lógica de control del pc: (branch AND zero) OR jump
	assign pc_src = (branch & zero) | jump;
	
endmodule