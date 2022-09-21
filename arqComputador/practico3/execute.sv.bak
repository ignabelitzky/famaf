module execute #(parameter N = 64)
					(input logic AluSrc,
					input logic [3:0] AluControl,
					input logic [N-1:0] PC_E,
					input logic [N-1:0] signImm_E,
					input logic [N-1:0] readData1_E,
					input logic [N-1:0] readData2_E,
					output logic [N-1:0] PCBranch_E,
					output logic [N-1:0] aluResult_E,
					output logic [N-1:0] writeData_E,
					output logic zero_E);
	logic [N-1:0] sl2Output;
	logic [N-1:0] muxOutput;
	sl2 sl2Device(signImm_E, sl2Output);
	adder addDevice(sl2Output, PC_E, PCBranch_E);
	mux2 muxDevice(readData2_E, signImm_E, AluSrc, muxOutput);
	alu aluDevice(readData1_E, muxOutput, AluControl, aluResult_E, zero_E);
	assign writeData_E = readData2_E;
endmodule