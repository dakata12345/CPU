

module preload_counter(
	input clk,
	input pen,
	input reset,
	input [7:0] pdata,
	output reg [7:0] q //);

always @(posedge clk) begin 
		if(~reset) q <= 0;
	else begin
		if(pen) q <= pdata;
		else    q <= q+1;
	end
end

endmodule



