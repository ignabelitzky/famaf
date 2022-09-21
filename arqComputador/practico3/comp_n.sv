module comp_n #(parameter N=64)
					(input logic [N-1:0] a,
					 input logic [N-1:0] b,
					 output logic out);
	always_comb begin
		out = (a==b)?1'b1:1'b0;
	end
endmodule