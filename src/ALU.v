`timescale 1ns / 1ps
module ALU(
    input [31:0] A,B,
    input [2:0] ALUControl,
    output reg [31:0] Result,
    output Zero
    );
//AND
wire [31:0] AND;
assign AND = A&B;
//OR
wire [31:0] OR;
assign OR = A|B;
//XOR
wire [31:0] XOR;
assign XOR = A^B;
//ADD & Substract
wire [31:0] B_mux,Add,Substract; //multiplexor para la entrada B
wire add_sub;
assign add_sub = ALUControl[0];
assign B_mux = add_sub? (~B+1):B; //si add_sub es 1 se aplica complemento a 2
assign Add = A + B_mux;//desbordamiento en cout
assign Substract = A + B_mux; //en complemento a 2 se soluciona
//SLT
wire [31:0] SLT;
wire overflow, oversum, AN_1, BN_1,SUMN_1,alucontrol1;
assign AN_1 = A[31];
assign BN_1 = B[31];
assign SUMN_1 = Substract[31];
assign alucontrol1 = ALUControl[1];

assign overflow = (~alucontrol1)&(SUMN_1^AN_1)&(~((add_sub^BN_1)^AN_1));
assign oversum = SUMN_1^overflow;
assign SLT = {{31{1'b0}},oversum};

//multiplexor de salida
always @(*)
    case(ALUControl)
        3'b000: Result = Add;
        3'b001: Result = Substract;
        3'b010: Result = AND;
        3'b011: Result = OR;
        3'b101: Result = SLT;
        3'b100: Result = XOR;
        default: Result = AND;
    endcase
//Zero
assign Zero = ~|Result; //Si es cero entonces la bandera está en 1
endmodule
