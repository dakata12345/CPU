
module alu(
	input [7:0] a,
	input [7:0] b,
	input [2:0] sel,
	output reg [7:0] r
    );


always@(*)
	case(sel)
		0: r = a+b;
		1: r = a-b;
		2: r = a&b;
		3: r = a|b;
		4: r = a;
		default: r = a|b;
	endcase

endmodule
