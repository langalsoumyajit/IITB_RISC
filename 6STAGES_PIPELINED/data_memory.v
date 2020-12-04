module data_memory(data_bus_read,data_bus_write,address,read,write,reset,clock);
parameter memory_size=512;
output reg [15:0] data_bus_read;
input [15:0]address;
input read,write,reset,clock;
input [15:0] data_bus_write;

reg [15:0] mem[memory_size-1:0];//declaring memory location,each 16 bits

//initial
//begin
//	mem[2] = 16'b0000000000000010;
//end

always@(address,read,write,reset,clock,data_bus_write)
begin

	if (write && ! read)
		mem[address]<= data_bus_write;
		
	else if (!write && read)
		data_bus_read <= mem[address];
	
	else
		data_bus_read <= 16'bz;

end // end always
endmodule 


