module Sign_Extenter_9bit(out_16, in_9);

output [15:0] out_16;
input [8:0] in_9;

assign out_16 = {{7{in_9[8]}},in_9[8:0]};

endmodule