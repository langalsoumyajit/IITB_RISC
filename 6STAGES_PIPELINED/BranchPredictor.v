module BranchPredictor(add_BP_out, BTA_BP_out, BTA_BP_out_delayed, H_BP_out, add_BP_in, PC_BP_in, BTA_BP_in, H_BP_in, PC_in, clock, reset, BP_write_enable);
output reg [15:0] BTA_BP_out, BTA_BP_out_delayed;
output reg H_BP_out;
output reg [3:0] add_BP_out;

input [15:0] PC_BP_in, BTA_BP_in, PC_in; // One PC from mux output another from branchpredictor controller output	
input H_BP_in, clock, reset, BP_write_enable;
input [2:0] add_BP_in;

reg [15:0] PC_BP[7:0];
reg [15:0] BTA_BP[7:0];
reg [2:0] add_BP[7:0];
reg H_BP[7:0];	// 16 bit PC, 16 bit BTA, 1 History bit, 2 bit address

integer k;

initial
begin
	for(k=0; k< 8; k=k+1)
	begin
		PC_BP[k] <= 16'b0;
		BTA_BP[k] <= 16'b0;
		add_BP[k] <= 3'b0;
		H_BP[k] <= 1'b0;
	end
end

always @(posedge clock)
begin
//	if(reset)
//	begin
//		PC_BP[0] <= 16'b0;
//		BTA_BP[0] <= 16'b101;
//		add_BP[0] <= 3'b0;
//		H_BP[0] <= 1'b1;
//	end
	
	if(BP_write_enable)
	begin
		PC_BP[add_BP_in] <= PC_BP_in;
		BTA_BP[add_BP_in] <= BTA_BP_in;
		add_BP[add_BP_in] <= add_BP_in;
		H_BP[add_BP_in] <= H_BP_in;
	end
	
end

always @(PC_BP_in, PC_BP) // This will check address of PC where it has to write BTA and History bit.
begin
	if(PC_BP_in == PC_BP[0])
	begin
		add_BP_out <= {1'b1, add_BP[0]};
	end
		
	else if(PC_BP_in == PC_BP[1])
	begin
		add_BP_out <= {1'b1, add_BP[1]};
	end
		
	else if(PC_BP_in == PC_BP[2])
	begin
		add_BP_out <= {1'b1, add_BP[2]};
	end
		
	else if(PC_BP_in == PC_BP[3])
	begin
		add_BP_out <= {1'b1, add_BP[3]};
	end
		
	else if(PC_BP_in == PC_BP[4])
	begin
		add_BP_out <= {1'b1, add_BP[4]};
	end
		
	else if(PC_BP_in == PC_BP[5])
	begin
		add_BP_out <= {1'b1, add_BP[5]};
	end
		
	else if(PC_BP_in == PC_BP[6])
	begin
		add_BP_out <= {1'b1, add_BP[6]};
	end
	
	else if(PC_BP_in == PC_BP[7])
	begin
		add_BP_out <= {1'b1, add_BP[7]};
	end
	
	else 
	begin
		add_BP_out <= 4'b0000;
	end
	
end

always @(PC_in, PC_BP)   //PC will check if BTA is available there if available it will read it and history bit.
begin
	if(PC_in == PC_BP[0])
	begin
		BTA_BP_out <= BTA_BP[0];
		H_BP_out <= H_BP[0];
	end
		
	else if(PC_in == PC_BP[1])
		begin
		BTA_BP_out <= BTA_BP[1];
		H_BP_out <= H_BP[1];
	end
		
	else if(PC_in == PC_BP[2])
		begin
		BTA_BP_out <= BTA_BP[2];
		H_BP_out <= H_BP[2];
	end
		
	else if(PC_in == PC_BP[3])
		begin
		BTA_BP_out <= BTA_BP[3];
		H_BP_out <= H_BP[3];
	end
		
	else if(PC_in == PC_BP[4])
		begin
		BTA_BP_out <= BTA_BP[4];
		H_BP_out <= H_BP[4];
	end
		
	else if(PC_in == PC_BP[5])
		begin
		BTA_BP_out <= BTA_BP[5];
		H_BP_out <= H_BP[5];
	end
		
	else if(PC_in == PC_BP[6])
		begin
		BTA_BP_out <= BTA_BP[6];
		H_BP_out <= H_BP[6];
	end
	
	else if(PC_in == PC_BP[7])
		begin
		BTA_BP_out <= BTA_BP[7];
		H_BP_out <= H_BP[7];
	end
	
	else
		begin
		BTA_BP_out <= 16'b0;
		H_BP_out <= 1'b0;
	end
	
end


always @(posedge clock)   //PC will check if BTA is available there if available it will read it and history bit.
begin
	if(PC_in == PC_BP[0])
	begin
		BTA_BP_out_delayed <= BTA_BP[0];
		
	end
		
	else if(PC_in == PC_BP[1])
		begin
		BTA_BP_out_delayed <= BTA_BP[1];
		
	end
		
	else if(PC_in == PC_BP[2])
		begin
		BTA_BP_out_delayed <= BTA_BP[2];
		
	end
		
	else if(PC_in == PC_BP[3])
		begin
		BTA_BP_out_delayed <= BTA_BP[3];
		
	end
		
	else if(PC_in == PC_BP[4])
		begin
		BTA_BP_out_delayed <= BTA_BP[4];
		
	end
		
	else if(PC_in == PC_BP[5])
		begin
		BTA_BP_out_delayed <= BTA_BP[5];
		
	end
		
	else if(PC_in == PC_BP[6])
		begin
		BTA_BP_out_delayed <= BTA_BP[6];
		
	end
	
	else if(PC_in == PC_BP[7])
		begin
		BTA_BP_out_delayed <= BTA_BP[7];
		
	end
	
	else
		begin
		BTA_BP_out_delayed <= 16'b0;
		
	end
end

endmodule