module Branch_controller
(
mux_controller,
valid_previous,
valid_next1,
valid_next2,
imm_control,// Needed for BEQ and JAL instructions


opcode1, 
opcode2, 
src1_1_ID_RF,
src2_1_ID_RF,
src1_2_ID_RF,
src2_2_ID_RF,
dest_1_ID_RF,
dest_2_ID_RF,
RA_read1,
RB_read1,
RA_read2,
RB_read2,
Valid1_out_ID_RF,
Valid2_out_ID_RF,
clock,
reset
);

output reg [1:0] mux_controller;

input [15:0] RA_read1, RB_read1, RA_read2, RB_read2;
input [3:0] opcode1, opcode2, src1_1_ID_RF, src2_1_ID_RF, src1_2_ID_RF, src2_2_ID_RF; 
input [2:0] dest_1_ID_RF, dest_2_ID_RF;
input Valid1_out_ID_RF, Valid2_out_ID_RF, clock, reset;
output reg valid_previous, valid_next1, valid_next2;
output reg [1:0] imm_control;


//
//initial
//begin
//	mux_controller = 2'b11;
//	valid = 1'b1;
//end


always @(*)
begin
	if((opcode1 == 4'b1100) && ((opcode2 != 4'b1000) && (opcode2 != 4'b1001) && (opcode2 != 4'b1100)) && Valid1_out_ID_RF && Valid2_out_ID_RF)
	//1. BEQ 2. ALU/LS 
	begin
		if(RA_read1 == RB_read1)
		begin
			
			mux_controller <= 2'b01;
			valid_next1 <= 1'b1;
			valid_next2 <= 1'b0;
			valid_previous <= 1'b0; 
			imm_control <= 2'b00;
		end
		else
		begin
			
			mux_controller <= 2'b11;
			valid_next1 <= 1'b1;
			valid_next2 <= 1'b1; 
			valid_previous <= 1'b1; 
			imm_control <= 2'b00;
		end
	end		
			
	else if((opcode1 == 4'b1100) && ((opcode2 == 4'b1000) || (opcode2 == 4'b1001) || 
	(opcode2 == 4'b1100)) && Valid1_out_ID_RF && Valid2_out_ID_RF) //1. BEQ 2. JLR/JAL/BEQ
	begin
		if(RA_read1 == RB_read1)
		begin
			
			mux_controller <= 2'b01;
			valid_next1 <= 1'b1;
			valid_next2 <= 1'b0;  
			valid_previous <= 1'b0; 
			imm_control <= 2'b00;
		end
		
		else
		begin
			if (opcode2 == 4'b1001) 
			begin
				mux_controller <= 2'b10;
				valid_next1 <= 1'b1;
				valid_next2 <= 1'b1; 
				valid_previous <= 1'b0; 
				imm_control <= 2'b0;
			end
			else if (opcode2 == 4'b1000) 
			begin
				mux_controller <= 2'b01;
				valid_next1 <= 1'b1;
				valid_next2 <= 1'b1; 
				valid_previous <= 1'b0; 
				imm_control <= 2'b11;
			end
			
			else if (opcode2 == 4'b1100) 
			begin
				if(RA_read2 == RB_read2)
				begin
			
					mux_controller <= 2'b01;
					valid_next1 <= 1'b1;
					valid_next2 <= 1'b1;  
					valid_previous <= 1'b0;
					imm_control <= 2'b10;	
				end
				else
				begin
					mux_controller <= 2'b11;
					valid_next1 <= 1'b1;
					valid_next2 <= 1'b1;
					valid_previous <= 1'b1; 
					imm_control <= 2'b0;
				end	
			end
			else
			begin
				mux_controller <= 2'b11;
				valid_next1 <= 1'b1;
				valid_next2 <= 1'b1;
				valid_previous <= 1'b1; 
				imm_control <= 2'b0;
			end
		end
		
	end
	
	else if(((opcode1 == 4'b1000) || (opcode1 == 4'b1001)) && Valid1_out_ID_RF && Valid2_out_ID_RF) //1. JLR/JAL
	begin
		
		if (opcode1 == 4'b1001) 
		begin
			mux_controller <= 2'b01;
			valid_next1 <= 1'b1;
			valid_next2 <= 1'b0; 
			valid_previous <= 1'b0;
			imm_control <= 2'b0;
		end
		else if (opcode1 == 4'b1000) 
		begin
			mux_controller <= 2'b01;
			valid_next1 <= 1'b1;
			valid_next2 <= 1'b0;  
			valid_previous <= 1'b0; 
			imm_control <= 2'b01;
		end
		else
		begin
			mux_controller <= 2'b11;
			valid_next1 <= 1'b1;
			valid_next2 <= 1'b1;
			valid_previous <= 1'b1; 
			imm_control <= 2'b0;
		end
			
	end
	
	else if(((opcode1 != 4'b1000) && (opcode1 != 4'b1001) && (opcode1 != 4'b1100)) && 
	((opcode2 == 4'b1000) || (opcode2 == 4'b1001) || (opcode2 == 4'b1100))
	&& Valid1_out_ID_RF && Valid2_out_ID_RF) //1. ALU/LOAD 2. JLR/JAL/BEQ
	begin
		
		if (opcode2 == 4'b1001) 
		begin
			mux_controller <= 2'b10;
			valid_next1 <= 1'b1;
			valid_next2 <= 1'b1;
			valid_previous <= 1'b0; 
			imm_control <= 2'b0;
		end
		else if (opcode2 == 4'b1000) 
		begin
			mux_controller <= 2'b01;
			valid_next1 <= 1'b1;
			valid_next2 <= 1'b1; 
			valid_previous <= 1'b0;
			imm_control <= 2'b11;
		end
		else if (opcode2 == 4'b1100) 
		begin
			if(RA_read2 == RB_read2)
			begin
		
				mux_controller <= 2'b01;
				valid_next1 <= 1'b1;
				valid_next2 <= 1'b1;  
				valid_previous <= 1'b0;
				imm_control <= 2'b10;	
			end
			else
			begin
				mux_controller <= 2'b11;
				valid_next1 <= 1'b1;
				valid_next2 <= 1'b1;
				valid_previous <= 1'b1; 
				imm_control <= 2'b0;
			end	
		end
		else
		begin
			mux_controller <= 2'b11;
			valid_next1 <= 1'b1;
			valid_next2 <= 1'b1;
			valid_previous <= 1'b1; 
			imm_control <= 2'b0;
		end	
		
	end
	
	else
	begin
		mux_controller <= 2'b11;
		valid_next1 <= 1'b1;
		valid_next2 <= 1'b1;
		valid_previous <= 1'b1; 
		imm_control <= 2'b0;
	end	
			
			
	
end
endmodule



