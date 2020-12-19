module bp(clk, rst, br_instr, br_pc, br_pred, old_br_rectify, old_br_result, old_br_pc);

input clk, rst;
input br_instr; //type of instruction 1 when branch type else 0
input [15:0] br_pc; //input branch instruction address
input [15:0] old_br_pc; //input old(previous) branch instruction address
input old_br_rectify; //1 if any previous branch condition is executed now else 0
input old_br_result; //1 if previous branch condition executed is taken else 0


output reg br_pred; //1 for taken 0 for not taken


reg [3:0] bht [7:0]; // 8 locations of 3 bits. MSB(bit 2) is valid bit, (bit 1 and 0) are the 2 bit saturating counter
reg [1:0] temp_reg; // to temporarily store the 2 bit value
integer i;

always @(posedge clk or posedge rst) begin
	if(rst) begin
		for(i=0;i<8;i=i+1) begin
			bht[i] <= 3'b011;
		end
	end
	if(br_instr) begin
		if(bht[br_pc[2:0]][2]) begin
			br_pred <= bht[br_pc[2:0]][1];
		end
		else begin
			bht[br_pc[2:0]][2] <= 1'b1;
			br_pred <= 1'b1;
		end 
	end
	if(old_br_rectify) begin
		temp_reg <= bht[old_br_pc[2:0]][1:0];
		if(old_br_result) begin
			bht[old_br_pc[2:0]][1:0] <= (temp_reg == 2'b11) ? 2'b11 : (temp_reg + 1'b1);
		end
		else begin
			bht[old_br_pc[2:0]][1:0] <= (temp_reg == 2'b00) ? 2'b00 : (temp_reg - 1'b1);
		end
	end
end

endmodule
