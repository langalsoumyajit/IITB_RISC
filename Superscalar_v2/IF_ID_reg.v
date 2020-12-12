module IF_ID_reg
(
PC_plus1_out_IF_ID,
PC_out_IF_ID,
Instruction_out_IF_ID,
Valid_out_IF_ID,
	
PC_plus1_in_IF_ID,
PC_in_IF_ID,
Instruction_in_IF_ID,
Valid_in_IF_ID,
clock,
reset,
enable
);

output reg [15:0] PC_plus1_out_IF_ID,PC_out_IF_ID, Instruction_out_IF_ID;
output reg Valid_out_IF_ID;

input [15:0] Instruction_in_IF_ID, PC_plus1_in_IF_ID, PC_in_IF_ID;
input Valid_in_IF_ID, clock, reset, enable;

initial
begin
	PC_plus1_out_IF_ID = 16'b0;
	Instruction_out_IF_ID = 16'b1111111111111111;
	PC_out_IF_ID = 16'b0;
	Valid_out_IF_ID = 1'b0;
end

always @(posedge clock)
begin
	if(reset) // If reset is enable we need to clear the registers
	begin
		PC_plus1_out_IF_ID <= 16'b0;
		Instruction_out_IF_ID <= 16'b1111111111111111;
		PC_out_IF_ID <= 16'b0;
		Valid_out_IF_ID <= 1'b0;
	end
	else if(enable)
	begin
		PC_plus1_out_IF_ID <= PC_plus1_in_IF_ID;
		PC_out_IF_ID <= PC_in_IF_ID;
		Instruction_out_IF_ID <= Instruction_in_IF_ID;
		Valid_out_IF_ID <= Valid_in_IF_ID;
	end
end
endmodule

 