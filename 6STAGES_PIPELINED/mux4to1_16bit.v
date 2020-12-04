module mux4to1_16bit
(out_data,in_data0,in_data1,in_data2,in_data3,select,reset);

input [15:0] in_data0,in_data1,in_data2,in_data3;
input [1:0] select;
input reset;
output reg [15:0] out_data;

initial
begin
	out_data <= 16'b0;
end

always @(select, in_data0, in_data1, in_data2, in_data3, reset)

  begin

    case (select)

      2'b00: 
		begin
			if(reset)
				out_data <= 16'b0;
			else
				out_data <= in_data0;

		end
      2'b01: 
		begin
			if(reset)
				out_data <= 16'b0;
			else
				out_data <= in_data1;

		end
      2'b10:
		begin
			if(reset)
				out_data <= 16'b0;
			else
				out_data <= in_data2;

		end

      2'b11:
		begin
			if(reset)
				out_data <= 16'b0;
			else
				out_data <= in_data3;

		end
		
    endcase

  end
endmodule 