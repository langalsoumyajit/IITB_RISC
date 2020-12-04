module CPU(clock, reset);

input clock, reset;

wire [15:0] pc_out, mux_IF_out, pc_plus_two, PC_plus2_out_IF_ID_1, PC_out_IF_ID_1, Instruction1_out_IF_ID, PC_plus2_out_IF_ID_2, PC_out_IF_ID_2, 
Instruction2_out_IF_ID, PC_out_ID_RF_1, PC_plus2_out_ID_RF1, PC_out_ID_RF_2, PC_plus2_out_ID_RF2, data_read0, data_read1, data_read2, data_read3,
data_write0, data_write1, Sign_Extenter_6bit_out1, Sign_Extenter_6bit_out2, Sign_Extenter_9bit_out1, Sign_Extenter_9bit_out2;
wire [15:0] sign_Extenter_out_data, Zero_Padder_9bit_out1, Zero_Padder_9bit_out2, PC_out_PC_plus_Imm, src1_read1, src2_read1, 
				src1_read2, src2_read2, src2_read_imm_1, src2_read_imm_2, PC_plus2_out_RF_EX1, PC_plus2_out_RF_EX2,
				RA_data_out1, RB_data_out1, RB_direct_data_out1, SE16_out_RF_EX1, Zero_pad_out_RF_EX1, 
				RA_data_out2, RB_data_out2, RB_direct_data_out2, SE16_out_RF_EX2, Zero_pad_out_RF_EX2,
				out_alu_EX1, out_alu_EX2, alu_zero_pad_out_mux1, alu_zero_pad_out_mux2;
wire [15:0] PC_plus2_out_EX_M1, PC_plus2_out_EX_M2, Memory_data_write_out_EX_M1, ALU_out1, Zero_pad_out_EX_M1, Memory_data_write_out_EX_M2, 
				ALU_out2, Zero_pad_out_EX_M2, data_bus_read0, data_bus_read1, alu_mem_data_read_out_mux1, alu_mem_data_read_out_mux2,
				PC_plus2_out_M_WB1, PC_plus2_out_M_WB2, Memory_data_read_out_M_WB1, ALU_out_M_WB1, Zero_pad_out_M_WB1,
				Memory_data_read_out_M_WB2, ALU_out_M_WB2, Zero_pad_out_M_WB2, PC_plus_Immediate_out, PC_out_RF_EX1, PC_out_RF_EX2;

wire [31:0] inst_bus;
wire enable, Valid_out1_IF_ID, valid_previous_BC, Valid_out2_IF_ID, imm_controller1, imm_controller2, Valid_out1_ID_RF;

wire [2:0] WB1, dest1, WB2, dest2, WB_out_ID_RF1, WB_out_ID_RF2, Dest_out_M_WB1, Dest_out_M_WB2, WB_out_RF_EX1, WB_out_RF_EX2, Dest_out_RF_EX1,
				Dest_out_RF_EX2, WB_out_EX_M1, WB_out_EX_M2, Dest_out_EX_M1, Dest_out_EX_M2, WB_out_M_WB1, WB_out_M_WB2,
				mux_controller_A, mux_controller_B, mux_controller_C, mux_controller_D;
				
wire [1:0] Memory1, Memory2, Memory_out_ID_RF1, Memory_out_ID_RF2, mux_controller_PC, imm_control_sign_extender_MUX,
Memory_out_RF_EX1, Memory_out_RF_EX2, Memory_out_EX_M1, Memory_out_EX_M2;
wire [3:0] EX1, src1_1, src2_1, EX2, src1_2, src2_2, Ex_out_ID_RF1, Ex_out_ID_RF2, opcode_out1, src1_out_ID_RF1, src2_out_ID_RF1, dest_out_ID_RF1,
opcode_out2, src1_out_ID_RF2, src2_out_ID_RF2, dest_out_ID_RF2, Ex_out_RF_EX1, Ex_out_RF_EX2, src1_out_RF_EX1, src2_out_RF_EX1, 
src1_out_RF_EX2, src2_out_RF_EX2, opcode_out_RF_EX1, opcode_out_RF_EX2;
wire [8:0] imm9_1, imm9_2, imm9_out_ID_RF_1, imm9_out_ID_RF_2;
wire [5:0] imm6_1, imm6_2, imm6_out_ID_RF_1, imm6_out_ID_RF_2;
wire valid_next1_dras, valid_next2_dras, Valid_out_1_ID_RF, imm_controller_out1, Valid_out_2_ID_RF, imm_controller_out2, 
reg_write_enable0, reg_write_enable1, valid_next1_BC, valid_next2_BC, Valid_out_and_gate1, Valid_out_and_gate2, Valid_out_RF_EX1, 
Valid_out_RF_EX2, Valid_out_EX_M1, Valid_out_EX_M2, Valid_out_and_gate3, Valid_out_and_gate4, Valid_out_and_gate5, Valid_out_and_gate6, 
write_enable_and_gate2, write_enable_and_gate1, Valid_out_M_WB1, Valid_out_M_WB2;



// IF stage------------------------------------------------
//=======================================================//


PC pc_instance(pc_out, mux_IF_out, clock, reset, enable);

inst_memory inst_memory_instance(inst_bus,pc_out,reset,clock);

PC_Incrementer pc_incrementer_instance1(pc_plus_two, pc_out, reset, clock);


// ID stage ==============================================
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++
IF_ID_reg if_id_reg_instance1(PC_plus2_out_IF_ID_1, PC_out_IF_ID_1, Instruction1_out_IF_ID, Valid_out1_IF_ID,
 pc_plus_two, pc_out, inst_bus[15 : 0], valid_previous_BC, clock, reset, enable);
 
IF_ID_reg if_id_reg_instance2(PC_plus2_out_IF_ID_2, PC_out_IF_ID_2, Instruction2_out_IF_ID, Valid_out2_IF_ID,
 pc_plus_two, pc_out, inst_bus[31 : 16], valid_previous_BC, clock, reset, enable);


Instruction_decoder instruction_decoder_instance1(WB1, Memory1, EX1, src1_1, src2_1, dest1, imm9_1, imm6_1, imm_controller1, Instruction1_out_IF_ID);

Instruction_decoder instruction_decoder_instance2(WB2, Memory2, EX2, src1_2, src2_2, dest2, imm9_2, imm6_2, imm_controller2, Instruction2_out_IF_ID);



// RF Stage ==============================================
//+++++++++++++++++++++++++++++++-----------++++++++++++++

and and_instance1(Valid_out_and_gate1, valid_previous_BC, Valid_out1_IF_ID);
and and_instance2(Valid_out_and_gate2, valid_previous_BC, Valid_out2_IF_ID);

ID_RF_reg ID_RF_reg_instance1(PC_out_ID_RF_1, PC_plus2_out_ID_RF1, WB_out_ID_RF1, Memory_out_ID_RF1, Ex_out_ID_RF1, opcode_out1, src1_out_ID_RF1,
src2_out_ID_RF1, dest_out_ID_RF1, imm9_out_ID_RF_1, imm6_out_ID_RF_1, Valid_out_1_ID_RF,imm_controller_out1,
PC_out_IF_ID_1, PC_plus2_out_IF_ID_1, WB1, Memory1, EX1,
Instruction1_out_IF_ID[15:12], src1_1, src2_1, dest1, imm9_1, imm6_1,
Valid_out_and_gate1, imm_controller1, clock,reset, enable);

ID_RF_reg ID_RF_reg_instance2(PC_out_ID_RF_2, PC_plus2_out_ID_RF2, WB_out_ID_RF2, Memory_out_ID_RF2, Ex_out_ID_RF2, opcode_out2, src1_out_ID_RF2,
src2_out_ID_RF2, dest_out_ID_RF2, imm9_out_ID_RF_2, imm6_out_ID_RF_2, Valid_out_2_ID_RF,imm_controller_out2,
PC_out_IF_ID_2, PC_plus2_out_IF_ID_2, WB2, Memory2, EX2,
Instruction2_out_IF_ID[15:12], src1_2, src2_2, dest2, imm9_2, imm6_2,
Valid_out_and_gate2, imm_controller2, clock,reset, enable);




RegisterFile_v2 RegisterFile_v2_instance(data_read0, data_read1, data_read2, data_read3, 
data_write0, data_write1, src1_out_ID_RF1[2:0], src2_out_ID_RF1[2:0], src1_out_ID_RF2[2:0], 
src2_out_ID_RF2[2:0], Dest_out_M_WB1, Dest_out_M_WB2, clock, reset, reg_write_enable0, reg_write_enable1);

Sign_Extenter_6bit Sign_Extenter_6bit_1(Sign_Extenter_6bit_out1, imm6_out_ID_RF_1);
Sign_Extenter_6bit Sign_Extenter_6bit_2(Sign_Extenter_6bit_out2, imm6_out_ID_RF_2);

Sign_Extenter_9bit Sign_Extenter_9bit_1(Sign_Extenter_9bit_out1, imm9_out_ID_RF_1);
Sign_Extenter_9bit Sign_Extenter_9bit_2(Sign_Extenter_9bit_out2, imm9_out_ID_RF_2);

Zero_Padder_9bit Zero_Padder_9bit_1(Zero_Padder_9bit_out1, imm9_out_ID_RF_1);
Zero_Padder_9bit Zero_Padder_9bit_2(Zero_Padder_9bit_out2, imm9_out_ID_RF_2);



Dependency_resolver_and_staller Dependency_resolver_and_staller_instance(
valid_next1_dras, valid_next2_dras, enable,

opcode_out1, opcode_out2, opcode_out_RF_EX1, opcode_out_RF_EX2, PC_out_ID_RF_1, PC_out_RF_EX1, 
src1_out_ID_RF1, src2_out_ID_RF1, src1_out_ID_RF2, src2_out_ID_RF2, dest_out_ID_RF1, dest_out_ID_RF2, Dest_out_RF_EX1, Dest_out_RF_EX2, 
16'b0, 16'b0, Valid_out_1_ID_RF, Valid_out_2_ID_RF, Valid_out_RF_EX1, Valid_out_RF_EX2, clock, reset);

PC_Plus_Immediate PC_Plus_Immediate_instance(PC_out_PC_plus_Imm, PC_out_ID_RF_1, sign_Extenter_out_data);

mux4to1_16bit mux4to1_16bit_Sign_extender //Sign_Extenter for PC + Immediate
(sign_Extenter_out_data,Sign_Extenter_6bit_out1,Sign_Extenter_9bit_out1,Sign_Extenter_6bit_out2,Sign_Extenter_9bit_out2,
imm_control_sign_extender_MUX,reset);

Branch_controller Branch_controller_instance(mux_controller_PC, valid_previous_BC, valid_next1_BC, valid_next2_BC, imm_control_sign_extender_MUX,
opcode_out1, opcode_out2, src1_out_ID_RF1, src2_out_ID_RF1, src1_out_ID_RF2, src2_out_ID_RF2, dest_out_ID_RF1, dest_out_ID_RF2, 
src1_read1, src2_read_imm_1, src1_read2, src2_read_imm_2,  
Valid_out_1_ID_RF, Valid_out_2_ID_RF, 
clock, reset);


//MUX for PC

mux4to1_16bit mux4to1_16bit_PC(mux_IF_out, src2_read1, PC_out_PC_plus_Imm, src2_read2, pc_plus_two, mux_controller_PC, reset);

Forward_Controller Forward_Controller_instance
(
mux_controller_A, mux_controller_B, mux_controller_C, mux_controller_D,

src1_out_ID_RF1, src2_out_ID_RF1, src1_out_ID_RF2, src2_out_ID_RF2, Dest_out_RF_EX1, Dest_out_RF_EX2, Dest_out_EX_M1, Dest_out_EX_M2,
Dest_out_M_WB1, Dest_out_M_WB2, WB_out_RF_EX1[2], WB_out_EX_M1[2], WB_out_M_WB1[2], WB_out_RF_EX2[2], WB_out_EX_M2[2], WB_out_M_WB2[2],
Valid_out_RF_EX1, Valid_out_RF_EX2, Valid_out_EX_M1, Valid_out_EX_M2, Valid_out_M_WB1, Valid_out_M_WB2);



mux8to1_16bit mux8to1_16bit_instance1(src1_read1,data_read0, alu_zero_pad_out_mux1, alu_zero_pad_out_mux2, alu_mem_data_read_out_mux1,
	alu_mem_data_read_out_mux2,data_write0, data_write1, 16'b0, mux_controller_A);
mux8to1_16bit mux8to1_16bit_instance2(src2_read1,data_read1, alu_zero_pad_out_mux1, alu_zero_pad_out_mux2, alu_mem_data_read_out_mux1,
	alu_mem_data_read_out_mux2,data_write0, data_write1, 16'b0,mux_controller_B);
mux8to1_16bit mux8to1_16bit_instance3(src1_read2,data_read2, alu_zero_pad_out_mux1, alu_zero_pad_out_mux2, alu_mem_data_read_out_mux1,
	alu_mem_data_read_out_mux2,data_write0, data_write1, 16'b0,mux_controller_C);
mux8to1_16bit mux8to1_16bit_instance4(src2_read2,data_read3, alu_zero_pad_out_mux1, alu_zero_pad_out_mux2, alu_mem_data_read_out_mux1,
	alu_mem_data_read_out_mux2,data_write0, data_write1, 16'b0, mux_controller_D);
mux2to1_16bit mux2to1_16bit_instance1(src2_read_imm_1,src1_read2,Sign_Extenter_6bit_out1,Ex_out_ID_RF1[1]);
mux2to1_16bit mux2to1_16bit_instance2(src2_read_imm_2,src1_read4,Sign_Extenter_6bit_out2,Ex_out_ID_RF2[3]);


// Execution Stage------------------------------------------====================+++++++++++===============
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++==========================================
and and_instance3(Valid_out_and_gate3, valid_next1_dras, Valid_out_1_ID_RF);
and and_instance4(Valid_out_and_gate4, valid_next2_dras, Valid_out_2_ID_RF);

and and_instance5(Valid_out_and_gate5, Valid_out_and_gate3, valid_next1_BC);
and and_instance6(Valid_out_and_gate6, Valid_out_and_gate4, valid_next2_BC);

RF_EX_reg RF_EX_reg_instance1(PC_out_RF_EX1, PC_plus2_out_RF_EX1, WB_out_RF_EX1, Memory_out_RF_EX1, Ex_out_RF_EX1, opcode_out_RF_EX1, src1_out_RF_EX1, src2_out_RF_EX1,
RA_data_out1, RB_data_out1, RB_direct_data_out1, SE16_out_RF_EX1, Zero_pad_out_RF_EX1, Dest_out_RF_EX1, Valid_out_RF_EX1,

PC_out_ID_RF_1, PC_plus2_out_ID_RF1, WB_out_ID_RF1, Memory_out_ID_RF1, Ex_out_ID_RF1, opcode_out1, src1_out_ID_RF1, src2_out_ID_RF1, src1_read1, src2_read_imm_1, 
src2_read1, Sign_Extenter_6bit_out1, Zero_Padder_9bit_out1, dest_out_ID_RF1, Valid_out_and_gate5, clock, reset, 1'b1);

RF_EX_reg RF_EX_reg_instance2(PC_out_RF_EX2, PC_plus2_out_RF_EX2, WB_out_RF_EX2, Memory_out_RF_EX2, Ex_out_RF_EX2, opcode_out_RF_EX2, src1_out_RF_EX2, src2_out_RF_EX2,
RA_data_out2, RB_data_out2, RB_direct_data_out2, SE16_out_RF_EX2, Zero_pad_out_RF_EX2, Dest_out_RF_EX2, Valid_out_RF_EX2,

PC_out_ID_RF_1, PC_plus2_out_ID_RF2, WB_out_ID_RF2, Memory_out_ID_RF2, Ex_out_ID_RF2, opcode_out1, src1_out_ID_RF2, src2_out_ID_RF2, src1_read2, src2_read_imm_2, 
src2_read2, Sign_Extenter_6bit_out2, Zero_Padder_9bit_out2, dest_out_ID_RF2, Valid_out_and_gate6, clock, reset, 1'b1);

ALU_with_CCR ALU_with_CCR_instance1(out_alu_EX1, RA_data_out1, RB_data_out1, Ex_out_RF_EX1[2:0], clock, reset);
ALU_with_CCR ALU_with_CCR_instance2(out_alu_EX2, RA_data_out2, RB_data_out2, Ex_out_RF_EX2[2:0], clock, reset);


mux2to1_16bit mux2to1_16bit_instance3(alu_zero_pad_out_mux1, out_alu_EX1, Zero_pad_out_RF_EX1, (WB_out_RF_EX1[2] & WB_out_RF_EX1[1] & WB_out_RF_EX1[0]));
mux2to1_16bit mux2to1_16bit_instance4(alu_zero_pad_out_mux2, out_alu_EX2, Zero_pad_out_RF_EX2, (WB_out_RF_EX2[2] & WB_out_RF_EX2[1] & WB_out_RF_EX2[0]));

// Memory stage--------------------------------------///////////==========================================
//====================++++++++++++++++++++++++++++++++------------------------&&&&&&&&&&&&&&&&&&&&&&------ 
and and_instance7(write_enable_and_gate1, Valid_out_EX_M1, Memory_out_EX_M1[1]);
and and_instance8(write_enable_and_gate2, Valid_out_EX_M2, Memory_out_EX_M2[1]);

EX_M_reg EX_M_reg_instance1
(PC_plus2_out_EX_M1, WB_out_EX_M1, Memory_out_EX_M1, Memory_data_write_out_EX_M1, ALU_out1, Zero_pad_out_EX_M1, Dest_out_EX_M1, Valid_out_EX_M1,

PC_plus2_out_RF_EX1, WB_out_RF_EX1, Memory_out_RF_EX1, RB_direct_data_out1, out_alu_EX1, Zero_pad_out_RF_EX1, Dest_out_RF_EX1, Valid_out_RF_EX1, 
clock, reset, 1'b1);

EX_M_reg EX_M_reg_instance2
(PC_plus2_out_EX_M2, WB_out_EX_M2, Memory_out_EX_M2, Memory_data_write_out_EX_M2, ALU_out2, Zero_pad_out_EX_M2, Dest_out_EX_M2, Valid_out_EX_M2,

PC_plus2_out_RF_EX2, WB_out_RF_EX2, Memory_out_RF_EX2, RB_direct_data_out2, out_alu_EX2, Zero_pad_out_RF_EX2, Dest_out_RF_EX2, Valid_out_RF_EX1, 
clock, reset, 1'b1);

data_memory data_memory_instance(data_bus_read0, data_bus_read1, Memory_data_write_out_EX_M1, Memory_data_write_out_EX_M2,
ALU_out1, ALU_out2, Memory_out_EX_M1[0], Memory_out_EX_M2[0], write_enable_and_gate1, write_enable_and_gate2, reset, clock);

mux4to1_16bit mux4to1_16bit_mem1(alu_mem_data_read_out_mux1, data_bus_read0, 16'b0, ALU_out1, Zero_pad_out_EX_M1, WB_out_EX_M1[1:0], reset);

mux4to1_16bit mux4to1_16bit_mem2(alu_mem_data_read_out_mux2, data_bus_read1, 16'b0, ALU_out2, Zero_pad_out_EX_M2, WB_out_EX_M2[1:0], reset);


//==========================================Write Back Stage =============================================
// #################################%%%%%%%%%%%%%%%%%%%%%%%%%%%%&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

M_WB_reg M_WB_reg_instance1
(PC_plus2_out_M_WB1, WB_out_M_WB1, Memory_data_read_out_M_WB1, ALU_out_M_WB1, Zero_pad_out_M_WB1, Dest_out_M_WB1, Valid_out_M_WB1,
PC_plus2_out_EX_M1, WB_out_EX_M1, data_bus_read0, ALU_out1, Zero_pad_out_EX_M1, Dest_out_EX_M1, Valid_out_EX_M1, clock, reset, 1'b1);

M_WB_reg M_WB_reg_instance2
(PC_plus2_out_M_WB2, WB_out_M_WB2, Memory_data_read_out_M_WB2, ALU_out_M_WB2, Zero_pad_out_M_WB2, Dest_out_M_WB2, Valid_out_M_WB1,
PC_plus2_out_EX_M2, WB_out_EX_M2, data_bus_read1, ALU_out2, Zero_pad_out_EX_M2, Dest_out_EX_M2, Valid_out_EX_M2, clock, reset, 1'b1);

mux4to1_16bit mux4to1_16bit_wb1(data_write0, Memory_data_read_out_M_WB1, 
PC_plus2_out_M_WB1, ALU_out_M_WB1, Zero_pad_out_M_WB1, WB_out_M_WB1[1:0], reset);

mux4to1_16bit mux4to1_16bit_wb2(data_write1, Memory_data_read_out_M_WB2, 
PC_plus2_out_M_WB2, ALU_out_M_WB2, Zero_pad_out_M_WB2, WB_out_M_WB2[1:0], reset);



and and_instance9(reg_write_enable0, WB_out_M_WB1[2], Valid_out_M_WB1);
and and_instance10(reg_write_enable1, WB_out_M_WB2[2], Valid_out_M_WB2);






endmodule



//			| | | | | | | | |
//		  -------------------
//   	-|							|-
//   	-|							|-
//   	-|							|-
//		-|     IITB RISC     |-
//		-|   Super scalar    |-
//		-|							|-
//		-|     Processor     |-
//   	-|	               	|-
//   	-|							|-
//   	-|							|-
//   	-|							|-
//      -------------------
//			| | | | | | | | |