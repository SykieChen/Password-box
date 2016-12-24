module multiplexer(input32, sel, output4);
	input [31:0] input32;
	input [2:0] sel;
	output reg [3:0] output4;
	always@(sel)
		output4 = input32 >> ((7-sel)*4);
endmodule
		