`timescale 1ns / 1ps

module alu_tb();
	parameter N = 64;
	logic [N-1:0] a, b, c, resultadoEsperado;
	logic zeroEsperado;
	logic zero;
	logic [3:0] aluControl;
	logic [3:0] vectornum, errors;
	logic [196:0] testvectors [14:0];
	logic clk;
	
	// device under testing
	alu #(N) dut(a, b, aluControl, c, zero);
	
	initial begin
		vectornum = 0; errors = 0; zero = 0;
		a = 0; b = 0; c = 0; resultadoEsperado = 0;
		zeroEsperado = 0; aluControl = 0;
							//	input1  		input2	resultado-esperado	AluControl		valor-zero-esperado
		testvectors	= '{	{64'h267B,	64'h3D8,		64'h258,				4'h0,					1'b0},		//	0x267B and 0x3D8 = 0x258
								{64'hABC,	64'hDEF,		64'h8AC,				4'h0,					1'b0}, 	// 0xABC and 0xDEF = 0x8AC
								{64'h6D55,	64'h92AA,	64'h0,				4'h0,					1'b1},		// 0x6D55 and 0x92AA = 0x0
							
								{64'hA596,	64'h4EAA,	64'hEFBE,			4'h1,					1'b0},		// 0xA596 or 0x4EAA = 0xEFBE
								{64'h0,		64'h0,		64'h0,				4'h1,					1'b1},		// 0x0 or 0x0 = 0x0
								{64'h4565,	64'hBA9A,	64'hFFFF,			4'h1,					1'b0},		// 0x4565 or 0xBA9A = 0xFFFF
							
								{64'h967B,	64'hC8A1,	64'h15F1C,			4'h2,					1'b0},		// 0x967b + 0xC8A1 = 0x15F1C
								{64'hFFFF,	64'hFFFF,	64'h1FFFE,			4'h2,					1'b0},		// 0xFFFF + 0xFFFF = 0x1FFFE
								{64'h0,		64'h0,		64'h0,				4'h2,					1'b1},		//	0x0 + 0x0 = 0x0
							
								{64'h569B,	64'hB858,	64'hFFFFFFFFFFFF9E43,	4'h6,			1'b0},		// 0x569b - 0xB858 = 0xFFF...F9E43 (twos complement)
								{64'h0,		64'h0,		64'h0,				4'h6,					1'b1},		// 0x0 - 0x0 = 0x0
								{64'h4589,	64'h32A2,	64'h12E7,			4'h6,					1'b0},		// 0x4589 - 0x32A2 = 0x12E7
							
								{64'h0,		64'h0,		64'h0,				4'h7,					1'b1},		// pass input b = 0x0
								{64'hD255,	64'h42A4,	64'h42A4,			4'h7,					1'b0},		// pass input b = 0x42A4
								{64'h61BD,	64'h0,		64'h0,				4'h7,					1'b1}};		// pass input b = 0x0
	end
	
	// generate clock
	always begin
		clk = 0; #5; clk = 1; #5;
	end
	
	always @(negedge clk) begin
		{a, b, resultadoEsperado, aluControl, zeroEsperado} = testvectors[vectornum];
		vectornum = vectornum + 1;
	end
	
	always @(posedge clk) begin
		if(c !== resultadoEsperado) begin
			$display("Error: inputs = (a = %h) (b = %h)", a, b);
			$display("	outputs = %h (%h expected)", c, resultadoEsperado);
			errors = errors + 1;
		end
		if(zero !== zeroEsperado) begin
			$display("Error: inputs = (a = %h) (b = %h)", a, b);
			$display("	output zero error = %b (%b expected)", zero, zeroEsperado);
		end
		if(vectornum == 15) begin
			$display("%d tests completed with %d errors", vectornum, errors);
			$stop;
		end
	end
endmodule
