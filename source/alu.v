module alu(
	input [31:0] src_a,			
	input [31:0] src_b,		
	input [2:0] alu_control, // pueden ser: 000 (suma), 001 (resta), 010 (and), 011 (or), 101 (set less than)
	output reg [31:0] result,	
	output zero					// flag que indica si el resultado es cero
);

	always @(*) begin
		case (alu_control)
			3'b000: result = src_a + src_b;						// suma
			3'b001: result = src_a - src_b;						// resta
			3'b010: result = src_a & src_b;						// and lógico
			3'b011: result = src_a | src_b;						// or lógico
			3'b101: result = (src_a < src_b) ? 32'b1 : 32'b0;	// set less than (comparación con signo)
			default: result = 32'b0;							
		endcase
	end
	
	// la señal zero se activa cuando el resultado es cero
	assign zero = (result == 32'b0);
	
endmodule