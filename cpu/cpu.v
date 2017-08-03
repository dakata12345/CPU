module cpu(
	input clk,
	input reset,
	input [8:0] instruction,
	output [7:0] instruction_address,

	output [7:0] data_address,
	output [7:0] write_data,
	output write_enable,
	
	input [7:0] read_data

    );

//fire pentru interconectare
wire [2:0] alu_operation_select;
wire [1:0] register_file_adr_dest;
wire [1:0] register_file_adr_a;
wire [1:0] register_file_adr_b;
wire register_file_we;
wire jump_enable;
wire writeback_select_read_or_alu;

wire [7:0] operand_a;
wire [7:0] operand_b;
wire [7:0] alu_result;
wire [7:0] register_file_writeback_data;

wire pc_preload_enable;

instr_decode dcd(
	.instr(instruction),
	.wr_sel_alu_or_read(writeback_select_read_or_alu),
	.alu_sel(alu_operation_select),
   .adr_dest(register_file_adr_dest),
	.adr_operand_b(register_file_adr_b),
	.adr_operand_a(register_file_adr_a),
	.write_register_file(register_file_we),
	.jump_enable(jump_enable)
);

preload_counter pc(
	.clk(clk),
	.pen(pc_preload_enable),
	.reset(reset),
	.pdata(operand_a),
	.q(instruction_address)
);

jmpctrl jctr(
	.jmpen(jump_enable),
	.testsgn(operand_b),
	.preload_en(pc_preload_enable)
);

register_file rf(
	.clk(clk),
	.addra(register_file_adr_a),
	.addrb(register_file_adr_b),
	.addrw(register_file_adr_dest),
	.we(register_file_we),
	.wd(register_file_writeback_data),

	.a(operand_a),
	.b(operand_b)

);

alu alu(
	.a(operand_a),
	.b(operand_b),
	.sel(alu_operation_select),
	.r(alu_result)
);

assign register_file_writeback_data = !writeback_select_read_or_alu ? alu_result : read_data;



endmodule
