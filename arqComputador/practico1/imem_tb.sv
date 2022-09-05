`timescale 1ns / 1ps

module imem_tb();

	parameter N = 32;
	
	logic clk; 
	logic [5:0] addr; // entrada addr del modulo imem
	logic [N-1:0] q, q_expected; // salida q del modulo y salida q_expected esperada
	logic [63:0] errors, test; //le pongo 63 para q me alcance
	
	logic [37:0] tests [0:49];
	initial begin
		test = '0;
		errors = '0;
		tests = '{ //38 bits pq son 6 de la entrada addr + 32 de la salida
				{6'b000000, 32'hf8000001}, //direcc 1
				{6'b000001, 32'hf8008002}, //direcc 2
				{6'b000010, 32'hf8000203}, //direcc 3
				{6'b000011, 32'h8b050083}, //direcc 4
				{6'b000100, 32'hf8018003}, //direcc 5
				{6'b000101, 32'hcb050083}, //direcc 6
				{6'b000110, 32'hf8020003}, //direcc 7
				{6'b000111, 32'hcb0a03e4}, //direcc 8
				{6'b001000, 32'hf8028004}, //direcc 9
				{6'b001001, 32'h8b040064}, //direcc 10
				{6'b001010, 32'hf8030004}, //direcc 11
				{6'b001011, 32'hcb030025}, //direcc 12
				{6'b001100, 32'hf8038005}, //direcc 13
				{6'b001101, 32'h8a1f0145}, //direcc 14
				{6'b001110, 32'hf8040005}, //direcc 15
				{6'b001111, 32'h8a030145}, //direcc 16
				{6'b010000, 32'hf8048005}, //direcc 17
				{6'b010001, 32'h8a140294}, //direcc 18
				{6'b010010, 32'hf8050014}, //direcc 19
				{6'b010011, 32'haa1f0166}, //direcc 20
				{6'b010100, 32'hf8058006}, //direcc 21
				{6'b010101, 32'haa030166}, //direcc 22
				{6'b010110, 32'hf8060006}, //direcc 23
				{6'b010111, 32'hf840000c}, //direcc 24
				{6'b011000, 32'h8b1f0187}, //direcc 25
				{6'b011001, 32'hf8068007}, //direcc 26
				{6'b011010, 32'hf807000c}, //direcc 27
				{6'b011011, 32'h8b0e01bf}, //direcc 28
				{6'b011100, 32'hf807801f}, //direcc 29
				{6'b011101, 32'hb4000040}, //direcc 30
				{6'b011110, 32'hf8080015}, //direcc 31
				{6'b011111, 32'hf8088015}, //direcc 32
				{6'b100000, 32'h8b0103e2}, //direcc 33
				{6'b100001, 32'hcb010042}, //direcc 34
				{6'b100010, 32'h8b0103f8}, //direcc 35
				{6'b100011, 32'hf8090018}, //direcc 36
				{6'b100100, 32'h8b080000}, //direcc 37
				{6'b100101, 32'hb4ffff82}, //direcc 38
				{6'b100110, 32'hf809001e}, //direcc 39
				{6'b100111, 32'h8b1e03de}, //direcc 40
				{6'b101000, 32'hcb1503f5}, //direcc 41
				{6'b101001, 32'h8b1403de}, //direcc 42
				{6'b101010, 32'hf85f83d9}, //direcc 43
				{6'b101011, 32'h8b1e03de}, //direcc 44
				{6'b101100, 32'h8b1003de}, //direcc 45
				{6'b101101, 32'hf81f83d9}, //direcc 46
				{6'b101110, 32'hb400001f}, //direcc 47
				{6'b101111, 32'h00000000}, //direcc 48
				{6'b110000, 32'h00000000}, //direcc 49
				{6'b110001, 32'h00000000}	//direcc 50
		};
	end
	
	// instancia del modulo imem
	imem dut(addr, q);
	
	// generate clock
	always begin
		clk = 0; #5; clk = 1; #5;
	end
	
	//
	always @(negedge clk) begin
		{addr, q_expected} = tests[test];
		test = test + 1;
	end
	
	// check results on falling edge of clk
	always @(posedge clk) begin
		#1;
		if (q !== q_expected) begin
			$display("error: test finished with unexpected result!");
			$display("q = %h (expected %h)(in %dth instance", q, q_expected, test);
			errors = errors + 1;
		end
		
		if (tests[test] === 38'bx) begin
			$display("%d/%d tests finished succesfully", test-errors, test);
			$stop;
		end
	end

endmodule	
		