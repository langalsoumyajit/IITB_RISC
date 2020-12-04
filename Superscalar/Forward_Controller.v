module Forward_Controller
(
mux_controller_A,
mux_controller_B,
mux_controller_C,
mux_controller_D,

src1_1_ID_RF,
src2_1_ID_RF,
src1_2_ID_RF,
src2_2_ID_RF,
dest_1_RF_EX,
dest_2_RF_EX,
dest_1_EX_M,
dest_2_EX_M,
dest_1_M_WB,
dest_2_M_WB,
wb_1_RF_EX,
wb_1_EX_M,
wb_1_M_WB,
wb_2_RF_EX,
wb_2_EX_M,
wb_2_M_WB,
valid1_RF_EX,
valid2_RF_EX,
valid1_EX_M,
valid2_EX_M,
valid1_M_WB,
valid2_M_WB
);

output reg [2:0] mux_controller_A, mux_controller_B, mux_controller_C, mux_controller_D;
input [3:0] src1_1_ID_RF, src2_1_ID_RF, src1_2_ID_RF, src2_2_ID_RF, dest_1_RF_EX, dest_2_RF_EX, dest_1_EX_M, dest_2_EX_M, dest_1_M_WB, dest_2_M_WB;
input wb_1_RF_EX, wb_1_EX_M, wb_1_M_WB, wb_2_RF_EX, wb_2_EX_M, wb_2_M_WB, valid1_RF_EX,
valid2_RF_EX, valid1_EX_M, valid2_EX_M, valid1_M_WB, valid2_M_WB;
initial
begin
	mux_controller_A = 3'b000;
	mux_controller_B = 3'b000;
end

always @ (src1_1_ID_RF, dest_1_RF_EX, dest_2_RF_EX, dest_1_EX_M, dest_2_EX_M, dest_1_M_WB, dest_2_M_WB, wb_1_RF_EX, wb_1_EX_M, wb_1_M_WB, wb_2_RF_EX, wb_2_EX_M, wb_2_M_WB)
begin
	if((src1_1_ID_RF[2:0] == dest_1_RF_EX) && src1_1_ID_RF[3] && wb_1_RF_EX && valid1_RF_EX)
		mux_controller_A <= 3'b001;
		
	else if((src1_1_ID_RF[2:0] == dest_2_RF_EX) && src1_1_ID_RF[3] && wb_2_RF_EX && valid2_RF_EX)
		mux_controller_A <= 3'b010;
		
	else if((src1_1_ID_RF[2:0] == dest_1_EX_M) && src1_1_ID_RF[3] && wb_1_EX_M && valid1_EX_M)
		mux_controller_A <= 3'b011;
		
	else if((src1_1_ID_RF[2:0] == dest_2_EX_M) && src1_1_ID_RF[3] && wb_2_EX_M && valid2_EX_M)
		mux_controller_A <= 3'b100;
		
	else if((src1_1_ID_RF[2:0] == dest_1_M_WB) && src1_1_ID_RF[3] && wb_1_M_WB && valid1_M_WB)
		mux_controller_A <= 3'b101;
	
	else if((src1_1_ID_RF[2:0] == dest_2_M_WB) && src1_1_ID_RF[3] && wb_2_M_WB && valid2_M_WB)
		mux_controller_A <= 3'b110;
		
	else
		mux_controller_A <= 3'b000;
end

always @ (src2_1_ID_RF, dest_1_RF_EX, dest_2_RF_EX, dest_1_EX_M, dest_2_EX_M, dest_1_M_WB, dest_2_M_WB, wb_1_RF_EX, wb_1_EX_M, wb_1_M_WB, wb_2_RF_EX, wb_2_EX_M, wb_2_M_WB)
begin
	if((src2_1_ID_RF[2:0] == dest_1_RF_EX) && wb_1_RF_EX && valid1_RF_EX)
		mux_controller_B <= 3'b001;
		
	else if((src2_1_ID_RF[2:0] == dest_2_RF_EX) && src2_1_ID_RF[3] && wb_2_RF_EX && valid2_RF_EX)
		mux_controller_B <= 3'b010;
		
	else if((src2_1_ID_RF[2:0] == dest_1_EX_M) && src2_1_ID_RF[3] && wb_1_EX_M && valid1_EX_M)
		mux_controller_B <= 3'b011;
		
	else if((src2_1_ID_RF[2:0] == dest_2_EX_M) && src2_1_ID_RF[3] && wb_2_EX_M && valid2_EX_M)
		mux_controller_B <= 3'b100;
		
	else if((src2_1_ID_RF[2:0] == dest_1_M_WB) && src2_1_ID_RF[3] && wb_1_M_WB && valid1_M_WB)
		mux_controller_B <= 3'b101;
	
	else if((src2_1_ID_RF[2:0] == dest_2_M_WB) && src2_1_ID_RF[3] && wb_2_M_WB && valid2_M_WB)
		mux_controller_B <= 3'b110;
		
	else
		mux_controller_B <= 3'b000;
end

always @ (src1_2_ID_RF, dest_1_RF_EX, dest_2_RF_EX, dest_1_EX_M, dest_2_EX_M, dest_1_M_WB, dest_2_M_WB, wb_1_RF_EX, wb_1_EX_M, wb_1_M_WB, wb_2_RF_EX, wb_2_EX_M, wb_2_M_WB)
begin
	if((src1_2_ID_RF[2:0] == dest_1_RF_EX) && wb_1_RF_EX && valid1_RF_EX)
		mux_controller_C <= 3'b001;
		
	else if((src1_2_ID_RF[2:0] == dest_2_RF_EX) && src1_2_ID_RF[3] && wb_2_RF_EX && valid2_RF_EX)
		mux_controller_C <= 3'b010;
		
	else if((src1_2_ID_RF[2:0] == dest_1_EX_M) && src1_2_ID_RF[3] && wb_1_EX_M && valid1_EX_M)
		mux_controller_C <= 3'b011;
		
	else if((src1_2_ID_RF[2:0] == dest_2_EX_M) && src1_2_ID_RF[3] && wb_2_EX_M && valid2_EX_M)
		mux_controller_C <= 3'b100;
		
	else if((src1_2_ID_RF[2:0] == dest_1_M_WB) && src1_2_ID_RF[3] && wb_1_M_WB && valid1_M_WB)
		mux_controller_C <= 3'b101;
	
	else if((src1_2_ID_RF[2:0] == dest_2_M_WB) && src1_2_ID_RF[3] && wb_2_M_WB && valid2_M_WB)
		mux_controller_C <= 3'b110;
		
	else
		mux_controller_C <= 3'b000;
end

always @ (src2_2_ID_RF, dest_1_RF_EX, dest_2_RF_EX, dest_1_EX_M, dest_2_EX_M, dest_1_M_WB, dest_2_M_WB, wb_1_RF_EX, wb_1_EX_M, wb_1_M_WB, wb_2_RF_EX, wb_2_EX_M, wb_2_M_WB)
begin
	if((src2_2_ID_RF[2:0] == dest_1_RF_EX) && wb_1_RF_EX && valid1_RF_EX)
		mux_controller_D <= 3'b001;
		
	else if((src2_2_ID_RF[2:0] == dest_2_RF_EX) && src2_2_ID_RF[3] && wb_2_RF_EX && valid2_RF_EX)
		mux_controller_D <= 3'b010;
		
	else if((src2_2_ID_RF[2:0] == dest_1_EX_M) && src2_2_ID_RF[3] && wb_1_EX_M && valid1_EX_M)
		mux_controller_D <= 3'b011;
		
	else if((src2_2_ID_RF[2:0] == dest_2_EX_M) && src2_2_ID_RF[3] && wb_2_EX_M && valid2_EX_M)
		mux_controller_D <= 3'b100;
		
	else if((src2_2_ID_RF[2:0] == dest_1_M_WB) && src2_2_ID_RF[3] && wb_1_M_WB && valid1_M_WB)
		mux_controller_D <= 3'b101;
	
	else if((src2_2_ID_RF[2:0] == dest_2_M_WB) && src2_2_ID_RF[3] && wb_2_M_WB && valid2_M_WB)
		mux_controller_D <= 3'b110;
		
	else
		mux_controller_D <= 3'b000;
end

endmodule