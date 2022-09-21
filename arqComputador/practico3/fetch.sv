module fetch #(parameter N = 64)
					(input logic PCSrc_F, clk, reset,
					input logic [N-1:0] PCBranch_F,
					input logic [N-1:0] EProc_F,
					input logic [N-1:0] EVAddr_F,
					output logic [N-1:0] imem_addr_F,
					output logic [N-1:0] NextPC_F);
	logic [N-1:0] muxOut1, muxOut2, addOut;
	mux2 muxDevice(addOut, PCBranch_F, PCSrc_F, muxOut1);
	mux2 muxDevice2(muxOut1, EVAddr_F, EProc_F, muxOut2);
	flopr floprDevice(clk, reset, muxOut2, imem_addr_F);
	adder addDevice(imem_addr_F, 64'b100, addOut);
	assign NextPC_F = muxOut1;
endmodule