module Dependency_resolver_and_staller
(
valid_next1,
valid_next2,
enable,

opcode1_ID_RF, 
opcode2_ID_RF,
opcode1_RF_EX, 
opcode2_RF_EX,
PC_OUT_ID_RF,
PC_OUT_RF_EX, 
src1_1_ID_RF,
src2_1_ID_RF,
src1_2_ID_RF,
src2_2_ID_RF,
dest_1_ID_RF,
dest_2_ID_RF,
dest_1_RF_EX,
dest_2_RF_EX,
RA_read,
RB_read,
Valid1_out_ID_RF,
Valid2_out_ID_RF,
Valid1_out_RF_EX,
Valid2_out_RF_EX,
clock,
reset
);

input [15:0] PC_OUT_ID_RF, PC_OUT_RF_EX, RA_read, RB_read;
input [3:0] opcode1_ID_RF, opcode2_ID_RF, opcode1_RF_EX, opcode2_RF_EX, src1_1_ID_RF, src2_1_ID_RF, src1_2_ID_RF, src2_2_ID_RF; 
input [2:0] dest_1_ID_RF, dest_2_ID_RF, dest_1_RF_EX, dest_2_RF_EX;
input Valid1_out_ID_RF, Valid2_out_ID_RF, Valid1_out_RF_EX, Valid2_out_RF_EX, clock, reset;
reg stall_cycle1;
reg [1:0] stall_cycle2;
output reg valid_next1, valid_next2, enable;

wire src_dest_chk1, src_dest_chk2, src_dest_chk3, load_dependency_bw_stages, load_dependency_within_stages;
reg [1:0] inter_stage_dependency_flag;


//assign src_dest_chk1 = ((dest_1_ID_RF == src1_2_ID_RF[2:0]) && src1_2_ID_RF[3] || (dest_1_ID_RF == src2_2_ID_RF[2:0]) && src2_2_ID_RF[3] || 
//		(dest_1_ID_RF == src1_1_decoder[2:0]) && src1_1_decoder[3]|| (dest_1_ID_RF == src2_1_decoder[2:0]) && src2_1_decoder[3] || (dest_1_ID_RF == src1_2_decoder[2:0]) 
//		&& src1_2_decoder[3] || (dest_1_ID_RF == src2_2_decoder[2:0]) && src2_2_decoder[3] || (dest_2_ID_RF == src1_1_decoder[2:0]) && src1_1_decoder[3] || 
//		(dest_2_ID_RF == src2_1_decoder[2:0]) && src2_1_decoder[3] || (dest_2_ID_RF == src1_2_decoder[2:0]) && src1_2_decoder[3]|| (dest_2_ID_RF == src2_2_decoder[2:0]) 
//		&& src2_2_decoder[2:0]) ? 1 : 0;

assign src_dest_chk1 = 	(dest_1_RF_EX == src1_1_ID_RF[2:0]) && src1_1_ID_RF[3] && Valid1_out_ID_RF && Valid1_out_RF_EX || 
									(dest_1_RF_EX == src2_1_ID_RF[2:0]) && src2_1_ID_RF[3] && Valid1_out_ID_RF && Valid1_out_RF_EX ||
									(dest_1_RF_EX == src1_2_ID_RF[2:0]) && src1_2_ID_RF[3] && Valid2_out_RF_EX && Valid1_out_RF_EX ||
									(dest_1_RF_EX == src2_2_ID_RF[2:0]) && src2_2_ID_RF[3] && Valid2_out_RF_EX && Valid1_out_RF_EX ;
									
assign src_dest_chk2 = 	(dest_2_RF_EX == src1_1_ID_RF[2:0]) && src1_1_ID_RF[3] && Valid1_out_ID_RF && Valid2_out_RF_EX || 
									(dest_2_RF_EX == src2_1_ID_RF[2:0]) && src2_1_ID_RF[3] && Valid1_out_ID_RF && Valid2_out_RF_EX ||
									(dest_2_RF_EX == src1_2_ID_RF[2:0]) && src1_2_ID_RF[3] && Valid2_out_RF_EX && Valid2_out_RF_EX ||
									(dest_2_RF_EX == src2_2_ID_RF[2:0]) && src2_2_ID_RF[3] && Valid2_out_RF_EX && Valid2_out_RF_EX ;
									
assign load_dependency_bw_stages = 	
							((opcode1_RF_EX == 4'b0011) || (opcode1_RF_EX == 4'b0100) || (opcode2_RF_EX == 4'b0011) || (opcode2_RF_EX == 4'b0100)) &&
							((opcode1_ID_RF != 4'b0011) && (opcode1_ID_RF != 4'b0100) && (opcode1_ID_RF != 4'b1000) && 
							(opcode2_ID_RF != 4'b0011) && (opcode2_ID_RF != 4'b0100) && (opcode2_ID_RF != 4'b1000));
									 
assign load_dependency_within_stages = 
							((opcode1_ID_RF == 4'b0011) || (opcode1_ID_RF == 4'b0100)) &&
							((opcode2_ID_RF != 4'b0011) && (opcode2_ID_RF != 4'b0100) && (opcode2_ID_RF != 4'b1000));
							
assign src_dest_chk3 = ((dest_1_ID_RF == src1_2_ID_RF[2:0]) && src1_2_ID_RF[3] || (dest_1_ID_RF == src2_2_ID_RF[2:0]) && src2_2_ID_RF[3])
								&& Valid1_out_ID_RF && Valid2_out_ID_RF;

									 
always@(posedge clock)
begin
	
	if(reset)
		inter_stage_dependency_flag <= 2'b00;
	else if(src_dest_chk3 && load_dependency_within_stages && (inter_stage_dependency_flag == 2'b00))
		inter_stage_dependency_flag <= 2'b10;
	else if(src_dest_chk3 && load_dependency_within_stages && (inter_stage_dependency_flag != 2'b00))
		inter_stage_dependency_flag <= inter_stage_dependency_flag - 1;
	else
		inter_stage_dependency_flag <= 2'b00;
end

always@(*)
begin
	
	if(src_dest_chk1 && src_dest_chk2 && load_dependency_bw_stages && ((PC_OUT_ID_RF != PC_OUT_RF_EX))) begin //intra stage load dependency check
		valid_next1 <= 1'b0;
		valid_next2 <= 1'b0;
		enable <= 1'b0; // stall by 1 cycle
	end
	
	else if(src_dest_chk3 && load_dependency_within_stages) begin //LOAD dependency within stages // Stall by 2 cycles
		if (inter_stage_dependency_flag == 2'b00) begin
			valid_next1 <= 1'b1;
			valid_next2 <= 1'b0;
			enable <= 1'b0;
		end
		
		else if (inter_stage_dependency_flag == 2'b10) begin
			valid_next1 <= 1'b0;
			valid_next2 <= 1'b0;
			enable <= 1'b0;
		end
		
		else if (inter_stage_dependency_flag == 2'b01) begin
			valid_next1 <= 1'b0;
			valid_next2 <= 1'b1;
			enable <= 1'b1;
		end
	
	end
	
	else if(((opcode1_ID_RF == 4'b0000) || (opcode1_ID_RF == 4'b0001) || (opcode1_ID_RF == 4'b0010) || (opcode1_ID_RF == 4'b1000) 
	|| (opcode1_ID_RF == 4'b1001)) && 
	((opcode2_ID_RF != 4'b0011) && (opcode2_ID_RF != 4'b0100) && (opcode2_ID_RF != 4'b1000)) && Valid1_out_ID_RF && Valid2_out_ID_RF) 
	// ALU/JAL/JLR-ALU/Store dependency
	begin
		if((((dest_1_ID_RF == src1_2_ID_RF[2:0]) && src1_2_ID_RF[3] )|| (dest_1_ID_RF == src2_2_ID_RF[2:0]) && src2_2_ID_RF[3]) && (PC_OUT_ID_RF != PC_OUT_RF_EX)) begin
			valid_next1 <= 1'b1;
			valid_next2 <= 1'b0;
			enable <= 1'b0;
		end
		else if(((dest_1_ID_RF == src1_2_ID_RF[2:0]) || (dest_1_ID_RF == src2_2_ID_RF[2:0])) && (PC_OUT_ID_RF == PC_OUT_RF_EX)) begin
			valid_next1 <= 1'b0;
			valid_next2 <= 1'b1;
			enable <= 1'b1;
		end
		else begin
			valid_next1 <= 1'b1;
			valid_next2 <= 1'b1;
			enable <= 1'b1;
		end
	end
	
	else begin
		valid_next1 <= 1'b1;
		valid_next2 <= 1'b1;
		enable <= 1'b1;
	end
end
endmodule



