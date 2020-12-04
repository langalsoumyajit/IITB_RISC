module ALU(out_alu, carry_out, zero_out, ccr_enable, bus_a, bus_b, carry_in, zero_in, alu_control);
output reg [15:0] out_alu;
output reg carry_out, zero_out, ccr_enable;
input [15:0] bus_a, bus_b;
input [2:0] alu_control;
input carry_in, carry_in, zero_in;

wire [16:0] temp_result;
assign temp_result = bus_a + bus_b;

initial begin
	out_alu = 16'b0;
end

always@(alu_control, bus_a, bus_b, carry_in, zero_in, temp_result)
begin
	case(alu_control)
		3'b000 : //ADD----------------------------
		begin
			out_alu <= temp_result[15:0];
			carry_out <= temp_result[16];
			if(temp_result[15:0] == 16'b0)
			begin
				zero_out <= 1'b1;
				ccr_enable <= 1'b1;
			end
			else
			begin
				zero_out <= 1'b0;
				ccr_enable <= 1'b1;
			end
		end
		3'b001 : //Add if carry is set -----------
		begin
			if(carry_in == 1'b1)
			begin
				out_alu <= temp_result[15:0];
				carry_out <= temp_result[16];
				if(temp_result[15:0] == 16'b0)
				begin
					zero_out <= 1'b1;
					ccr_enable <= 1'b1;
				end
				else
				begin
					zero_out <= 1'b0;
					ccr_enable <= 1'b1;
				end
			end
			else
			begin
				out_alu <= 16'b0;
				ccr_enable <= 1'b0;
			end
		end
		3'b010 : //Add if zero is set ------------
		begin
			if(zero_in == 1'b1)
			begin
				out_alu <= temp_result[15:0];
				carry_out <= temp_result[16];
				if(temp_result[15:0] == 16'b0) 
				begin
					zero_out <= 1'b1;
					ccr_enable <= 1'b1;
				end
				else
				begin
					zero_out <= 1'b0;
					ccr_enable <= 1'b1;
				end
			end
			else
			begin
				out_alu <= 16'b0;
				ccr_enable <= 1'b0;
			end
		end
		3'b011 : //Add immediate------------------
			begin
				out_alu <= temp_result[15:0];
				if(temp_result[15:0] == 16'b0)
				begin
					zero_out <= 1'b1;
					ccr_enable <= 1'b1;
				end
				else
				begin
					zero_out <= 1'b0;
					ccr_enable <= 1'b1;
				end
			end
		3'b100 : // NAND 
			begin
				out_alu <= ~(bus_a & bus_b);
				if(temp_result[15:0] == 16'b0)
				begin
					zero_out <= 1'b1;
					ccr_enable <= 1'b1;
				end
				else
				begin
					zero_out <= 1'b0;
					ccr_enable <= 1'b1;
				end
			end
		3'b101 : // NAND if carry is set
			begin
				out_alu <= ~(bus_a & bus_b);
				if(temp_result[15:0] == 16'b0)
				begin
					zero_out <= 1'b1;
					ccr_enable <= 1'b1;
				end
				else
				begin
					zero_out <= 1'b0;
					ccr_enable <= 1'b1;
				end
			end
		3'b110 : // NAND if zero is set-----------
			//
			begin
				out_alu <= ~(bus_a & bus_b);
				if(temp_result[15:0] == 16'b0)
				begin
					zero_out <= 1'b1;
					ccr_enable <= 1'b1;
				end
				else
				begin
					zero_out <= 1'b0;
					ccr_enable <= 1'b1;
				end
			end
			
		3'b111 : // Do nothing--------------------
			out_alu = 16'b0;
		default : 
			out_alu <= 16'b0;
	endcase
		
end

endmodule