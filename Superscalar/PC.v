module PC(PC_out, PC_in, clock, reset, enable);

output reg [15:0] PC_out;

input [15:0] PC_in;
input clock, reset, enable;

initial
begin
	PC_out = 16'b0;
end

always @(posedge clock)
begin
	if(! reset && enable)
		PC_out <= PC_in;
	else if(reset)
		PC_out <= 16'b0;
end

endmodule