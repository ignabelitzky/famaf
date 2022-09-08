`timescale 1ns / 1ps

module regfile_tb();
	
	logic clk, we3;
	logic [4:0] ra1, ra2, wa3;
	logic [4:0] rd1_expected, rd2_expected;
	logic [63:0] rd1, rd2, wd3, errors, test;
	
	
	logic [207:0] results [0:15] = '{
	// ra1 	ra2 	wa3 	wd3 		we3	rd1 	rd2
		{5'd0, 5'd1, 5'd0, 64'd35, 1'b0, 64'd0, 64'd1}, 
		// ra1 = x0, ra2 = x1, wa3 = x0, wd3 = 35, we3 = 0
		
		{5'd2, 5'd3, 5'd2, 64'd27, 1'b1, 64'd27, 64'd3},  
		// ra1 = x2, ra2 = x3, wa3 = x2, wd3 = 27, we3 = 1
		
		{5'd4, 5'd5, 5'd4, 64'd28, 1'b0, 64'd4, 64'd5},  
		// ra1 = x4, ra2 = x5, wa3 = x4, wd3 = 28, we3 = 0
		
		{5'd6, 5'd7, 5'd0, 64'd0, 1'b0, 64'd6, 64'd7},  
		// ra1 = x6, ra2 = x7, wa3 = 0, wd3 = 0, we3 = 0
		
		{5'd8, 5'd9, 5'd0, 64'd0, 1'b0, 64'd8, 64'd9},  
		// ra1 = x8, ra2 = x9, wa3 = 0, wd3 = 0, we3 = 0
		
		{5'd10, 5'd11, 5'd0, 64'd0, 1'b0, 64'd10, 64'd11},  
		// ra1 = x10, ra2 = x11, wa3 = 0, wd3 = 0, we3 = 0
		
		{5'd12, 5'd13, 5'd0, 64'd0, 1'b0, 64'd12, 64'd13},  
		// ra1 = x12, ra2 = x13, wa3 = 0, wd3 = 0, we3 = 0
		
		{5'd14, 5'd15, 5'd0, 64'd0, 1'b0, 64'd14, 64'd15},  
		// ra1 = x14, ra2 = x15, wa3 = 0, wd3 = 0, we3 = 0
		
		{5'd16, 5'd17, 5'd0, 64'd0, 1'b0, 64'd16, 64'd17},  
		// ra1 = x16, ra2 = x17, wa3 = 0, wd3 = 0, we3 = 0
		
		{5'd18, 5'd19, 5'd0, 64'd0, 1'b0, 64'd18, 64'd19},  
		// ra1 = x18, ra2 = x19, wa3 = 0, wd3 = 0, we3 = 0
		
		{5'd20, 5'd21, 5'd0, 64'd0, 1'b0, 64'd20, 64'd21},  
		// ra1 = x20, ra2 = x21, wa3 = 0, wd3 = 0, we3 = 0
		
		{5'd22, 5'd23, 5'd0, 64'd0, 1'b0, 64'd22, 64'd23},  
		// ra1 = x22, ra2 = x23, wa3 = 0, wd3 = 0, we3 = 0
		
		{5'd24, 5'd25, 5'd0, 64'd0, 1'b0, 64'd24, 64'd25},  
		// ra1 = x24, ra2 = x25, wa3 = 0, wd3 = 0, we3 = 0
		
		{5'd26, 5'd27, 5'd0, 64'd0, 1'b0, 64'd26, 64'd27},  
		// ra1 = x26, ra2 = x27, wa3 = 0, wd3 = 0, we3 = 0
		
		{5'd28, 5'd29, 5'd0, 64'd0, 1'b0, 64'd28, 64'd29},  
		// ra1 = x28, ra2 = x29, wa3 = 0, wd3 = 0, we3 = 0
		
		{5'd30, 5'd31, 5'd31, 64'd52, 1'b1, 64'd30, 64'd0}  
		// ra1 = x30, ra2 = x31, wa3 = x31, wd3 = 52, we3 = 1
	};
	
	regfile dut(clk, we3, ra1, ra2, wa3, wd3, rd1, rd2);
	
	always begin
		clk = 0; #5; clk = 1; #5;
	end
		
	always @(negedge clk) begin
		{ra1, ra2, wa3} = results[test][207:193];
		{wd3, we3} = results[test][192:128];
		rd1_expected = results[test][127:64];
		rd2_expected = results[test][63:0];
		test = test + 1;
	end

	
	always @(posedge clk) begin
		#3;
		if (rd1 !== rd1_expected || rd2 !== rd2_expected) begin
			$display("error: test finished with unexpected result!");
			$display("rd1 = %d (expected %d) in %dth instance", rd1, rd1_expected, test);
			$display("rd2 = %d (expected %d) in %dth instance", rd2, rd2_expected, test);
			$display("results[%d] = %b", test, results[test]);
			errors = errors + 1;
			$stop;
		end
		
		if (results[test] === 208'bx) begin
			$display("%d/%d tests finished succesfully", test-errors, test);
			$stop;
		end
	end
	
	initial begin
		test = 0; errors = 0;
	end
endmodule