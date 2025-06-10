module instruction_memory(
	input wire [31:0] addr,       
	output wire [31:0] instr       
);


	reg [31:0] rom [0:1023];      // 1024 palabras de 32 bits (4KB)
	
	initial begin
		$readmemh("program.hex", rom);
		
	end
	

	assign instr = (addr[31:2] < 1024) ? rom[addr[31:2]] : 32'h00000000; // regresar 0 si la dirección está fuera de rango
	// addr[31:2] se usa para acceder a la memoria de instrucciones, ya que cada instrucción es de 4 bytes (32 bits)
	// it is the same as addr >> 2, we divide by 4 to get the index in the rom array

	


endmodule