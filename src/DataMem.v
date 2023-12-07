`timescale 1ns / 1ps
module DataMem# (parameter BITS_DATA=8, //Byte
       parameter BITS_ADDR=8 //256 (60 para el programa)
        )(
    input [BITS_ADDR-3:0] AluResult,
    input [31:0] WriteData,
    input CLK,
    input WE,
    output [31:0] ReadData
    );
    
    //wire [BITS_ADDR:0]valid;
    wire [BITS_ADDR-1:2] ADDR;
    
    reg [7:0] RAM0 [0:(2**BITS_ADDR)/4-1]; //Memoria LSB
    reg [7:0] RAM1 [0:(2**BITS_ADDR)/4-1];
    reg [7:0] RAM2 [0:(2**BITS_ADDR)/4-1];
    reg [7:0] RAM3 [0:(2**BITS_ADDR)/4-1]; //Memoria MSB
    
    assign ADDR = AluResult;
    //assign NoConn = AluResult[31:BITS_ADDR-1];
    //assign WEInt = {4{WE}};
    
    
    always @ (posedge CLK) begin
        if(WE) begin
                RAM3[ADDR] <= WriteData[7:0];
                RAM2[ADDR] <= WriteData[15:8];
                RAM1[ADDR] <= WriteData[23:16];
                RAM0[ADDR] <= WriteData[31:24];
        end
    end
    
    assign ReadData[7:0] = RAM3[ADDR];
    assign ReadData[15:8] = RAM2[ADDR];
    assign ReadData[23:16] = RAM1[ADDR];
    assign ReadData[31:24] = RAM0[ADDR];
    
generate
  for (genvar i = 0; i < (2**BITS_ADDR)/4; i = i + 1) begin
    initial begin
      RAM0[i] = 8'h00; // Initialize each element to zero
      RAM1[i] = 8'h00; // Initialize each element to zero
      RAM2[i] = 8'h00; // Initialize each element to zero
      RAM3[i] = 8'h00; // Initialize each element to zero
    end
  end
endgenerate
endmodule
