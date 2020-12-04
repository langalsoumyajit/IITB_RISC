module mux2to1_16bit
(out_data,in_data0,in_data1,select);

input [15:0] in_data0,in_data1;
input select;
output reg [15:0] out_data;

always @(select, in_data0, in_data1)

  begin

    case (select)

      1'b0: out_data = in_data0;

      1'b1: out_data = in_data1;
	endcase

  end
endmodule 