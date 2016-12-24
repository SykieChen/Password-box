module scanner(rst, clock, ds, sel);
input wire	rst;
input wire	clock;
output wire	[7:0] ds;
output wire	[2:0] sel;
wire rst_t, rst_o, rst_c;
assign	rst_c = sel[0] & sel[1] & sel[2];
assign	rst_o = ~rst;
assign	rst_t = ~(rst_c | rst_o);
\74162 (
	.ENP(1),
	.ENT(1),
	.CLRN(rst_t),
	.CLK(clock),
	.QA(sel[0]),
	.QB(sel[1]),
	.QC(sel[2])
);
\74138 	(
	.A(sel[0]),
	.B(sel[1]),
	.C(sel[2]),
	.G1(1),
	.G2AN(0),
	.G2BN(0),
	.Y0N(ds[7]),
	.Y1N(ds[6]),
	.Y2N(ds[5]),
	.Y3N(ds[4]),
	.Y4N(ds[3]),
	.Y5N(ds[2]),
	.Y6N(ds[1]),
	.Y7N(ds[0])
);

endmodule
