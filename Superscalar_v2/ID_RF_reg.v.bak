module ID_RF_reg(
PC_out_ID_RF,
PC_plus1_out_ID_RF,
WB_out_ID_RF,
Memory_out_ID_RF,
Ex_out_ID_RF,
opcode_out,
src1_out_ID_RF,
src2_out_ID_RF,
dest_out_ID_RF,
imm9_out,
imm6_out,
Valid_out_ID_RF,
imm_controller_out,

PC_in_ID_RF,
PC_plus1_in_ID_RF,
WB_in_ID_RF,
Memory_in_ID_RF,
Ex_in_ID_RF,
opcode_in,
src1_in_ID_RF,
src2_in_ID_RF,
dest_in_ID_RF,
imm9_in,
imm6_in,
Valid_in_ID_RF,
imm_controller_in,
clock,
reset
);

output reg [15:0] PC_out_ID_RF;
output reg [15:0] PC_plus1_out_ID_RF;
output reg [2:0] WB_out_ID_RF;
output reg [1:0] Memory_out_ID_RF;
output reg [3:0] Ex_out_ID_RF;
output reg [3:0] src1_out_ID_RF, src2_out_ID_RF;
output reg [2:0] dest_out_ID_RF;
output reg [3:0] opcode_out;
output reg [5:0] imm6_out;
output reg [8:0] imm9_out;
output reg Valid_out_ID_RF, imm_controller_out;


input [15:0] PC_in_ID_RF;
input [15:0] PC_plus1_in_ID_RF;
input [2:0] WB_in_ID_RF;
input [1:0] Memory_in_ID_RF;
input [3:0] Ex_in_ID_RF;
input [3:0] src1_in_ID_RF, src2_in_ID_RF;
input [2:0] dest_in_ID_RF;
input [3:0] opcode_in;
input [8:0] imm9_in;
input [5:0] imm6_in;
input Valid_in_ID_RF, imm_controller_in;
input clock;
input reset;


initial
begin
	PC_out_ID_RF = 16'b0;
	PC_plus1_out_ID_RF = 16'b0;
	WB_out_ID_RF = 3'b0;
	Memory_out_ID_RF = 2'b0;
	Ex_out_ID_RF = 4'b0;
	src1_out_ID_RF = 4'b0;
	src2_out_ID_RF = 4'b0;
	dest_out_ID_RF = 3'b0;
	imm9_out = 9'b0;
	imm6_out = 6'b0;
	opcode_out = 4'b0;
	Valid_out_ID_RF = 1'b0;
	imm_controller_out = 1'b0;
end

always @(posedge clock)
begin
	if(! reset)
		begin
			PC_out_ID_RF <= PC_in_ID_RF;
			PC_plus1_out_ID_RF <= PC_plus1_in_ID_RF;
			WB_out_ID_RF <= WB_in_ID_RF;
			Memory_out_ID_RF <= Memory_in_ID_RF;
			Ex_out_ID_RF <= Ex_in_ID_RF;
			src1_out_ID_RF <= src1_in_ID_RF;
			src2_out_ID_RF <= src2_in_ID_RF;
			dest_out_ID_RF <= dest_in_ID_RF;
			imm9_out <= imm9_in;
			imm6_out <= imm6_in;
			opcode_out <= opcode_in;
			Valid_out_ID_RF <= Valid_in_ID_RF;
			imm_controller_out <= imm_controller_in;
		end
	else
		begin
		
			PC_out_ID_RF <= 16'b0;
			PC_plus1_out_ID_RF <= 16'b0;
			WB_out_ID_RF <= 3'b0;
			Memory_out_ID_RF <= 2'b0;
			Ex_out_ID_RF <= 4'b0;
			src1_out_ID_RF <= 4'b0;
			src2_out_ID_RF <= 4'b0;
			dest_out_ID_RF <= 3'b0;
			imm9_out <= 9'b0;
			imm6_out <= 6'b0;
			opcode_out <= 4'b1111;
			Valid_out_ID_RF <= 1'b0;
			imm_controller_out <= 1'b0;
		end
end

endmodule