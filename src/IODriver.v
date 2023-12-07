`timescale 1ns / 1ps

module INDriver#(parameter ADDRESS_ENABLE = 32'hFFFFFFFF,parameter BITS_PORT = 8)(
    input [31:0]enable_addr,
    input [BITS_PORT-1:0]data_in,
    output reg [31:0]data_out
    );
    always @(*) begin
        if(enable_addr == ADDRESS_ENABLE)
            data_out = {{(32-BITS_PORT){1'b0}},data_in};
        else
            data_out = 32'd0;
    end
    
    
endmodule

module OUTDriver#(parameter ADDRESS_ENABLE = 32'hFFFFFFFF,parameter BITS_PORT = 3)(
    input [31:0]enable_addr,
    input [BITS_PORT-1:0]data_in,
    input CLK,
    input RST,
    output reg [BITS_PORT-1:0]data_out
    );
    always @(posedge CLK) begin
        if(enable_addr == ADDRESS_ENABLE)
            data_out = data_in;
        else
            data_out = data_out;
        if(RST)
            data_out = 0;
    end
    
endmodule
