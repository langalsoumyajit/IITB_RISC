module PC(PC_out, PC_in, clock, reset);

output reg [15:0] PC_out;

input [15:0] PC_in;
input clock, reset;

initial
begin
	PC_out = 16'b0;
end

always @(posedge clock)
begin
	if(! reset)
		PC_out <= PC_in;
	else
		PC_out <= 16'b0;
end

endmodule