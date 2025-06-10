module imm_extend(
	input [31:7] instr,			// bits 31 a 7 de la instrucción, está bien cool porque los bits se mantienen en la misma posición
								// y no tengo que hacer malabares mentales (restarle 7 a la posición real) para hacer el slicing aquí
	input [1:0] imm_src,		// selector del tipo de inmediato
	output reg [31:0] imm_ext	// inmediato extendido a 32 bits
);

	parameter I_TYPE = 2'b00;	// inmediatos immediate-type 
	parameter S_TYPE = 2'b01;	// inmediatos store-type 
	parameter B_TYPE = 2'b10;	// inmediatos branc-type 
	parameter J_TYPE = 2'b11;	// inmediatos jump-type 

	always @(*) begin
		case (imm_src)
			I_TYPE: begin // i-type: imm[11:0] = instr[31:20]
				imm_ext = {{20{instr[31]}}, instr[31:20]};
			end
			
			S_TYPE: begin // s-type: imm[11:0] = {instr[31:25], instr[11:7]}
				imm_ext = {{20{instr[31]}}, instr[31:25], instr[11:7]};
			end
			
			B_TYPE: begin // b-type: imm[12:1] = {instr[31], instr[7], instr[30:25], instr[11:8]}
				// el bit 0 siempre es 0 en branch (direcciones alineadas)
				imm_ext = {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};
			end
			
			J_TYPE: begin // j-type: imm[20:1] = {instr[31], instr[19:12], instr[20], instr[30:21]}
				// el bit 0 siempre es 0 en jump (direcciones alineadas)
				imm_ext = {{11{instr[31]}}, instr[31], instr[19:12], instr[20], instr[30:21], 1'b0};
			end
			
			default: begin
				imm_ext = 32'b0; // valor por defecto
			end
		endcase
	end

endmodule

