module CPU(clock, reset);

//output [15:0] data_write_output;
//output [15:0] mux_out, inst_bus, mux_instance2_2to1_out, alu_zero_pad_out_mux;
//output [2:0] WB, WB_out_ID_RF, WB_out_RF_EX;



input clock, reset;
//output [15:0] data_write;

wire [15:0] mux_out, pc_out, inst_bus, pc_plus_one, BTA_out, out_pc, PC_BP_in, BTA_BP_in, BTA_BP_out_delayed;


wire [2:0] WB, add_BP_in;
wire [1:0] Memory, count1, count2;
wire [3:0] EX;
wire [3:0] src1, src2, add_BP_out;
wire [2:0] dest;
wire [8:0] imm9;
wire [5:0] imm6;

wire [15:0] PC_plus1_out_IF_ID, PC_out_IF_ID, Instruction_out_IF_ID;
wire Valid_in, Valid_out_IF_ID, H_BP_in, enable1, enable2, PC_mux_sel, BP_write_enable, H_BP_out; 

wire imm_controller;

wire [15:0] PC_out_ID_RF;
wire [15:0] PC_plus1_out_ID_RF;
wire [2:0] WB_out_ID_RF;
wire [1:0] Memory_out_ID_RF;
wire [3:0] Ex_out_ID_RF;
wire [3:0] src1_out_ID_RF, src2_out_ID_RF;
wire [2:0] dest_out_ID_RF;
wire [3:0] opcode_out;
wire [5:0] imm6_out;
wire [8:0] imm9_out;
wire Valid_out_ID_RF, imm_controller_out;
wire Valid_in_and_gate;

wire [15:0] data_read0, data_read1, data_write;

wire [15:0] out_16_9bit, out_16_6bit, out_16_zero_padder;

wire [15:0] out_data;

wire [15:0] PC_out_mux_in;

wire [1:0] select_from_BL_controller;

wire [15:0] PC_plus1_out_RF_EX;
wire [2:0] WB_out_RF_EX;
wire [1:0] Memory_out_RF_EX;
wire [3:0] Ex_out_RF_EX;
wire [3:0] src1_out_RF_EX, src2_out_RF_EX;
wire [15:0] RA_data_out, RB_data_out, RB_direct_data_out, SE16_out_RF_EX, Zero_pad_out_RF_EX;
wire [2:0] Dest_out_RF_EX;
wire Valid_out_RF_EX;

wire [15:0] mux_instance2_4to1_out, mux_instance3_4to1_out, mux_instance2_2to1_out;
wire [15:0] alu_out_EX, alu_zero_pad_out_mux;

wire [1:0] mux_controller_A, mux_controller_B;

wire [15:0] PC_plus1_out_EX_M;
wire [2:0] WB_out_EX_M;
wire [1:0] Memory_out_EX_M;
wire [15:0] ALU_out_EX_M, Memory_data_write_out_EX_M, Zero_pad_out_EX_M, alu_mem_data_read_out_mux;
wire [2:0] Dest_out_EX_M;
wire Valid_out_EX_M;

wire [15:0] data_bus_read;
wire and1_output;

wire [15:0] PC_plus1_out_M_WB;
wire [2:0] WB_out_M_WB;
wire [15:0] ALU_out_M_WB, Memory_data_read_out_M_WB, Zero_pad_out_M_WB;
wire [2:0] Dest_out_M_WB;
wire Valid_out_M_WB;

wire reg_write_enable;


// IF stage------------------------------------------------
//=======================================================//

mux2to1_16bit mux2to1_16bit_instance5(out_pc, mux_out, BTA_BP_out_delayed, PC_mux_sel);

BP_Controller BP_Controller_instance(PC_mux_sel, BTA_out, H_BP_out, clock, reset);

PC pc_instance(pc_out, out_pc, clock, reset);

inst_memory inst_memory_instance(inst_bus,pc_out,reset,clock);

PC_Incrementer pc_incrementer_instance(pc_plus_one, pc_out, reset, clock);

BranchPredictor BranchPredictor_instance(add_BP_out, BTA_out, BTA_BP_out_delayed, H_BP_out, 
add_BP_in, PC_BP_in, BTA_BP_in, H_BP_in, mux_out, clock, reset, BP_write_enable);

Branch_Predictor_address_counter counter1(count1, clock, reset, enable1);

Branch_Predictor_address_counter counter2(count2, clock, reset, enable2);

// ID stage ==============================================
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++

                     //Wire from controller

IF_ID_reg if_id_reg_instance(PC_plus1_out_IF_ID, PC_out_IF_ID, Instruction_out_IF_ID, Valid_out_IF_ID,
 pc_plus_one, pc_out, inst_bus, Valid_in, clock, reset );




Instruction_decoder instruction_decoder_instance(WB, Memory, EX, src1, src2, dest, imm9, imm6, imm_controller, Instruction_out_IF_ID);

// RF Stage ==============================================
//+++++++++++++++++++++++++++++++-----------++++++++++++++




and and_instance3(Valid_in_and_gate, Valid_in, Valid_out_IF_ID);


ID_RF_reg id_RF_reg_instance(PC_out_ID_RF, PC_plus1_out_ID_RF, WB_out_ID_RF, Memory_out_ID_RF, Ex_out_ID_RF, opcode_out, src1_out_ID_RF,
src2_out_ID_RF, dest_out_ID_RF, imm9_out, imm6_out, Valid_out_ID_RF,imm_controller_out,

PC_out_IF_ID, PC_plus1_out_IF_ID, WB, Memory, EX,
Instruction_out_IF_ID[15:12], src1, src2, dest, imm9, imm6,
Valid_in_and_gate, imm_controller, clock,reset);



RegisterFile registerFile_instance(data_read0, data_read1, 
data_write, src1_out_ID_RF[2:0], src2_out_ID_RF[2:0], Dest_out_M_WB, clock, reset, reg_write_enable);



Sign_Extenter_9bit sign_Extenter_9bit_instance (out_16_9bit, imm9_out);

Sign_Extenter_6bit sign_Extenter_6bit_instance (out_16_6bit, imm6_out);

Zero_Padder_9bit zero_Padder_9bit_instance(out_16_zero_padder, imm9_out);



mux2to1_16bit mux2to1_16bit_instance1(out_data,out_16_6bit,out_16_9bit,imm_controller_out);


PC_Plus_Immediate pc_Plus_Immediate_instance (PC_out_mux_in, PC_out_ID_RF, out_data);


mux4to1_16bit mux4to1_16bit_instance1(mux_out,mux_instance2_2to1_out,PC_out_mux_in,PC_plus1_out_ID_RF,pc_plus_one,select_from_BL_controller, reset);


Branch_Load_controller branch_Load_controller_instance(select_from_BL_controller, 
Valid_in, BP_write_enable, PC_BP_in, BTA_BP_in, H_BP_in, add_BP_in,
enable1, enable2, src1, src2, opcode_out, Instruction_out_IF_ID[15:12], 
dest_out_ID_RF, mux_instance2_4to1_out, mux_instance2_2to1_out, Valid_out_ID_RF,
add_BP_out, PC_out_mux_in, PC_out_IF_ID, PC_out_ID_RF, count1, count2, clock, reset);





Forward_Controller forward_Controller_instance
(
mux_controller_A,
mux_controller_B,

src1_out_ID_RF[2:0], src2_out_ID_RF[2:0], Dest_out_RF_EX, Dest_out_EX_M, Dest_out_M_WB, WB_out_RF_EX[2], WB_out_EX_M[2], WB_out_M_WB[2]);


mux4to1_16bit mux4to1_16bit_instance2(mux_instance2_4to1_out, data_read0, alu_zero_pad_out_mux, alu_mem_data_read_out_mux, data_write, mux_controller_A, reset);

mux4to1_16bit mux4to1_16bit_instance3(mux_instance3_4to1_out, data_read1, alu_zero_pad_out_mux, alu_mem_data_read_out_mux, data_write, mux_controller_B, reset);

mux2to1_16bit mux2to1_16bit_instance2(mux_instance2_2to1_out, mux_instance3_4to1_out, out_16_6bit, Ex_out_ID_RF[3]);

// Execution Stage---------------====================+++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



RF_EX_reg rf_ex_reg_instance
(
PC_plus1_out_RF_EX, WB_out_RF_EX, Memory_out_RF_EX, Ex_out_RF_EX, src1_out_RF_EX, src2_out_RF_EX, RA_data_out,
RB_data_out, RB_direct_data_out, SE16_out_RF_EX, Zero_pad_out_RF_EX, Dest_out_RF_EX, Valid_out_RF_EX,

PC_plus1_out_ID_RF, WB_out_ID_RF, Memory_out_ID_RF, Ex_out_ID_RF, src1_out_ID_RF, src2_out_ID_RF,
mux_instance2_4to1_out, mux_instance2_2to1_out, mux_instance3_4to1_out, out_16_6bit, out_16_zero_padder, dest_out_ID_RF, Valid_out_ID_RF, clock, reset);


ALU_with_CCR alu_instance(alu_out_EX, RA_data_out, RB_data_out, Ex_out_RF_EX[2:0], clock, reset);

mux2to1_16bit mux2to1_16bit_instance3(alu_zero_pad_out_mux, alu_out_EX, Zero_pad_out_RF_EX, (WB_out_RF_EX[2] & WB_out_RF_EX[1] & WB_out_RF_EX[0]));


// Memory stage--------------------------------------///////////==================================
//====================++++++++++++++++++++++++++++++++------------------------&&&&&&&&&&&&&&&&&&&&&& 



EX_M_reg EX_M_reg_instance
(
PC_plus1_out_EX_M, WB_out_EX_M, Memory_out_EX_M, Memory_data_write_out_EX_M, ALU_out_EX_M,
Zero_pad_out_EX_M, Dest_out_EX_M, Valid_out_EX_M,

PC_plus1_out_RF_EX, WB_out_RF_EX, Memory_out_RF_EX, RB_direct_data_out, alu_out_EX, Zero_pad_out_RF_EX,
Dest_out_RF_EX,Valid_out_RF_EX,clock,reset);



and and_instance1(and1_output, Memory_out_EX_M[1], Valid_out_EX_M);

data_memory data_memory_instance(data_bus_read, Memory_data_write_out_EX_M, ALU_out_EX_M, Memory_out_EX_M[0], and1_output, reset, clock);

// mux2to1_16bit mux2to1_16bit_instance4(alu_mem_data_read_out_mux, ALU_out_EX_M, data_bus_read, Memory_out_EX_M[1]);

mux4to1_16bit mux4to1_16bit_instance5(alu_mem_data_read_out_mux, data_bus_read, 16'b0, ALU_out_EX_M, Zero_pad_out_EX_M, WB_out_EX_M[1:0], reset);

//==========================================Write Back Stage =============================================
// #################################%%%%%%%%%%%%%%%%%%%%%%%%%%%%&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&



M_WB_reg M_WB_reg_instance
(
PC_plus1_out_M_WB, WB_out_M_WB, Memory_data_read_out_M_WB, ALU_out_M_WB, Zero_pad_out_M_WB, Dest_out_M_WB, Valid_out_M_WB,

PC_plus1_out_EX_M, WB_out_EX_M, data_bus_read, ALU_out_EX_M, Zero_pad_out_EX_M, Dest_out_EX_M, Valid_out_EX_M, clock, reset);

mux4to1_16bit mux4to1_16bit_instance4(data_write, Memory_data_read_out_M_WB, 
PC_plus1_out_M_WB, ALU_out_M_WB, Zero_pad_out_M_WB, WB_out_M_WB[1:0], reset);



and and_instance2(reg_write_enable, WB_out_M_WB[2], Valid_out_M_WB);

// assign data_write_output = data_write;

endmodule



//			| | | | | | | | |
//		  -------------------
//   	-|							|-
//   	-|							|-
//   	-|							|-
//		-|     IITB RISC     |-
//		-|							|-
//		-|     Processor     |-
//   	-|	  Made In India	|-
//   	-|							|-
//   	-|							|-
//   	-|							|-
//      -------------------
//			| | | | | | | | |