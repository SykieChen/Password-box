module keyboard(clk, SWC, SWR0, SWR1, SWR2, SWR3, key);
	input clk;
	input [3:0] SWC;
	output reg SWR0, SWR1, SWR2, SWR3;
	output reg [3:0] key;
	reg [1:0] state;
	always@(state)
		case(state)
			0:{SWR0, SWR1, SWR2, SWR3}=4'b0111;
			1:{SWR0, SWR1, SWR2, SWR3}=4'b1011;
			2:{SWR0, SWR1, SWR2, SWR3}=4'b1101;
			3:{SWR0, SWR1, SWR2, SWR3}=4'b1110;
		endcase
	always@(posedge clk)
	begin
		case(state)
			0:state<=1;
			1:state<=2;
			2:state<=3;
			3:state<=0;
		endcase
		case({SWR0, SWR1, SWR2, SWR3, SWC})
				8'b01110111:key<=4'b0000;
				8'b01111011:key<=4'b0001;
				8'b01111101:key<=4'b0010;
				8'b01111110:key<=4'b0011;
				8'b10110111:key<=4'b0100;
				8'b10111011:key<=4'b0101;
				8'b10111101:key<=4'b0110;
				8'b10111110:key<=4'b0111;
				8'b11010111:key<=4'b1000;
				8'b11011011:key<=4'b1001;
				8'b11011101:key<=4'b1010;
				8'b11011110:key<=4'b1011;
				8'b11100111:key<=4'b1100;
				8'b11101011:key<=4'b1101;
				8'b11101101:key<=4'b1110;
				8'b11101110:key<=4'b1111;
		endcase
	end
endmodule
