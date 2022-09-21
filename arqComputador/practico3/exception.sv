module exception #(parameter N = 64)
						(input logic clk,
						 input logic reset,
						 input logic [3:0] EStatus,
						 input logic ERet,
						 input logic Exc,
						 input logic imem_addr_F,
						 input logic [31:0] IM_readData,
						 output logic ExcAck,
						 output logic [N-1:0] IM_addr);
	logic EProc, resetESync;
	
	logic [N-1:0] ESyncOutput, ELR_Output, ERR_Output, mux2_Output, mux4_Output, Exc_vector;
	logic [3:0] ESR_Output;
	
	assign Exc_vector = 64'hD8;
	comp_n #(N) comp_nDevice(imem_addr_F, Exc_vector, resetESync);
	assign ExcAck = resetESync;
	
	esync esyncDevice(Exc, resetESync, reset, ESyncOutput);
	assign EProc = ESyncOutput & ~reset;
	
	assign IM_addr = imem_addr_E;
	
	flopr_e #(N) ELR(clk, reset, EProc, imem_addr_F, ELR_Output);
	
	flopr_e #(4) ESR(clk, reset, EProc, EStatus, ESR_Output);
	
	flopr_e #(N) ERR(clk, reset, EProc, NextPC_F, ERR_Output);
	
	mux2 #(N) mux2Device(PCBranch_E, ERR_Output, ERet, mux2_Output);
	mux4 #(N) mux4Device(ERR_Output, ELR_Output, ESR_Output, 64'b0, IM_readData[13:12], mux4_Output);
endmodule


module comp_n #(parameter N=64)
					(input logic [N-1:0] a,
					 input logic [N-1:0] b,
					 output logic out);