
module jmpctrl(
	input jmpen,
	input [7:0] testsgn,
	output preload_en
    );

assign preload_en = jmpen & (testsgn == 0);

//always@* preload_en = jmpen & (testsgn == 0); //daca output preload_en e declarat reg

endmodule
