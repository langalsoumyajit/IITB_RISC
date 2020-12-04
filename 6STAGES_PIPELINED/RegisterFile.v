module RegisterFile
(data_read0, 
data_read1, 
data_write, 
data_read0_address, 
data_read1_address, 
data_write_address, 
clock, 
reset, 
reg_write_enable);

input [15:0] data_write;
input [2:0] data_read0_address, data_read1_address, data_write_address;
input clock, reset, reg_write_enable;
output [15:0] data_read0, data_read1;
wire [15:0] reg_output [7:0];
//wire [15:0] reg_input;
wire [7:0] reg_enable ;

decoder3to8 decoder_regFile (reg_enable,data_write_address,reg_write_enable);
register_16bit reg_0 (reg_output[0],16'b0,clock,1'b0,1'b0);
genvar i;
generate
	for(i=1 ; i<8 ;i=i+1) begin : gen_reg
		register_16bit reg_i (reg_output[i],data_write,clock,reset,reg_enable[i]);
	end
endgenerate

mux8to1_16bit mux_0(data_read0,reg_output[0],reg_output[1],reg_output[2],reg_output[3],reg_output[4],reg_output[5],reg_output[6],reg_output[7],data_read0_address);
mux8to1_16bit mux_1(data_read1,reg_output[0],reg_output[1],reg_output[2],reg_output[3],reg_output[4],reg_output[5],reg_output[6],reg_output[7],data_read1_address);


// For Testing

//assign reg_output[1] = 16'b0000000000001111; 



endmodule