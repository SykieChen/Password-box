module chk(
	clk_50MHz,
	rst,
	key_pulse, clk_1k,
	enter, set, kp,
	key_data, led_data, buff,
	vpassed,
	vnotpassed,
	password
);
input clk_50MHz, rst;

output vpassed, vnotpassed;

wire passed, notpassed;
input key_pulse, clk_1k;
output enter, set, kp;
input [3:0] key_data;
output [31:0] led_data, buff, password;

assign vpassed=~passed;
assign vnotpassed=~notpassed;
//reg [31:0] password;

//parameter password='h15071025;


buffer32	(
	.k(key_pulse),
	.input4(key_data),
	.output32(buff),
	.passed(passed),
	.notpassed(notpassed),
	.enter(enter), 
	.set(set),
	.kp(kp)
);


passchecker(
	.buffread(buff),
	.buffout(led_data),
	.passed(passed), 
	.notpassed(notpassed), 
	.enter(enter), 
	.set(set),
	.kp(kp),
	.password(password)
);

endmodule
