module Branch_Load_controller
(
mux_controller,
valid,
BP_write_enable,
PC_BP_in,
BTA_BP_in,
H_BP_in,
add_BP_in,
enable1, 
enable2,

IF_ID_src1,
IF_ID_src2,
ID_RF_opcode,
IF_ID_opcode,
ID_RF_dest,
RA_read,
RB_read,
Valid_out_ID_RF,
add_BP_out,
BTA_in_pc_plus_imm,
PC_out_IF_ID,					//INPUT-----------Output from Branch Predictor
PC_out_ID_RF,
count1,
count2,
clock,
reset
);

output reg [1:0] mux_controller;
output reg valid, BP_write_enable, H_BP_in, enable1, enable2;
output reg [15:0] PC_BP_in, BTA_BP_in;
output reg [2:0] add_BP_in;

input [3:0] IF_ID_src1, IF_ID_src2;
input [2:0] ID_RF_dest;
input [3:0] ID_RF_opcode, IF_ID_opcode, add_BP_out;
input [15:0] RA_read, RB_read, BTA_in_pc_plus_imm, PC_out_IF_ID, PC_out_ID_RF;
input Valid_out_ID_RF, clock, reset;


input [1:0] count1;
input [1:0] count2;



initial
begin
	mux_controller = 2'b11;
	valid = 1'b1;
end


always @(IF_ID_src1, IF_ID_src2, ID_RF_dest, ID_RF_opcode, IF_ID_opcode, RA_read, RB_read, 
Valid_out_ID_RF, PC_out_IF_ID, BTA_in_pc_plus_imm, add_BP_out, PC_out_ID_RF, count1, count2)
begin
	case(ID_RF_opcode)
		4'b1100: //BEQ
		begin
			if((RA_read == RB_read) && Valid_out_ID_RF && (PC_out_IF_ID == BTA_in_pc_plus_imm))
			begin
				mux_controller <= 2'b11;
				valid <=1'b1;                
				BP_write_enable <= 1'b0;
				PC_BP_in <= 16'b0;
				BTA_BP_in <= 16'b0;
				H_BP_in <= 1'b0;
				add_BP_in <= 3'b0;
				enable1 <= 1'b0;
				enable2 <= 1'b0;
			end
			
			
			else if((RA_read == RB_read) && Valid_out_ID_RF && (PC_out_IF_ID != BTA_in_pc_plus_imm))
			// No branch no prefetched --> either history bit 0 or PC not available
			begin
				mux_controller <= 2'b01;
				valid <=1'b0;                
				BP_write_enable <= 1'b1;
				PC_BP_in <= PC_out_ID_RF;
				BTA_BP_in <= BTA_in_pc_plus_imm;
				H_BP_in <= 1'b1;
				
				if (add_BP_out[3] == 1'b0)
				begin
					add_BP_in <= {1'b0, count1};
				end
				
				else
				begin
					add_BP_in <= add_BP_out[2:0];
				end
				
				enable1 <= 1'b1;
				enable2 <= 1'b0;
			end
			
			else if((RA_read != RB_read) && Valid_out_ID_RF && (PC_out_IF_ID == BTA_in_pc_plus_imm))	// No branch but prefetched
			begin
				mux_controller <= 2'b10;
				valid <=1'b0;                
				BP_write_enable <= 1'b1;
				PC_BP_in <= PC_out_ID_RF;
				BTA_BP_in <= BTA_in_pc_plus_imm;
				H_BP_in <= 1'b0;
				add_BP_in <= add_BP_out[2:0];
				enable1 <= 1'b0;
				enable2 <= 1'b0;
			end
			
			
			else if((RA_read != RB_read) && Valid_out_ID_RF && (PC_out_IF_ID != BTA_in_pc_plus_imm)) 
			// No branch no prefetched --> either history bit 0 or PC not available
			begin
				mux_controller <= 2'b11;
				valid <=1'b1;                
				BP_write_enable <= 1'b1;
				PC_BP_in <= PC_out_ID_RF;
				BTA_BP_in <= BTA_in_pc_plus_imm;
				H_BP_in <= 1'b0;
				
				if (add_BP_out[3] == 1'b0)
				begin
					add_BP_in <= {1'b0, count1};
				end
				
				else
				begin
					add_BP_in <= add_BP_out[2:0];
				end
				
				enable1 <= 1'b0;
				enable2 <= 1'b0;
			end
			
			else
			begin
				mux_controller <= 2'b11;
				valid <=1'b1;
				BP_write_enable <= 1'b0;
				PC_BP_in <= 16'b0;
				BTA_BP_in <= 16'b0;
				H_BP_in <= 1'b1;
				add_BP_in <= 3'b0;
				enable1 <= 1'b0;
				enable2 <= 1'b0;
			end	
		end
		
		4'b1000: //JAL
		begin
			if(Valid_out_ID_RF && (PC_out_IF_ID == BTA_in_pc_plus_imm))
			begin
				mux_controller <= 2'b11;
				valid <=1'b1;                
				BP_write_enable <= 1'b0;
				PC_BP_in <= 16'b0;
				BTA_BP_in <= 16'b0;
				H_BP_in <= 1'b1;
				add_BP_in <= 3'b0;
				enable1 <= 1'b0;
				enable2 <= 1'b0;
			end
			
			
			else if(Valid_out_ID_RF && (PC_out_IF_ID != BTA_in_pc_plus_imm))
			// No branch no prefetched --> either history bit 0 or PC not available
			begin
				mux_controller <= 2'b01;
				valid <=1'b0;                
				BP_write_enable <= 1'b1;
				PC_BP_in <= PC_out_ID_RF;
				BTA_BP_in <= BTA_in_pc_plus_imm;
				H_BP_in <= 1'b1;
				
				if (add_BP_out[3] == 1'b0)
				begin
					add_BP_in <= {1'b1, count2};
				end
				
				else
				begin
					add_BP_in <= add_BP_out[2:0];
				end
				
				enable1 <= 1'b0;
				enable2 <= 1'b1;
			end
			
			else
			begin
				mux_controller <= 2'b11;
				valid <=1'b1;
				BP_write_enable <= 1'b0;
				PC_BP_in <= 16'b0;
				BTA_BP_in <= 16'b0;
				H_BP_in <= 1'b0;
				add_BP_in <= 3'b0;
				enable1 <= 1'b0;
				enable2 <= 1'b0;
			end	
		end
		
		4'b1001: //JLR
		begin
			if(Valid_out_ID_RF)
			begin
		
				mux_controller <= 2'b00;         // Jump to Reg Location
				valid <=1'b0;
				BP_write_enable <= 1'b0;
				PC_BP_in <= 16'b0;
				BTA_BP_in <= 16'b0;
				H_BP_in <= 1'b0;
				add_BP_in <= 3'b0;
				enable1 <= 1'b0;
				enable2 <= 1'b0;
			end
			
			else
			begin
				mux_controller <= 2'b11;
				valid <=1'b1;
				BP_write_enable <= 1'b0;
				PC_BP_in <= 16'b0;
				BTA_BP_in <= 16'b0;
				H_BP_in <= 1'b0;
				add_BP_in <= 3'b0;
				enable1 <= 1'b0;
				enable2 <= 1'b0;
			end
		end
		
		4'b0011: //LHI
		begin
//			if((IF_ID_opcode == 4'b0000 || IF_ID_opcode == 4'b0001 || IF_ID_opcode == 4'b0010 
//			|| IF_ID_opcode == 4'b0100 || IF_ID_opcode == 4'b0101 || IF_ID_opcode == 4'b1100 || IF_ID_opcode == 4'b1001) && Valid_out_ID_RF) 
//																									//checking load and next instruction dependency
//			begin
//				mux_controller <= 2'b10;
//				valid <=1'b0;
//			end
//			else
//			begin
				mux_controller <= 2'b11;
				valid <=1'b1;
				BP_write_enable <= 1'b0;
				PC_BP_in <= 16'b0;
				BTA_BP_in <= 16'b0;
				H_BP_in <= 1'b0;
				add_BP_in <= 3'b0;
				enable1 <= 1'b0;
				enable2 <= 1'b0;
//			end
		end
		
		4'b0100: //LW
		begin
			if((((IF_ID_src1[2:0] == ID_RF_dest) && (IF_ID_src1[3] == 1'b1)) || ((IF_ID_src2[2:0] == ID_RF_dest) && (IF_ID_src2[3] == 1'b1))) && (IF_ID_opcode == 4'b0000 || IF_ID_opcode == 4'b0001 || IF_ID_opcode == 4'b0010 
			|| IF_ID_opcode == 4'b0101 || IF_ID_opcode == 4'b1100 || IF_ID_opcode == 4'b1001) && Valid_out_ID_RF) //checking load and next instruction dependency
			begin
				mux_controller <= 2'b10;
				valid <=1'b0;
				BP_write_enable <= 1'b0;
				PC_BP_in <= 16'b0;
				BTA_BP_in <= 16'b0;
				H_BP_in <= 1'b0;
				add_BP_in <= 3'b0;
				enable1 <= 1'b0;
				enable2 <= 1'b0;
			end
			else
			begin
				mux_controller <= 2'b11;
				valid <=1'b1;
				BP_write_enable <= 1'b0;
				PC_BP_in <= 16'b0;
				BTA_BP_in <= 16'b0;
				H_BP_in <= 1'b0;
				add_BP_in <= 3'b0;
				enable1 <= 1'b0;
				enable2 <= 1'b0;
			end
		end
		
		default:
		begin
			mux_controller <= 2'b11;
			valid <=1'b1;
			BP_write_enable <= 1'b0;
			PC_BP_in <= 16'b0;
			BTA_BP_in <= 16'b0;
			H_BP_in <= 1'b0;
			add_BP_in <= 3'b0;
			enable1 <= 1'b0;
			enable2 <= 1'b0;
		end
	endcase
end
endmodule



