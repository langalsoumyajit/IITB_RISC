module register_16bit(data_out,data_in,clock,reset,enable);
input [15:0] data_in;
input clock,reset,enable;
output reg [15:0] data_out;

always @(posedge clock)
begin
	if(! reset)
	begin
		if(enable)
			data_out <= data_in;
	end
	else
		data_out <= 16'b0;
end

endmodule