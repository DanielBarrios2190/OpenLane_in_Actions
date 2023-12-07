`timescale 1ns / 1ps
module ROM_memory
	# (parameter BITS_DATA=8, //Byte
       parameter BITS_ADDR=8 //256
        )(				
	input [BITS_ADDR-1:0] PC,
	output reg [31:0] ReadInstr	
	);

//Ya que se tienen que rearmar las instrucciones a 32 bits se unen
wire [BITS_ADDR-1:0] ADDR;
reg [BITS_DATA-1:0] ROM [0: (2**BITS_ADDR)-1];

assign ADDR = PC;

always @ (*) begin //Little endian
    ReadInstr[7:0] <= ROM[ADDR+3];
    ReadInstr[15:8] <= ROM[ADDR+2];
    ReadInstr[23:16] <= ROM[ADDR+1];
    ReadInstr[31:24] <= ROM[ADDR];
end

generate
  for (genvar i = 0; i < (2**BITS_ADDR); i = i + 1) begin
    initial begin
      ROM[i] = 8'h00; // Initialize each element to zero
    end
  end
endgenerate

initial
 $readmemh("IOSecs.txt",	
	    ROM,	
	    0,			
	    (2**BITS_ADDR)-1
 );
endmodule
