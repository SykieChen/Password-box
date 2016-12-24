module detector(clk, x, z, reset);
	// detect for (11111111)
	input clk, reset;
	input [3:0] x;
	output reg z;
	reg[3:0] cur_state, next_state;
	reg sx;
	always@(posedge clk)
		begin
			if(!reset)
				cur_state <= 8;
			else
				cur_state <= next_state;
				
			if (cur_state == 8) z=0;
			else z=1;
			sx = (~x[0] | ~x[1] | ~x[2] | ~x[3]);
			//for x, 0 is pressed, for sx, 1 is pressed
		end

	always@(cur_state or sx)
		begin
			
			case(cur_state)
				0: if(!sx) next_state<=1; else next_state<=0;
				1: if(!sx) next_state<=2; else next_state<=0;
				2: if(!sx) next_state<=3; else next_state<=0;
				3: if(!sx) next_state<=4; else next_state<=0;
				4: if(!sx) next_state<=5; else next_state<=0;
				5: if(!sx) next_state<=6; else next_state<=0;
				6: if(!sx) next_state<=7; else next_state<=0;
				7: if(!sx) next_state<=8; else next_state<=0;
				8: if(!sx) next_state<=8; else next_state<=0;
				default: next_state<=0;
			endcase
		end
endmodule
