module alu_decoder(
	input [1:0] alu_op,
	input [2:0] funct3,
	input op_5,
	input funct7_5,
	output reg [2:0] alu_control
);
	
	always @(*)
	begin
		case(alu_op)
			2'b00: alu_control = 3'b000; // suma para lw/sw
			2'b01: alu_control = 3'b001; // resta para beq
			2'b10: begin
				case(funct3)
					3'b000: begin
						// concatenamos op_5 y funct7_5 para distinguir entre add y sub
						if ({op_5, funct7_5} == 2'b11)
							alu_control = 3'b001; // resta (sub)
						else
							alu_control = 3'b000; // suma (add)
					end
					3'b010: alu_control = 3'b101; // slt (set less than)
					3'b110: alu_control = 3'b011; // or
					3'b111: alu_control = 3'b010; // and
					default: alu_control = 3'b000; // por defecto usamos suma
				endcase
			end
			default: alu_control = 3'b000; // por defecto usamos suma
		endcase
	end
	
endmodule