module fetch #(parameter N = 64)
					(input logic PCSrc_F, clk, reset,
					input logic [63:0] PCBranch_F,
					output logic [63:0] imem_addr_F);
	logic [N-1:0] muxOut, addOut;
	mux2 muxDevice(addOut, PCBranch_F, PCSrc_F, muxOut);
	flopr floprDevice(clk, reset, muxOut, imem_addr_F);
	adder addDevice(imem_addr_F, 64'b100, addOut);	// sum of 4
endmodule