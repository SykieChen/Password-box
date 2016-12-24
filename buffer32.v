module buffer32(input4, output32, k, passed, notpassed, opened);
	input [3:0] input4;
	input k;
	output reg [31:0] output32=32'hFFFFFFFF;
	reg [31:0] password=32'h15071025;
	output reg notpassed, passed, opened;
	reg pressClear = 1'b0;
	always@(posedge k)
	begin
		if (input4=='hb && passed)//open
			begin
				opened = 1;
				//passed = 0;
				output32 = 'hCC0bedCC;//open
				pressClear = 1;
			end
		else if (input4=='hc || pressClear)	
			begin
				output32=32'hFFFFFFFF;//clear
				pressClear = 0;
				passed = 0;
				notpassed = 0;
				opened = 0;
			end
		else if (input4=='hd)
			begin
				output32=output32>>4;
				output32=output32 + 32'hF0000000;//backspace
			end
		else if (input4=='hf)
			begin
				//enter = 1; //enter
				pressClear = 1;
				if(output32 == password)
					begin
						passed = 1;
						notpassed = 0;
						opened = 0;
					end
				else
					begin
						passed = 0;
						opened = 0;
						notpassed = 1;

					end
				if (passed) output32 = 'hccba55cc; //passed
				if (notpassed) output32 = 'hccceeccc; //ee
			end
		else if (input4=='he)//set
			begin
			//set = 1; //set
			//set password
			//must 8-digit
				if (output32[3:0]<'ha && output32[7:4]<'ha && output32[11:8]<'ha
					&& output32[15:12]<'ha && output32[19:16]<'ha && output32[23:20]<'ha
					&& output32[27:24]<'ha && output32[31:28]<'ha)
					begin
						password = output32;
						//buffout = password;
						notpassed = 0;
						passed=1;
						pressClear = 1; //for clear display with any key
					end
				else
					begin
						notpassed = 1;
						pressClear = 1;
						passed = 0;
					end
				if (pressClear)
					begin
						if(notpassed) 	output32 = 'hc5eccd0c; //-SE--No-
						if(passed) output32 = 'hcc5ecbcc;//--SE-P--
					end
			end
		else if (input4>='h0 && input4<='h9)
			begin
				output32=output32<<4;
				output32=output32 + input4;
			end
	end
		
endmodule
