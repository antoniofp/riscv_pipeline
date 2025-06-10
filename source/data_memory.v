module data_memory(
	input wire clk,				
	input wire we,				// write enable (mem_write del control unit dumbas)
	input wire [31:0] addr,		// dirección de memoria
	input wire [31:0] wd,		// datos a escribir (write data)
	output wire [31:0] rd		// datos leídos (read data)
);

	reg [31:0] ram [0:1023];	// 1024 palabras de 32 bits (4kb), igual que instruction memory
	
	// addr[31:2] divide la dirección por 4 para indexar correctamente (direccionamiento por palabra)
    // por el momento no se puede acceder a un byte específico, solo a palabras completas de 32 bits
    // esto es suficiente para la mayoría de las arquitecturas RISC-V, que trabajan con palabras de 32 bits

	// escritura síncrona: solo escribe en flanco positivo del reloj cuando we está activo
	always @(posedge clk) begin
		if (we && addr[31:2] < 1024) begin
			ram[addr[31:2]] <= wd;
		end
	end
	
	// la lectura no tiene que ser síncrona porque la señal de addres es combinacional también
	assign rd = (addr[31:2] < 1024) ? ram[addr[31:2]] : 32'h00000000;

endmodule