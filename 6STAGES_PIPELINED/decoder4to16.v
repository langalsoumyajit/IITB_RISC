module decoder4to16(outp,inp,enable);
input [3:0]inp;
input enable;
output reg [15:0]outp;

// assign outp[inp] = enable;


always @(inp,enable)  
	begin  
		if(enable == 1'b1)
		begin
			case (inp)  
				4'b0000 : outp = 16'b0000000000000001;  
				4'b0001 : outp = 16'b0000000000000010;  
				4'b0010 : outp = 16'b0000000000000100;   
				4'b0011 : outp = 16'b0000000000001000;    
				4'b0100 : outp = 16'b0000000000010000;    
				4'b0101 : outp = 16'b0000000000100000;    
				4'b0110 : outp = 16'b0000000001000000;   
				4'b0111 : outp = 16'b0000000010000000;    
				
				4'b1000 : outp = 16'b0000000100000000;    
				4'b1001 : outp = 16'b0000001000000000;   
				4'b1010 : outp = 16'b0000010000000000;    
				4'b1011 : outp = 16'b0000100000000000;    
				4'b1100 : outp = 16'b0001000000000000;    
				4'b1101 : outp = 16'b0010000000000000;    
				4'b1110 : outp = 16'b0100000000000000;    
				4'b1111 : outp = 16'b1000000000000000;  
		 endcase  
		end
		
		else
			outp = 16'b0;
  end  
endmodule

