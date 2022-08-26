// Flip-Flop D implementation with asynchronous reset

module flopr #(parameter N = 64)
				(input logic clk,
				 input logic reset,
				 input logic [N-1:0] d,
				 output logic [N-1:0] q);
	always_ff @(posedge clk, posedge reset) begin
		if (reset)
			q <= '0;
		else
			q <= d;
	end
endmodule

// <= is nonblocking assignment: occurs simultaneously with others (for sequential logic)
// = is blocking assignment: occurs in order it appears in file (for combinational logic)