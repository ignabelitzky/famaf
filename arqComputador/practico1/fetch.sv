// fetch module
/*
module fetch #(parameter N = 64)
					(input logic PCSrc_F,
					input logic clk,
					input logic reset,
					input logic [N-1:0] PCBranch_F,
					output logic [N-1:0] imem_addr_F);
	
	logic [N-1:0] adderResult;
	logic [N-1:0] muxResult;
					
	always_ff @(posedge clk, posedge reset) begin
		flopr #(N) floprDevice(clk, reset, muxResult, imem_addr_F);
		mux2 #(N) muxDevice(adderResult, PCBranch_F, PCSrc_F, muxResult);
		adder #(N) adderDevice(4, imem_addr_F, adderResult);
	end
endmodule
*/