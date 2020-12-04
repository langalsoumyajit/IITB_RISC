module BP_Controller(PC_mux_sel_line, BTA_in, H_BP_out, clock, reset);

output reg PC_mux_sel_line;

input [15:0] BTA_in;
input clock, reset, H_BP_out;

always @(posedge clock)
begin
	if(reset)
		PC_mux_sel_line <= 1'b0;
		
	else if(BTA_in == 16'b0 && !reset)
		PC_mux_sel_line <= 1'b0;
		
	else if(BTA_in != 16'b0 && !reset && H_BP_out)
		PC_mux_sel_line <= 1'b1;
		
	else
		PC_mux_sel_line <= 1'b0;

end

endmodule