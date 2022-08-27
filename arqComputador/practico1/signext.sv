module signext(input logic [31:0] a,
					output logic [63:0] b);
	always_comb begin
		casez(a[31:21])
			11'b111_1100_00?0: b = {{55{a[20]}}, a[20:12]};	// LDUR or STUR
			11'b101_1010_0???: b = {{43{a[23]}}, a[23:5], 2'b00};
			default: b = '0;
		endcase
	end
endmodule