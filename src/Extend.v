`timescale 1ns / 1ps
module Extend(
    input [24:0] Instr,
    input [2:0] ImmSrc,
    output reg [31:0] ImmExt
    );
    /*
    always@(*) begin
        case(ImmSrc)
            3'b000: ImmExt <= {{20{Instr[31]}},Instr[31:20]}; //12 bits para tipo I
            3'b001: ImmExt <= {{20{Instr[31]}},Instr[31:25],Instr[11:7]}; //12 bits para tipo S 
            3'b010: ImmExt <= {{20{Instr[31]}},Instr[7],Instr[30:25],Instr[11:8],1'b0}; //13 bits para tipo B
            3'b011: ImmExt <= {{12{Instr[31]}},Instr[19:12],Instr[20],Instr[30:21],1'b0}; //21 bits para tipo J
            3'b100: ImmExt <= {Instr[31:12],12'b0}; //20 bits para tipo U
            default: ImmExt <= Instr;
        endcase
    end
    */
    always@(*) begin
        case(ImmSrc)
            3'b000: ImmExt <= {{20{Instr[24]}},Instr[24:13]}; //12 bits para tipo I
            3'b001: ImmExt <= {{20{Instr[24]}},Instr[24:18],Instr[4:0]}; //12 bits para tipo S 
            3'b010: ImmExt <= {{20{Instr[24]}},Instr[0],Instr[23:18],Instr[4:1],1'b0}; //13 bits para tipo B
            3'b011: ImmExt <= {{12{Instr[24]}},Instr[12:5],Instr[13],Instr[23:14],1'b0}; //21 bits para tipo J
            3'b100: ImmExt <= {Instr[24:5],12'b0}; //20 bits para tipo U
            default: ImmExt <= Instr;
        endcase
    end
    
endmodule
