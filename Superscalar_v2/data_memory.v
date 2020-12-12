module data_memory(data_bus_read0,data_bus_read1,data_bus_write0,data_bus_write1,address0,address1,read0,read1,write0,write1,reset,clock);
parameter memory_size=512;
output reg [15:0] data_bus_read0,data_bus_read1;
input [15:0]address0,address1;
input read0,write0,read1,write1,reset,clock;
input [15:0] data_bus_write0,data_bus_write1;
integer i;

reg [15:0] mem[memory_size-1:0];//declaring memory location,each 16 bits

initial
begin
	mem[2] = 16'b0000000010000000;
	mem[3] = 16'b0000000100000000;
end

always@(posedge clock)
begin
	if(!reset) begin
		if (write0 && write1 && (address0 == address1))
			mem[address0]<= data_bus_write1;
		
		if (write1) 
			mem[address1]<= data_bus_write1;	
		
		if (write0)
			mem[address0]<= data_bus_write0;
		
	end	
//	else begin
//		for(i=0 ; i<512 ;i=i+1) begin
//			mem[i] <= 16'b0;
//		end
//	end

end // end always


always@(*)
begin
	if (read0)
			data_bus_read0 <= mem[address0];
	else
			data_bus_read0 <= 16'bz;
	if (read1)
			data_bus_read1 <= mem[address1];
	else
			data_bus_read1 <= 16'bz;
	
	
end
endmodule 


