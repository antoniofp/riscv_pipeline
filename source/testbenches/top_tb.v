module top_tb();

	reg clk;
	reg rst;
	
	// instancia del cpu
	top cpu_dut (
		.clk(clk), 
		.reset(rst)
	);
	
	// generacion del reloj
	always begin
		#10 clk = ~clk;  
	end
	
	// inicializacion y reset - TODO EN UN BLOQUE
	initial begin
		clk = 0;		// inicializar reloj
        rst = 0;		// inicializar reset
        #20;			// esperar 20ns antes de activar el reset
		rst = 1;		// activar reset
		#50;			// mantenerlo activo por 50ns
		rst = 0;		// desactivar reset
		
		#1000;			// esperar
		$finish;
	end

endmodule