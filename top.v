module top(
	clk_50MHz,
	rst,
	SWC,
	SWR0,
	SWR1,
	SWR2,
	SWR3,
	a,
	b,
	c,
	d,
	e,
	f,
	g,
	ds,
	vpassed,
	vnotpassed,
	vopened
);
input clk_50MHz, rst;
input [3:0] SWC;
output SWR0, SWR1, SWR2, SWR3;
output a, b, c, d, e, f, g;
output [7:0] ds;
output vpassed, vnotpassed, vopened;

wire passed, notpassed, opened;
wire key_pulse, clk_1k;
wire [3:0] key_data;
wire [31:0] led_data;
wire [2:0] led_sel;
wire [3:0] led_display;

assign vpassed=~passed;
assign vnotpassed=~notpassed;
assign vopened=~opened;
//reg [31:0] password;

//parameter password='h15071025;

f_divider (
	.clk_50MHz(clk_50MHz),
	.rst(rst),
	.clk_1kHz(clk_1k)
);


keyboard	(
	.clk(clk_1k),
	.SWC(SWC),
	.SWR0(SWR0),
	.SWR1(SWR1),
	.SWR2(SWR2),
	.SWR3(SWR3),
	.key(key_data)
);

detector	(
	.clk(clk_1k),
	.reset(rst),
	.x(SWC),
	.z(key_pulse)
);

buffer32	(
	.k(key_pulse),
	.input4(key_data),
	.output32(led_data),
	.passed(passed),
	.notpassed(notpassed),
	.opened(opened)
);

multiplexer	(
	.input32(led_data),
	.sel(led_sel),
	.output4(led_display)
);


scanner (
	.rst(rst),
	.clock(clk_1k),
	.ds(ds),
	.sel(led_sel)
);


led (
	.data(led_display),
	.a(a),
	.b(b),
	.c(c),
	.d(d),
	.e(e),
	.f(f),
	.g(g)
);

/*passchecker(
	.buffread(buff),
	.buffout(led_data),
	.passed(passed), 
	.notpassed(notpassed), 
	.enter(enter), 
	.set(set),
	.kp(kp),
	.open(open),
	.opened(opened)
);*/

endmodule
