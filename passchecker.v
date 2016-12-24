module passchecker(buffread, buffout, passed, notpassed, enter,set, kp, password, open, opened);
input [31:0] buffread;
input enter,kp, set, open;
output reg [31:0] buffout;
output reg passed, notpassed, opened;
output reg [31:0] password = 'h15071025;

	always@(kp)
	begin
		//notpassed = 0;
		//opened = 0;
		if (enter)
			begin
				if(buffread == password)
					begin
						passed = 1;
						notpassed = 0;
						opened = 0;
						buffout = 'hccba55cc;
					end
				else
					begin
						passed = 0;
						opened = 0;
						notpassed = 1;
						buffout = 'hccceeccc;
					end
			end
		else if (set)
		begin
			//set password
			//must 8-digit
			if (buffread[3:0]<'ha && buffread[7:4]<'ha && buffread[11:8]<'ha
			&& buffread[15:12]<'ha && buffread[19:16]<'ha && buffread[23:20]<'ha
			&& buffread[27:24]<'ha && buffread[31:28]<'ha)
				begin
					//password = buffread;
					//buffout = password;
					buffout = 'hcc5ecbcc;//--SE-P--
					opened = 1; //for clear display with any key
				end
			else
			begin
				buffout = 'hc5eccd0c; //-SE--No-
				notpassed = 1;
			end
		end
		else if (open)
		begin
			if(passed == 1)
				begin
					opened = 1;
					//passed = 0;
					buffout = 'hCC0bedCC;//open
				end
			else
				begin
					opened = 0;
					notpassed = 1;
					buffout = 'h23333333;
				end
		end
		else
		//any key else
		begin
			opened = 0;
			notpassed = 0;
			buffout = buffread;
		end
	end
	always@(posedge set)
		password = buffread;
		
	
endmodule
