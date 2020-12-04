// 16 BIT ADDER MODULE ---------------------------------------------------------->>>>>>

module adder(out_result, carry_out, zero_out, input_a, input_b, carry_in);
output [15:0] out_result;
output carry_out;
output reg zero_out;
input [15:0] input_a,input_b;
input carry_in;
wire [16:0] carry;

assign carry[0] = carry_in;
assign carry_out = carry[16];

genvar i;
generate
	for(i=0 ; i< 8; i=i+1) begin : adder_gen
		single_bit_adder adder_i (out_result[i], carry[i+1], input_a[i], input_b[i], carry[i]);
	end

endgenerate


always@(*)
begin	
	if(out_result == 0)
		zero_out = 1;
	else	
		zero_out =0;
end

endmodule

// Single bit adder module ---------------------------------------------------------->>>>>


module single_bit_adder(s_out, c_out, a_in, b_in, c_in);
output s_out,c_out;
input a_in, b_in,c_in;

assign s_out = a_in ^ b_in ^ c_in;
assign c_out = a_in & b_in | b_in & c_in | c_in & a_in;
endmodule