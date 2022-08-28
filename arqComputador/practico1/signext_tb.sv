`timescale 1ns / 1ps

module signext_tb();
	logic [31:0] a;
	logic [63:0] y;
	
	signext dut(a, y);
	initial begin
		a = 32'b1111_1000_0101_1010_1010_1010_1010_1010; #10;	// LDUR Instruction
		a = 32'b1111_1000_0101_1111_1111_1111_1111_1111; #10;	// LDUR Instruction
		a = 32'b1111_1000_0001_1010_1010_1010_1010_1010; #10;	// STUR Instruction
		a = 32'b1111_1000_0001_1111_1111_1111_1111_1111; #10;	// STUR Instruction
		a = 32'b1011_0100_1111_1111_0000_0000_1111_1111; #10;	// CBZ Instruction
		a = 32'b1111_1111_1111_1111_1111_1111_1111_1111; #10; // Incorrect input (default case)
	end
endmodule