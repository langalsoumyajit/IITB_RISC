module Branch_Predictor_address_counter(count, clock, reset, enable);
output reg [1:0] count;

input clock,reset, enable;

always @(posedge clock)
begin
	if(reset)
		count <= 2'b0;
	else if(!reset && enable)
		count <= count + 1;
end
endmodule