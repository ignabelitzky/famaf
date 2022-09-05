`timescale 1ns / 1ps

module regfile_tb();
	logic clk;
	logic [4:0] ra1, ra2, wa3;
	logic [63:0] wd3, rd1, rd2;
	logic we3;

	always begin
		clk = 0; #5; clk = 1; #5;
	end

	always_ff @(negedge clk) begin
		
	end

endmodule