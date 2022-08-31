`timescale 1ns / 1ps

/*
 Realizar un test bench que:
- Instancie el módulo flopr con N=64.
- Genere una señal de reloj en el puerto clk del módulo, cuya frecuencia sea 100MHz
(periodo de 10 ns).
- Por el puerto de entrada d ingrese 10 números distintos, de 64 bits c/u, en cada flanco
descendente de clk y mantenga dicho valor a la entrada por 10 ns.
- Genere una señal de reset que permanezca en ‘1’ durante el ingreso de los primeros 5
números y luego tome el valor ‘0’ hasta finalizar la simulación.
- Verifique que durante los primeros 5 ciclos de clock la salida sea cero y en los 5 siguientes,
que después del flanco ascendente de clock se obtenga a la salida el valor ingresado.
- Finalmente, repetir el procedimiento anterior, pero instanciando el módulo flopr con N=32.
*/

module flopr_tb();
	parameter N = 64;
	
	logic 			clk, reset;
	logic [N-1:0]	d, q;
	logic [4:0]	vectornum, errors;	// bookkeping variables
	logic [N-1:0]	testvectors [0:9];
	
	// instance device under test
	flopr #(N) dut(clk, reset, d, q);
	
	// at start of test pulse reset
	initial begin
		vectornum = 0; errors = 0; d = 0;
		testvectors = '{64'hA, 64'hA1, 64'h10, 64'hABCDE, 64'h123,
							 64'hC0CA, 64'hB3B3, 64'hCA5A, 64'h666, 64'h10C0};
		reset = 1; #50; reset = 0;
	end
	
	// generate clock
	always	// no sensitivity list, so it always executes
		begin
			clk = 1; #5; clk = 0; #5;
		end
	
	// change test vectors little time after the falling edge of clk
	always @(negedge clk) begin
		#1;
		d = testvectors[vectornum];
		vectornum = vectornum + 1;
	end
	
	// check for errors little time after the rising edge of clk if not reset applied
	always @(posedge clk) begin
		#1;
		if (~reset) begin	// dkip during reset
			if (q !== d) begin
				$display("Error: inputs = %b", d);
				$display("	outputs = %b (%b expected)", q, d);
				errors = errors + 1;
			end
		end
		else begin
			if(q !== 64'b0) begin
				$display("Error: inputs = %b", d);
				$display("	outputs = %b (%b expected)", q, 64'b0);
				errors = errors + 1;
			end
		end
	end
	
	// check for finalization
	always @(negedge clk) begin
		#10;
		if(vectornum == 10) begin
			$display("%d tests completed with %d errors", vectornum, errors);
			$stop;
		end
	end
endmodule