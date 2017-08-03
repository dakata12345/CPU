/*
/ Descriere Verilog pentru un set de 4 registre de 8 biti fiecare
*/

module register_file(
	input clk,
	input [1:0] addra,
	input [1:0] addrb,
	input [1:0] addrw,
	input we,
	input [7:0] wd,

	output reg [7:0] a, 
	output reg [7:0] b

    );

reg [7:0] r0;
reg [7:0] r1;
reg [7:0] r2;
reg [7:0] r3;


always @(posedge clk) begin
	if(we & (addrw == 0)) r0 <= wd;
	else r0 <= r0;
	
	if(we & (addrw == 1)) r1 <= wd;
	else r1 <= r1;
	
	if(we & (addrw == 2)) r2 <= wd;
	else r2 <= r2;
	
	if(we & (addrw == 3)) r3 <= wd;
	else r3 <= r3;

	
	
end

//multiplexor de citire pentru iesirea a
always @(*)
	case(addra)
		0: a = r0;
		1: a = r1;
		2: a = r2;
		3: a = r3;
	endcase

//multiplexor de citire pentru iesirea b
always @(*)
	case(addrb)
		0: b = r0;
		1: b = r1;
		2: b = r2;
		3: b = r3;
	endcase

	
endmodule



