`timescale 1ns / 1ps
module Register_File (
  input RST,
  input [4:0] A1,        // Address for read port 1
  input [4:0] A2,        // Address for read port 2
  input [4:0] A3,        // Address for write port
  input [31:0] WD3,     // Data to be written
  input WE3,            // Write enable signal
  input CLK,            // Clock input
  output [31:0] RD1, // Data from read port 1
  output [31:0] RD2  // Data from read port 2
);

reg [31:0] WEA;
wire [31:0] Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, Q18, Q19, Q20, Q21, Q22, Q23, Q24, Q25, Q26, Q27, Q28, Q29, Q30, Q31;
wire [31:0] Z;

assign Z = 0;

always @(*) begin
    if(WE3) begin
        case (A3)
            5'd1:  WEA = 32'd3;
            5'd2:  WEA = 32'd5;
            5'd3:  WEA = 32'd9;
            5'd4:  WEA = 32'd17;
            5'd5:  WEA = 32'd33;
            5'd6:  WEA = 32'd65;
            5'd7:  WEA = 32'd129;
            5'd8:  WEA = 32'd257;
            5'd9:  WEA = 32'd513;
            5'd10: WEA = 32'd1025;
            5'd11: WEA = 32'd2049;
            5'd12: WEA = 32'd4097;
            5'd13: WEA = 32'd8193;
            5'd14: WEA = 32'd16385;
            5'd15: WEA = 32'd32769;
            5'd16: WEA = 32'd65537;
            5'd17: WEA = 32'd131073;
            5'd18: WEA = 32'd262145;
            5'd19: WEA = 32'd524289;
            5'd20: WEA = 32'd1048577;
            5'd21: WEA = 32'd2097153;
            5'd22: WEA = 32'd4194305;
            5'd23: WEA = 32'd8388609;
            5'd24: WEA = 32'd16777217;
            5'd25: WEA = 32'd33554433;
            5'd26: WEA = 32'd67108865;
            5'd27: WEA = 32'd134217729;
            5'd28: WEA = 32'd268435457;
            5'd29: WEA = 32'd536870913;
            5'd30: WEA = 32'd1073741825;
            5'd31: WEA = 32'd2147483649;
            default: WEA = 32'd1; // Default case
        endcase
    end else WEA = 32'd1;
end

//INSTANCIANDO CADA REG

Register X0(
    .RST(RST),
    .CLK(CLK),
    .D(Z),
    .WE(WEA[0]),
    .Q(Q0)
);

Register X1(
    .RST(RST),
    .CLK(CLK),
    .D(WD3),
    .WE(WEA[1]),
    .Q(Q1)
);

Register X2(
    .RST(RST),
    .CLK(CLK),
    .D(WD3),
    .WE(WEA[2]),
    .Q(Q2)
);

Register X3(
    .RST(RST),
    .CLK(CLK),
    .D(WD3),
    .WE(WEA[3]),
    .Q(Q3)
);

Register X4(
    .RST(RST),
    .CLK(CLK),
    .D(WD3),
    .WE(WEA[4]),
    .Q(Q4)
);

Register X5(
    .RST(RST),
    .CLK(CLK),
    .D(WD3),
    .WE(WEA[5]),
    .Q(Q5)
);

Register X6(
    .RST(RST),
    .CLK(CLK),
    .D(WD3),
    .WE(WEA[6]),
    .Q(Q6)
);

Register X7(
    .RST(RST),
    .CLK(CLK),
    .D(WD3),
    .WE(WEA[7]),
    .Q(Q7)
);

Register X8(
    .RST(RST),
    .CLK(CLK),
    .D(WD3),
    .WE(WEA[8]),
    .Q(Q8)
);

Register X9(
    .RST(RST),
    .CLK(CLK),
    .D(WD3),
    .WE(WEA[9]),
    .Q(Q9)
);

Register X10(
    .RST(RST),
    .CLK(CLK),
    .D(WD3),
    .WE(WEA[10]),
    .Q(Q10)
);

Register X11(
    .RST(RST),
    .CLK(CLK),
    .D(WD3),
    .WE(WEA[11]),
    .Q(Q11)
);

Register X12(
    .RST(RST),
    .CLK(CLK),
    .D(WD3),
    .WE(WEA[12]),
    .Q(Q12)
);

Register X13(
    .RST(RST),
    .CLK(CLK),
    .D(WD3),
    .WE(WEA[13]),
    .Q(Q13)
);

Register X14(
    .RST(RST),
    .CLK(CLK),
    .D(WD3),
    .WE(WEA[14]),
    .Q(Q14)
);

Register X15(
    .RST(RST),
    .CLK(CLK),
    .D(WD3),
    .WE(WEA[15]),
    .Q(Q15)
);

Register X16(
    .RST(RST),
    .CLK(CLK),
    .D(WD3),
    .WE(WEA[16]),
    .Q(Q16)
);

Register X17(
    .RST(RST),
    .CLK(CLK),
    .D(WD3),
    .WE(WEA[17]),
    .Q(Q17)
);

Register X18(
    .RST(RST),
    .CLK(CLK),
    .D(WD3),
    .WE(WEA[18]),
    .Q(Q18)
);

Register X19(
    .RST(RST),
    .CLK(CLK),
    .D(WD3),
    .WE(WEA[19]),
    .Q(Q19)
);

Register X20(
    .RST(RST),
    .CLK(CLK),
    .D(WD3),
    .WE(WEA[20]),
    .Q(Q20)
);

Register X21(
    .RST(RST),
    .CLK(CLK),
    .D(WD3),
    .WE(WEA[21]),
    .Q(Q21)
);

Register X22(
    .RST(RST),
    .CLK(CLK),
    .D(WD3),
    .WE(WEA[22]),
    .Q(Q22)
);

Register X23(
    .RST(RST),
    .CLK(CLK),
    .D(WD3),
    .WE(WEA[23]),
    .Q(Q23)
);

Register X24(
    .RST(RST),
    .CLK(CLK),
    .D(WD3),
    .WE(WEA[24]),
    .Q(Q24)
);

Register X25(
    .RST(RST),
    .CLK(CLK),
    .D(WD3),
    .WE(WEA[25]),
    .Q(Q25)
);

Register X26(
    .RST(RST),
    .CLK(CLK),
    .D(WD3),
    .WE(WEA[26]),
    .Q(Q26)
);

Register X27(
    .RST(RST),
    .CLK(CLK),
    .D(WD3),
    .WE(WEA[27]),
    .Q(Q27)
);

Register X28(
    .RST(RST),
    .CLK(CLK),
    .D(WD3),
    .WE(WEA[28]),
    .Q(Q28)
);

Register X29(
    .RST(RST),
    .CLK(CLK),
    .D(WD3),
    .WE(WEA[29]),
    .Q(Q29)
);

Register X30(
    .RST(RST),
    .CLK(CLK),
    .D(WD3),
    .WE(WEA[30]),
    .Q(Q30)
);

Register X31(
    .RST(RST),
    .CLK(CLK),
    .D(WD3),
    .WE(WEA[31]),
    .Q(Q31)
);
// MUXES

MUX32A1 RD11(
    .IN1(Q1),.IN2(Q2),.IN3(Q3),.IN4(Q4),.IN5(Q5),.IN6(Q6),
    .IN7(Q7),.IN8(Q8),.IN9(Q9),.IN10(Q10),.IN11(Q11),.IN12(Q12),
    .IN13(Q13),.IN14(Q14),.IN15(Q15),.IN16(Q16),.IN17(Q17),.IN18(Q18),
    .IN19(Q19),.IN20(Q20),.IN21(Q21),.IN22(Q22),.IN23(Q23),.IN24(Q24),
    .IN25(Q25),.IN26(Q26),.IN27(Q27),.IN28(Q28),.IN29(Q29),.IN30(Q30),
    .IN31(Q31),.IN0(Q0),
    
    .select(A1),
    .OUT(RD1)
);

MUX32A1 RD22(
    .IN1(Q1),.IN2(Q2),.IN3(Q3),.IN4(Q4),.IN5(Q5),.IN6(Q6),
    .IN7(Q7),.IN8(Q8),.IN9(Q9),.IN10(Q10),.IN11(Q11),.IN12(Q12),
    .IN13(Q13),.IN14(Q14),.IN15(Q15),.IN16(Q16),.IN17(Q17),.IN18(Q18),
    .IN19(Q19),.IN20(Q20),.IN21(Q21),.IN22(Q22),.IN23(Q23),.IN24(Q24),
    .IN25(Q25),.IN26(Q26),.IN27(Q27),.IN28(Q28),.IN29(Q29),.IN30(Q30),
    .IN31(Q31),.IN0(Q0),
    
    .select(A2),
    .OUT(RD2)
);


endmodule

module Register(
    input CLK,
    input [31:0]D,
    input WE,
    input RST,
    output reg [31:0]Q
);

always @(posedge CLK) begin
    if(WE) Q <= D;
    else Q<=Q;
    if(RST) Q<= 32'd0;
end

initial Q <= 32'd0;

endmodule

module MUX32A1 (
    input [31:0] IN0, IN1, IN2, IN3, IN4, IN5, IN6, IN7,
    input [31:0] IN8, IN9, IN10, IN11, IN12, IN13, IN14, IN15,
    input [31:0] IN16, IN17, IN18, IN19, IN20, IN21, IN22, IN23,
    input [31:0] IN24, IN25, IN26, IN27, IN28, IN29, IN30, IN31,
    input [4:0] select,     // 5-bit select signal
    output reg [31:0] OUT          // Output wire
);

always @(*) begin
    case (select)
        5'b00000: OUT = IN0;
        5'b00001: OUT = IN1;
        5'b00010: OUT = IN2;
        5'b00011: OUT = IN3;
        5'b00100: OUT = IN4;
        5'b00101: OUT = IN5;
        5'b00110: OUT = IN6;
        5'b00111: OUT = IN7;
        5'b01000: OUT = IN8;
        5'b01001: OUT = IN9;
        5'b01010: OUT = IN10;
        5'b01011: OUT = IN11;
        5'b01100: OUT = IN12;
        5'b01101: OUT = IN13;
        5'b01110: OUT = IN14;
        5'b01111: OUT = IN15;
        5'b10000: OUT = IN16;
        5'b10001: OUT = IN17;
        5'b10010: OUT = IN18;
        5'b10011: OUT = IN19;
        5'b10100: OUT = IN20;
        5'b10101: OUT = IN21;
        5'b10110: OUT = IN22;
        5'b10111: OUT = IN23;
        5'b11000: OUT = IN24;
        5'b11001: OUT = IN25;
        5'b11010: OUT = IN26;
        5'b11011: OUT = IN27;
        5'b11100: OUT = IN28;
        5'b11101: OUT = IN29;
        5'b11110: OUT = IN30;
        5'b11111: OUT = IN31;
        default: OUT = 32'b0; // Default output value
    endcase
end

endmodule
