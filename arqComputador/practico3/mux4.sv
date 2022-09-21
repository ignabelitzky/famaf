module mux2 #(parameter N = 64)
					(input logic [N-1:0] d0,
					 input logic [N-1:0] d1,
					 input logic [N-1:0] d2,
					 input logic [N-1:0] d3,
					 input logic [1:0] s,
					 output logic [N-1:0] y);
	always_comb begin
		case(s)
			2'b00: y = d0;
			2'b01: y = d1;
			2'b10: y = d2;
			2'b11: y = d3;
			default: y = d0;
		endcase
	end
endmodule