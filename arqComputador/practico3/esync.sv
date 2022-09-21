module esync (input logic Exc,
				  input logic resetEsync,
				  input logic reset,
				  output logic out);
	always @(Exc, resetEsync, reset) begin
		if (reset)
			out <= 1'b0;
		if (resetEsync)
			out <= 1'b0;
		if (Exc)
			out <= 1'b1;
	end
endmodule
					