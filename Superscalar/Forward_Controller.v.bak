module Forward_Controller
(
mux_controller_A,
mux_controller_B,

src1_ID_RF,
src2_ID_RF,
dest_RF_EX,
dest_EX_M,
dest_M_WB,
wb_RF_EX,
wb_EX_M,
wb_M_WB
);

output reg [1:0] mux_controller_A, mux_controller_B;
input [2:0] src1_ID_RF, src2_ID_RF, dest_RF_EX, dest_EX_M, dest_M_WB;
input wb_RF_EX, wb_EX_M, wb_M_WB;

initial
begin
	mux_controller_A = 2'b00;
	mux_controller_B = 2'b00;
end

always @ (src1_ID_RF, dest_RF_EX, dest_EX_M, dest_M_WB, wb_RF_EX, wb_EX_M, wb_M_WB)
begin
	if(src1_ID_RF == dest_RF_EX && wb_RF_EX)
		mux_controller_A <= 2'b01;
		
	else if(src1_ID_RF == dest_EX_M && wb_EX_M)
		mux_controller_A <= 2'b10;
		
	else if(src1_ID_RF == dest_M_WB && wb_M_WB)
		mux_controller_A <= 2'b11;
		
	else
		mux_controller_A <= 2'b00;
end

always @ (src2_ID_RF, dest_RF_EX, dest_EX_M, dest_M_WB, wb_RF_EX, wb_EX_M, wb_M_WB)
begin
	if(src2_ID_RF == dest_RF_EX && wb_RF_EX)
		mux_controller_B <= 2'b01;
		
	else if(src2_ID_RF == dest_EX_M && wb_EX_M)
		mux_controller_B <= 2'b10;
		
	else if(src2_ID_RF == dest_M_WB && wb_M_WB)
		mux_controller_B <= 2'b11;
		
	else
		mux_controller_B <= 2'b00;
end

endmodule