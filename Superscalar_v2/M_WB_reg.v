module M_WB_reg
(
PC_plus1_out_M_WB,
WB_out_M_WB,
Memory_data_read_out_M_WB,
ALU_out,
Zero_pad_out_M_WB,
Dest_out_M_WB,
Valid_out_M_WB,

PC_plus1_in_M_WB,
WB_in_M_WB,
Memory_data_read_in_M_WB,
ALU_in,
Zero_pad_in_M_WB,
Dest_in_M_WB,
Valid_in_M_WB,
clock,
reset,
enable
);

output reg [15:0] PC_plus1_out_M_WB;
output reg [2:0] WB_out_M_WB;
output reg [15:0] ALU_out, Memory_data_read_out_M_WB, Zero_pad_out_M_WB;
output reg [2:0] Dest_out_M_WB;
output reg Valid_out_M_WB;



input [15:0] PC_plus1_in_M_WB;
input [2:0] WB_in_M_WB;
input [15:0] ALU_in, Memory_data_read_in_M_WB, Zero_pad_in_M_WB;
input [2:0] Dest_in_M_WB;
input Valid_in_M_WB;
input clock;
input reset, enable;

initial
begin
	PC_plus1_out_M_WB = 16'b0;
	WB_out_M_WB = 3'b0;
	ALU_out = 16'b0;
	Memory_data_read_out_M_WB =16'b0;
	Zero_pad_out_M_WB = 16'b0;
	Dest_out_M_WB = 3'b0;
	Valid_out_M_WB = 1'b0;
end


always @(posedge clock)
begin
	if(! reset && enable)
	begin
		PC_plus1_out_M_WB <= PC_plus1_in_M_WB;
		WB_out_M_WB <= WB_in_M_WB;
		ALU_out <= ALU_in;
		Memory_data_read_out_M_WB <= Memory_data_read_in_M_WB;
		Zero_pad_out_M_WB <= Zero_pad_in_M_WB;
		Dest_out_M_WB <= Dest_in_M_WB;
		Valid_out_M_WB <= Valid_in_M_WB;
	end
	else if(reset)
	begin
		PC_plus1_out_M_WB <= 16'b0;
		WB_out_M_WB <= 3'b0;
		ALU_out <= 16'b0;
		Memory_data_read_out_M_WB <=16'b0;
		Zero_pad_out_M_WB <= 16'b0;
		Dest_out_M_WB <= 3'b0;
		Valid_out_M_WB <= 1'b0;
	end
end

endmodule