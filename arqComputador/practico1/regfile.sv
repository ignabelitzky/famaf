module regfile(input logic clk,
					input logic we3,
					input logic [4:0] ra1,
					input logic [4:0] ra2,
					input logic [4:0] wa3,
					input logic [63:0] wd3,
					output logic [63:0] rd1,
					output logic [63:0] rd2);

	logic [63:0] registers [31:0];
	
	initial begin
		for (int i = 0; i < $size(registers)-1; i++) begin
			registers[i] = i;
		end
		registers[31] = '0;
	end

	always @(posedge clk) begin
		if (we3 && wa3 !== 5'b11111)	// 5'b11111 = 31
			registers[wa3] <= wd3;
	end
	
	always_comb begin
		rd1 = registers[ra1];
		rd2 = registers[ra2];
	end
endmodule