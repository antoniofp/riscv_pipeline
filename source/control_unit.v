module control_unit(
	// remover: input clk,
	input [6:0] op,
	input [2:0] funct3,
	input funct7_5,
	// remover: input zero,
	// cambiar nombres de outputs agregando sufijo D:
	output reg_writeD, alu_srcD, mem_writeD, branchD, jumpD,
	output [1:0] result_srcD, imm_srcD,
	output [2:0] alu_controlD
);

	// señales internas para conectar los decodificadores
	wire [1:0] alu_op;
	wire branch, jump;
	
	// instancia del decodificador principal
main_decoder md(
	.op(op),
	.branch(branchD),        // cambiar de branch a branchD
	.jump(jumpD),            // cambiar de jump a jumpD  
	.mem_write(mem_writeD),  // cambiar nombres
	.alu_src(alu_srcD),
	.reg_write(reg_writeD),
	.result_src(result_srcD),
	.imm_src(imm_srcD),
	.alu_op(alu_op)         // esta señal interna se mantiene igual
);

// instancia del decodificador alu
alu_decoder ad(
	.alu_op(alu_op),
	.funct3(funct3),
	.op_5(op[5]),
	.funct7_5(funct7_5),
	.alu_control(alu_controlD)  // cambiar a alu_controlD
);
	
	
endmodule