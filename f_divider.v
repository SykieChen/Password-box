module f_divider(clk_50MHz, rst, m1, m0, clk_1kHz, clk_500Hz, clk_100Hz, clk_1Hz,clk_out);
input clk_50MHz, rst, m1, m0;
output reg clk_1kHz, clk_500Hz, clk_100Hz, clk_1Hz,clk_out;
reg [31:0] N, count_o, count_1k, count_500, count_100, count1;

always@(m1, m0)
	case({m1,m0})
		2'b00: N=100000000;
		2'b01: N=25000000;
		2'b10: N=5000000;
		2'b11: N=1000000;
	endcase
	
always@(posedge clk_50MHz)
begin
	if(!rst)
		begin
			count_o=0;
			count_1k=0;
			count_500=0;
			count_100=0;
			count1=0;
			clk_1kHz=0;
			clk_500Hz=0;
			clk_100Hz=0;
			clk_1Hz=0;
			clk_out=0;
		end
	else
		begin
			if(count_o<=N/2-1)
				count_o<=count_o+1;
			else 
				begin
					count_o<=0;
					clk_out<=~clk_out;
				end
				
			//if(count_1k<=2/2-1)
			if(count_1k<=50000/2-1)
				count_1k<=count_1k+1;
			else
				begin
					count_1k<=0;
					clk_1kHz=~clk_1kHz;
				end
			
			if(count_500<=100000/2-1)
				count_500<=count_500+1;
			else 
				begin
					count_500<=0;
					clk_500Hz<=~clk_500Hz;
				end
			
			if(count_100<=500000/2-1)
				count_100<=count_100+1;
			else 
				begin
					count_100<=0;
					clk_100Hz<=~clk_100Hz;
				end
				
			if(count1<=50000000/2-1)
				count1<=count1+1;
			else 
				begin
					count1<=0;
					clk_1Hz<=~clk_1Hz;
				end
		end
end
endmodule
