module Instruction_decoder(
WB,
Memory,
EX,
src1,
src2,
dest,
imm9,
imm6,
imm_controller,

Instruction
);

output reg [2:0] WB;
output reg [1:0] Memory;
output reg [3:0] EX;
output reg [3:0] src1, src2;
output reg [2:0] dest;
output reg [8:0] imm9;
output reg [5:0] imm6;
output reg imm_controller;

initial
begin
	WB = 3'b000;
end

input [15:0] Instruction;
wire [1:0] condition;
assign condition = Instruction[1:0];

wire [3:0] opcode;
assign opcode = Instruction[15:12];

always@(opcode, condition, Instruction)
begin
	case(opcode)
		4'b0000:                             //ADD
		begin
			WB <= 3'b110;
			Memory <= 2'b00;
			EX[3] <= 1'b0;
			src1 <= {1'b1, Instruction[11:9]};
			src2 <= {1'b1, Instruction[8:6]};
			dest <= Instruction[5:3];
			imm6 <= Instruction[5:0];
			imm9 <= Instruction[8:0];
			imm_controller <= 1'b0;
				if(condition == 2'b00)         //ADD
					EX[2:0] <= 3'b000;	
				else if (condition == 2'b10)   //ADC
					EX[2:0] <= 3'b001;
				else if (condition == 2'b01)   //ADZ
					EX[2:0] <= 3'b010;
				else
					EX[2:0] <= 3'bzzz;
		end
		
		4'b0001: //ADDI
		begin
			WB <= 3'b110;
			Memory <= 2'b00;
			EX <= 4'b1011;
			src1 <= {1'b1, Instruction[11:9]};
			src2 <= {1'b0, Instruction[8:6]};  //Dont care
			dest <= Instruction[8:6];  // Reg B is the destination
			imm6 <= Instruction[5:0];
			imm9 <= Instruction[8:0];
			imm_controller <= 1'b1;
		end
		
		4'b0010: //NAND
		begin
			WB <= 3'b110;
			Memory <= 2'b00;
			EX[3] <= 1'b0;
			src1 <= {1'b1, Instruction[11:9]};
			src2 <= {1'b1, Instruction[8:6]};
			dest <= Instruction[5:3];
			imm6 <= Instruction[5:0];
			imm9 <= Instruction[8:0];
			imm_controller <= 1'b0;
			
				if(condition == 2'b00) 
					EX[2:0] <= 3'b100;	
				else if (condition == 2'b10) 
					EX[2:0] <= 3'b101;
				else if (condition == 2'b01) 
					EX[2:0] <= 3'b110;
				else
					EX[2:0] <= 3'bzzz;
		end
		
		4'b0011: //LHI
		begin
			WB <= 3'b111;
			Memory <= 2'b00;
			EX <= 4'b1111;
			
			src1 <= {1'b0, Instruction[11:9]}; //Dontcare
			src2 <= {1'b0, Instruction[8:6]};  //Dontcare
			dest <= Instruction[11:9]; // Reg A is destination
			imm6 <= Instruction[5:0];
			imm9 <= Instruction[8:0];
			imm_controller <= 1'b0;
		end
		
		4'b0100: //LW
		begin
			WB <= 3'b100;
			Memory <= 2'b10;
			EX <= 4'b1011;
			
			src1 <= {1'b1, Instruction[11:9]};		// 1 source
			src2 <= {1'b0, Instruction[11:9]};  	// Dontcare
			dest <= Instruction[8:6]; 		//Reg A destination
			imm6 <= Instruction[5:0];
			imm9 <= Instruction[8:0];
			imm_controller <= 1'b0;
		end
		
		4'b0101: //SW
		begin
			WB <= 3'b000;
			Memory <= 2'b01;
			EX <= 4'b1011;
			
			src1 <= {1'b1, Instruction[11:9]};		// Source 1
			src2 <= {1'b1, Instruction[8:6]};	  	// Source 2
			dest <= Instruction[8:6]; 				// Dontcare
			imm6 <= Instruction[5:0];
			imm9 <= Instruction[8:0];
			imm_controller <= 1'b0;
		end
		
		4'b1100: //BEQ
		begin
			WB <= 3'b000;
			Memory <= 2'b00;
			EX <= 4'b0000;
			
			src1 <= {1'b1, Instruction[11:9]}; //src1
			src2 <= {1'b1, Instruction[8:6]};  //src2
			dest <= Instruction[11:9]; // Dontcare
			imm6 <= Instruction[5:0];
			imm9 <= Instruction[8:0];
			imm_controller <= 1'b0;
		end
		
		4'b1000: //JAL
		begin
			WB <= 3'b101;
			Memory <= 2'b00;
			EX <= 4'b0000;
			
			src1 <= {1'b0, Instruction[11:9]}; //Dontcare
			src2 <= {1'b0, Instruction[8:6]};  //Dontcare
			dest <= Instruction[11:9]; // Reg A is destination
			imm6 <= Instruction[5:0];
			imm9 <= Instruction[8:0];
			imm_controller <= 1'b1;
		end
		
		4'b1001: //JLR
		begin
			WB <= 3'b101;
			Memory <= 2'b00;
			EX <= 4'b0000;
			
			src1 <= {1'b0, Instruction[11:9]}; //Dontcare
			src2 <= {1'b1, Instruction[8:6]};  // Source
			dest <= Instruction[11:9]; // Reg A is destination
			imm6 <= Instruction[5:0];
			imm9 <= Instruction[8:0];
			imm_controller <= 1'b0;
		end
		default :
			begin
			WB <= 3'b000;
			Memory <= 2'b00;
			EX <= 4'b1111;
			
			src1 <= {1'b0, Instruction[11:9]}; //Dontcare
			src2 <= {1'b1, Instruction[8:6]};  
			dest <= Instruction[11:9]; // Reg A is destination
			imm6 <= Instruction[5:0];
			imm9 <= Instruction[8:0];
			imm_controller <= 1'b0;
		end
		
	endcase
end
endmodule