module register_16bit(data_out, data_in0, data_in1, clock, reset, enable0, enable1);
input [15:0] data_in0, data_in1;
input clock,reset,enable0, enable1;
output reg [15:0] data_out;

always @(clock or reset or enable0)
begin
	if(! reset)
	begin
		if(enable0 && clock)
			data_out <= data_in0;
		else if(enable1 && ! clock)
			data_out <= data_in0;
	end
	else
		data_out <= 16'b0;
end

endmodule