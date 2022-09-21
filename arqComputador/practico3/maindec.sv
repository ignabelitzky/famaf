module maindec (input logic [10:0] Op,
					 output logic Reg2Loc,
					 output logic ALUSrc,
					 output logic MemtoReg,
					 output logic RegWrite,
					 output logic MemRead,
					 output logic MemWrite,
					 output logic Branch,
					 output logic [1:0] ALUOp);
					 
	logic [8:0] bitMask = '0;

	always_comb begin
		casez(Op)
			11'b111_1100_0010: bitMask = 9'b011110000;	// LDUR
			11'b111_1100_0000: bitMask = 9'b110001000;	// STUR
			11'b101_1010_0???: bitMask = 9'b100000101;	// CBZ
			11'b1?0_0101_1000: bitMask = 9'b000100010;	// ADD or SUB
			11'b10?_0101_0000: bitMask = 9'b000100010;	// AND or ORR
			default: bitMask = '0;
		endcase
		Reg2Loc = bitMask[8];
		ALUSrc = bitMask[7];
		MemtoReg = bitMask[6];
		RegWrite = bitMask[5];
		MemRead = bitMask[4];
		MemWrite = bitMask[3];
		Branch = bitMask[2];
		ALUOp = bitMask[1:0];
	end
endmodule