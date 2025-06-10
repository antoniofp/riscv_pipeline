module register_file(
	input wire clk,					
	input wire we3,					// write enable del puerto 3 (el puerto 3 es el a3)
	input wire [4:0] a1, a2, a3,	// direcciones de los registros (5 bits = 32 registros)
	input wire [31:0] wd3,			// write data del puerto 3 (datos a escribir)
	output wire [31:0] rd1, rd2		//datos leídos de las direcciones a1 y a2
);

	// banco de 32 registros de 32 bits cada uno
	reg [31:0] registers [0:31];
	
	// la lectura de los registros puede ser combinacional porque rd1 y rd2 solo dependen de a1 y a2
	// si la dirección es 0 (x0), siempre devuelve 0, sino devuelve el contenido del registro
	assign rd1 = (a1 == 5'b00000) ? 32'b0 : registers[a1];
	assign rd2 = (a2 == 5'b00000) ? 32'b0 : registers[a2];
	
	// escritura síncrona (en flanco positivo del reloj)
	//se hace de forma síncrona para evitar escrituras y lecturas simultáneas que puedan causar condiciones de carrera
	always @(posedge clk) begin
		// solo escribir si write enable está activo y no es el registro x0
		// el registro x0 siempre debe mantenerse en 0 según la especificación risc-v
		if (we3 && (a3 != 5'b00000)) begin
			registers[a3] <= wd3;
		end
	end
	
endmodule