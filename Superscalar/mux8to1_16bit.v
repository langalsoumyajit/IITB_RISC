module mux8to1_16bit(out_data,in_data0,in_data1,in_data2,in_data3,in_data4,in_data5,in_data6,in_data7,select);

input [15:0] in_data0,in_data1,in_data2,in_data3,in_data4,in_data5,in_data6,in_data7;
input [2:0] select;
output reg [15:0] out_data;

always @(select or in_data0 or in_data1 or in_data2 or in_data3 or in_data4 or in_data5 or in_data6 or in_data7)

  begin

    case (select)

      3'b000: out_data = in_data0;

      3'b001: out_data = in_data1;

      3'b010: out_data = in_data2;

      3'b011: out_data = in_data3;
		
		3'b100: out_data = in_data4;
		
		3'b101: out_data = in_data5;
		
		3'b110: out_data = in_data6;
		
		3'b111: out_data = in_data7;

    endcase

  end
endmodule 