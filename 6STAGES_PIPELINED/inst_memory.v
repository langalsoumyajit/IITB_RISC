module inst_memory(inst_bus,address,reset,clock);
parameter memory_size=140;
output [15:0] inst_bus;
input [15:0]address;
input reset,clock;

reg [15:0] mem[memory_size-1:0];//declaring memory location,each 16 bits

assign   inst_bus = mem[address];

initial
begin
//	mem[0] = 16'b1111111111111111; 	//NOP
//	mem[1] = 16'b0011001000000001;	// store 128 to reg1														(LHI r1,128)
//	mem[2] = 16'b0011010000000010;	// store 256 to reg2														(LHI r2,256)
//	mem[3] = 16'b0000001010011000;	// add reg1, reg2 and store to reg3-->128+256=384				(ADD r1,r2,r3)
//	mem[4] = 16'b0000010011011000;	// add reg2, reg3 and store to reg3-->256+384=640				(ADD r2,r3,r3) # See the dependency with previous Inst
//	mem[5] = 16'b0001011100000001;	// add immediate reg3 with 1 and store to reg4-->640+1=641 	(ADI r3,r4,1)


	mem[0] = 16'b1111111111111111;	//NOP
	mem[1] = 16'b0011001000000001;	// store 128 to reg1												(LHI r1,128)
	mem[2] = 16'b0011010000000001;	// store 128 to reg2												(LHI r2,128)
	mem[3] = 16'b1100001010000010;	// Branch if [reg1] == [reg2] to PC+Immediate=3+2 		(BEQ r1,r2,2) # It will jump to 5th location , 2cycles will be wasted
	mem[4] = 16'b0000001010011000;	// (ADD r1,r2,r3) # Will not be executed
	mem[5] = 16'b0000001010011000;	// (ADD r1,r2,r3) [r1]=128, [r2]=128 [r3]=128+128=256
	

//	mem[0] = 16'b1111111111111111;	//NOP
//	mem[1] = 16'b0011001000000001;	// store 128 to reg1												(LHI r1,128)
//	mem[2] = 16'b0011010000000001;	// store 128 to reg2												(LHI r2,128)
//	mem[3] = 16'b1001101001000000;	// Jump to address in reg1 and store PC+1 in reg5 
//	mem[4] = 16'b0000001101011000;	// r3<--r1+r5  [r3]=128+4=132
//	mem[5] = 16'b0000011010100000;	// r4<--r3+r2	[r4]=132+128=260
//	mem[128] = 16'b0000001010011000;	// (ADD r1,r2,r3)															[r3]=128+128=256
//	mem[129] = 16'b0000001011100000;	// (ADD r1,r3,r4)															[r4]=256+128=384
//	mem[130] = 16'b0001011111000100;	// add immediate reg3 with 4 and store to reg7-->256+4=260 	(ADI r3,r7,4)
//	mem[131] = 16'b1001110101000000;	// Jump to address in reg5 and store PC+1 in reg6 #like we are returming 
//
////	mem[0] = 16'b1111111111111111;
////	mem[1] = 16'b0011001000000001;
////	mem[2] = 16'b0011010000000001;
////	mem[3] = 16'b1000101001111101;
////	mem[4] = 16'b0000001010011000;
////	mem[5] = 16'b0000001010011000;
////	mem[128] = 16'b0000001010011000;
////	mem[129] = 16'b0000001010011000;
////	mem[130] = 16'b0001011111000100;
////	mem[131] = 16'b1001110101000000;
//
//
//	mem[0] = 16'b1111111111111111;
//	mem[1] = 16'b0011010000000001;
//	mem[2] = 16'b0100001010000001;
//	mem[3] = 16'b0000011001001000;
	
end

endmodule 


