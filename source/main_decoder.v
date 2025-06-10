module main_decoder(
	input [6:0] op,
	output reg branch, jump, mem_write, alu_src, reg_write,
	output reg [1:0] result_src, imm_src, alu_op
);
	always @(*)
	begin
		case(op)
			7'b0000011: // op = 3: lw
			begin
				reg_write = 1;
				imm_src = 2'b00;
				alu_src = 1;
				mem_write = 0;
				result_src = 2'b01;
				branch = 0;
				alu_op = 2'b00;
				jump = 0;
			end
			
			7'b0100011: // op = 35: sw
			begin
				reg_write = 0;
				imm_src = 2'b01;
				alu_src = 1;
				mem_write = 1;
				result_src = 2'bXX; // Don't care
				branch = 0;
				alu_op = 2'b00;
				jump = 0;
			end
			
			7'b0110011: // op = 51: R-type
			begin
				reg_write = 1;
				imm_src = 2'bXX; // Don't care
				alu_src = 0;
				mem_write = 0;
				result_src = 2'b00;
				branch = 0;
				alu_op = 2'b10;
				jump = 0;
			end
			
			7'b1100011: // op = 99: beq
			begin
				reg_write = 0;
				imm_src = 2'b10;
				alu_src = 0;
				mem_write = 0;
				result_src = 2'bXX; // Don't care
				branch = 1;
				alu_op = 2'b01;
				jump = 0;
			end
			
			7'b0010011: // op = 19: I-type
			begin
				reg_write = 1;
				imm_src = 2'b00;
				alu_src = 1;
				mem_write = 0;
				result_src = 2'b00;
				branch = 0;
				alu_op = 2'b10;
				jump = 0;
			end
			
			7'b1101111: // op = 111: jal
			begin
				reg_write = 1;
				imm_src = 2'b11;
				alu_src = 1'bX; // Don't care
				mem_write = 0;
				result_src = 2'b10;
				branch = 0;
				alu_op = 2'bXX; // Don't care
				jump = 1;
			end
			
			default: // valores por defecto para instrucciones no implementadas
			begin
				reg_write = 0;
				imm_src = 2'b00;
				alu_src = 0;
				mem_write = 0;
				result_src = 2'b00;
				branch = 0;
				alu_op = 2'b00;
				jump = 0;
			end
		endcase
	end
endmodule