module RF_EX_reg
(
PC_plus1_out_RF_EX,
WB_out_RF_EX,
Memory_out_RF_EX,
Ex_out_RF_EX,
src1_out_RF_EX,
src2_out_RF_EX,
RA_data_out,
RB_data_out,
RB_direct_data_out,
SE16_out_RF_EX,
Zero_pad_out_RF_EX,
Dest_out_RF_EX,
Valid_out_RF_EX,

PC_plus1_in_RF_EX,
WB_in_RF_EX,
Memory_in_RF_EX,
Ex_in_RF_EX,
src1_in_RF_EX,
src2_in_RF_EX,
RA_data_in,
RB_data_in,
RB_direct_data_in,
SE16_in_RF_EX,
Zero_pad_in_RF_EX,
Dest_in_RF_EX,
Valid_in_RF_EX,
clock,
reset
);

output reg [15:0] PC_plus1_out_RF_EX;
output reg [2:0] WB_out_RF_EX;
output reg [1:0] Memory_out_RF_EX;
output reg [3:0] Ex_out_RF_EX;
output reg [3:0] src1_out_RF_EX, src2_out_RF_EX;
output reg [15:0] RA_data_out, RB_data_out, RB_direct_data_out, SE16_out_RF_EX, Zero_pad_out_RF_EX;
output reg [2:0] Dest_out_RF_EX;
output reg Valid_out_RF_EX;



input [15:0] PC_plus1_in_RF_EX;
input [2:0] WB_in_RF_EX;
input [1:0] Memory_in_RF_EX;
input [3:0] Ex_in_RF_EX;
input [3:0] src1_in_RF_EX, src2_in_RF_EX;
input [15:0] RA_data_in, RB_data_in, RB_direct_data_in, SE16_in_RF_EX, Zero_pad_in_RF_EX;
input [2:0] Dest_in_RF_EX;
input Valid_in_RF_EX;
input clock;
input reset;

initial
begin
	PC_plus1_out_RF_EX = 16'b0;
	WB_out_RF_EX = 3'b0;
	Memory_out_RF_EX = 2'b0;
	Ex_out_RF_EX = 4'b0;
	src1_out_RF_EX = 4'b0;
	src2_out_RF_EX = 4'b0;
	RA_data_out = 16'b0;
	RB_data_out = 16'b0;
	RB_direct_data_out = 16'b0;
	SE16_out_RF_EX = 16'b0;
	Zero_pad_out_RF_EX = 16'b0;
	Dest_out_RF_EX = 3'b0;
	Valid_out_RF_EX = 1'b0;
end

always @(posedge clock)
begin
	if(! reset)
		begin
			PC_plus1_out_RF_EX <= PC_plus1_in_RF_EX;
			WB_out_RF_EX <= WB_in_RF_EX;
			Memory_out_RF_EX <= Memory_in_RF_EX;
			Ex_out_RF_EX <= Ex_in_RF_EX;
			src1_out_RF_EX <= src1_in_RF_EX;
			src2_out_RF_EX <= src2_in_RF_EX;
			RA_data_out <= RA_data_in;
			RB_data_out <= RB_data_in;
			RB_direct_data_out <= RB_direct_data_in;
			SE16_out_RF_EX <= SE16_in_RF_EX;
			Zero_pad_out_RF_EX <= Zero_pad_in_RF_EX;
			Dest_out_RF_EX <= Dest_in_RF_EX;
			Valid_out_RF_EX <= Valid_in_RF_EX;
		end
	else
		begin
			PC_plus1_out_RF_EX <= 16'b0;
			WB_out_RF_EX <= 3'b0;
			Memory_out_RF_EX <= 2'b0;
			Ex_out_RF_EX <= 4'b0;
			src1_out_RF_EX <= 4'b0;
			src2_out_RF_EX <= 4'b0;
			RA_data_out <= 16'b0;
			RB_data_out <= 16'b0;
			RB_direct_data_out = 16'b0;
			SE16_out_RF_EX <= 16'b0;
			Zero_pad_out_RF_EX <= 16'b0;
			Dest_out_RF_EX <= 3'b0;
			Valid_out_RF_EX <= 1'b0;
		end
end

endmodule