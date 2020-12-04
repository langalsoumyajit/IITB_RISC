module CCR(carry_out, zero_out, carry_in, zero_in, enable, clock, reset);
output reg carry_out, zero_out;
input carry_in, zero_in, enable, clock, reset;

always @(posedge clock)
begin

if(! reset)
	begin
		if(enable)
		begin
			carry_out <= carry_in;
			zero_out <= zero_in;
		end
	end
else
	begin
		carry_out <= 1'b0;
		zero_out <= 1'b0;
	end

end

endmodule

