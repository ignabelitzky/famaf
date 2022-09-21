module flopr #(parameter N = 64)
				(input logic clk,
				 input logic reset,
				 input logic enable,
				 input logic [N-1:0] d,
				 output logic [N-1:0] q);
	always_ff @(posedge clk, posedge reset) begin
		if (enable) begin
			if (reset)
				q <= '0;
			else
				q <= d;
		end
	end
endmodule