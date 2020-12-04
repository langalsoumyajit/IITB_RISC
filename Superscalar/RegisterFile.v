module RegisterFile
(data_read0, 
data_read1,
data_read2, 
data_read3, 
data_write0, 
data_write1, 
data_read0_address, 
data_read1_address,
data_read2_address, 
data_read3_address, 
data_write0_address, 
data_write1_address, 
clock, 
reset, 
reg_write_enable0,
reg_write_enable1);

input [15:0] data_write0, data_write1;
input [2:0] data_read0_address, data_read1_address, data_read2_address, data_read3_address, data_write0_address, data_write1_address;
input clock, reset, reg_write_enable0, reg_write_enable1;
output [15:0] data_read0, data_read1, data_read2, data_read3;
wire [15:0] reg_output [7:0];
//wire [15:0] reg_input;
wire [7:0] reg_enable0, reg_enable1 ;

decoder3to8 decoder0_regFile (reg_enable0,data_write0_address,reg_write_enable0);
decoder3to8 decoder1_regFile (reg_enable1,data_write1_address,reg_write_enable1);
register_16bit reg_0 (reg_output[0],16'b0,16'b0,clock,1'b0,1'b0,1'b0);
genvar i;
generate
	for(i=1 ; i<8 ;i=i+1) begin : gen_reg
		register_16bit reg_i (reg_output[i],data_write0,data_write1,clock,reset,reg_enable0[i],reg_enable1[i]);
	end
endgenerate

mux8to1_16bit mux_0(data_read0,reg_output[0],reg_output[1],reg_output[2],reg_output[3],reg_output[4],reg_output[5],reg_output[6],reg_output[7],data_read0_address);
mux8to1_16bit mux_1(data_read1,reg_output[0],reg_output[1],reg_output[2],reg_output[3],reg_output[4],reg_output[5],reg_output[6],reg_output[7],data_read1_address);
mux8to1_16bit mux_2(data_read2,reg_output[0],reg_output[1],reg_output[2],reg_output[3],reg_output[4],reg_output[5],reg_output[6],reg_output[7],data_read2_address);
mux8to1_16bit mux_3(data_read3,reg_output[0],reg_output[1],reg_output[2],reg_output[3],reg_output[4],reg_output[5],reg_output[6],reg_output[7],data_read3_address);


// For Testing

//assign reg_output[1] = 16'b0000000000001111; 



endmodule