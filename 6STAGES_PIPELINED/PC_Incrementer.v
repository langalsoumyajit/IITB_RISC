module PC_Incrementer(PC_out, PC_in, reset, clock);

output reg [15:0] PC_out;
input [15:0] PC_in;
input reset, clock;

initial
begin
	PC_out <=16'b0;
end

always @(PC_in, reset)
begin
	if(reset)
		PC_out <= 16'b0;
	else
		PC_out <= PC_in + 1'b1;
end
endmodule