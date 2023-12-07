`timescale 1ns / 1ps
module ControlUnit(
    input [6:0] op,
    input [2:0] funct3,
    input funct75,
    input zero,
    output PCSrc,
    output reg [1:0] ResultSrc,
    output reg MemWrite,
    output reg [2:0] ALUControl,
    output reg AluSrc,
    output reg [2:0] ImmSrc,
    output reg RegWrite
    );
    reg Jump, Branch;
    reg [1:0]AluOp;
    
    
    //Main Deco
    //D.C. = Dont Care, se hizo pequeño analisis para poner 0 o 1
    always @(*) begin
        case(op[6:0]) //Main Decoder Table
            7'b0000011 : begin //LW
                RegWrite <= 1'b1;
                ImmSrc <= 3'b000;
                AluSrc <= 1'b1;
                MemWrite <= 1'b0;
                ResultSrc <= 2'b01;
                Branch <= 1'b0;
                AluOp <= 2'b00;
                Jump <= 1'b0;
            end 
            7'b0100011 : begin //SW
                RegWrite <= 1'b0;
                ImmSrc <= 3'b001;
                AluSrc <= 1'b1;
                MemWrite <= 1'b1;
                ResultSrc <= 2'b00; //D.C.
                Branch <= 1'b0;
                AluOp <= 2'b00;
                Jump <= 1'b0;
            end
            7'b0110011 : begin //R-type
                RegWrite <= 1'b1;
                ImmSrc <= 3'b010; //D.C.
                AluSrc <= 1'b0;
                MemWrite <= 1'b0;
                ResultSrc <= 2'b00;
                Branch <= 1'b0;
                AluOp <= 2'b10;
                Jump <= 1'b0;
            end
            7'b1100011 : begin //beq
                RegWrite <= 1'b0;
                ImmSrc <= 3'b010;
                AluSrc <= 1'b0;
                MemWrite <= 1'b0;
                ResultSrc <= 2'b00; //D.C.
                Branch <= 1'b1;
                AluOp <= 2'b01;
                Jump <= 1'b0;
            end
            7'b0010011 : begin //I-type
                RegWrite <= 1'b1;
                ImmSrc <= 3'b000;
                AluSrc <= 1'b1;
                MemWrite <= 1'b0;
                ResultSrc <= 2'b00;
                Branch <= 1'b0;
                AluOp <= 2'b10;
                Jump <= 1'b0;
            end
            7'b1101111 : begin //jal
                RegWrite <= 1'b1;
                ImmSrc <= 3'b011;
                AluSrc <= 1'b0; //D.C.
                MemWrite <= 1'b0;
                ResultSrc <= 2'b10;
                Branch <= 1'b0;
                AluOp <= 2'b00; //D.C.
                Jump <= 1'b1;
            end
            7'b0110111 : begin //lui
                RegWrite <= 1'b1;
                ImmSrc <= 3'b100;
                AluSrc <= 1'b0; //D.C.
                MemWrite <= 1'b0;
                ResultSrc <= 2'b11;
                Branch <= 1'b0;
                AluOp <= 2'b00; //D.C.
                Jump <= 1'b0;
            end
            default : begin //Should never occur
                RegWrite <= 1'b0;
                ImmSrc <= 3'b000;
                AluSrc <= 1'b0;
                MemWrite <= 1'b0;
                ResultSrc <= 2'b00;
                Branch <= 1'b0;
                AluOp <= 2'b00;
                Jump <= 1'b0;
            
            end
        endcase
    end
    
    assign PCSrc = (zero && Branch) || Jump;
    // ALU Deco
     always @(*) begin
        case(AluOp)
            2'b00 : ALUControl <= 3'b000;
            2'b01 : ALUControl <= 3'b001;
            2'b10 : begin
                case(funct3)
                    3'b010 : ALUControl <= 3'b101;
                    3'b110 : ALUControl <= 3'b011;
                    3'b111 : ALUControl <= 3'b010;
                    3'b100 : ALUControl <= 3'b100;
                    3'b000 : begin
                        if({op[5],funct75} == 2'b11) ALUControl <= 3'b001;
                        else ALUControl <= 3'b000;                   
                     end
                    default : ALUControl <= 3'b000; // Never
                endcase
            end
            default : ALUControl <= 3'b000; //Never
        endcase
    end
    
endmodule
