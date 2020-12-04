module RegisterFile_v2
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
output reg [15:0] data_read0, data_read1, data_read2, data_read3;
wire [15:0] reg_output [7:0];
integer i;

reg [15:0] regs[7:0];//declaring regs location,each 16 bits
always@(posedge clock)
begin
	regs[0] <= 16'b0;

	if(! reset)
	begin
		if (reg_write_enable0 && reg_write_enable1 && (data_write0_address == data_write1_address))
			regs[data_write0_address]<= data_write1;
		
		else if (reg_write_enable0 && (data_write0_address != data_write1_address))
			regs[data_write0_address]<= data_write0;
			
		else if (reg_write_enable1 && (data_write0_address != data_write1_address))
			regs[data_write1_address]<= data_write1;
			
	end
	else begin
		for(i=0 ; i<8 ;i=i+1) begin
			regs[i] <= 16'b0;
		end
	end
end // end always

always@(*)
begin
	data_read0 <= regs[data_read0_address];
	data_read1 <= regs[data_read1_address];
	data_read2 <= regs[data_read2_address];
	data_read3 <= regs[data_read3_address];
	
end
endmodule 