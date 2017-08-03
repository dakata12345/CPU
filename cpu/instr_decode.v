module instr_decode(
	input [8:0] instr,
	output reg wr_sel_alu_or_read,
	output reg [2:0] alu_sel,
   output [1:0] adr_dest,
	output [1:0] adr_operand_b,
	output  [1:0] adr_operand_a,
	output reg write_register_file,
	output reg jump_enable
    );

assign adr_dest = instr[5:4];
assign adr_operand_b = instr[1:0];
assign adr_operand_a = instr[3:2];

always@(instr[8:6]) 
	case(instr[8:6])
		0/*ADD*/: begin
				wr_sel_alu_or_read = 1'b0;
				alu_sel = 2'd0;
				write_register_file = 1'b1;
				jump_enable = 1'b0;
			end
		1/*SUB*/: begin
				wr_sel_alu_or_read = 1'b0;
				alu_sel = 2'd1;
				write_register_file = 1'b1;
				jump_enable = 1'b0;
			end
		2/*AND*/: begin
			wr_sel_alu_or_read = 1'b0;
			alu_sel = 2'd2;
			write_register_file = 1'b1;
			jump_enable = 1'b0;
		end
		3/*OR*/: begin
			wr_sel_alu_or_read = 1'b0;
			alu_sel = 3'd3;
			write_register_file = 1'b1;
			jump_enable = 1'b0;
		end
		4/*JMPZ*/: begin
			wr_sel_alu_or_read = 1'b0;//nu conteaza
			alu_sel = 3'd0;//nu conteaza
			write_register_file = 1'b0;
			jump_enable = 1'b1;
		end
		5/*MOV*/: begin
			wr_sel_alu_or_read = 1'b0;
			alu_sel = 3'd4;//Ra trece nemodificat prin ALU
			write_register_file = 1'b1;
			jump_enable = 1'b0;
		end
		6/*LOAD*/: begin
			wr_sel_alu_or_read = 1'b1;
			alu_sel = 2'd0;//nu conteaza
			write_register_file = 1'b1;
			jump_enable = 1'b0;
		end
		7/*SAVE*/: begin
			wr_sel_alu_or_read = 1'b1;//trebuie sa fie 1 pentru ca 
											  //WEN catre memoria de date e conectat la
											  //wr_sel_alu_or_read
			alu_sel = 2'd0;//nu conteaza
			write_register_file = 1'b0;
			jump_enable = 1'b0;
		end
		endcase

endmodule
