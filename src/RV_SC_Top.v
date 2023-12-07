`timescale 1ns / 1ps
module RV_SC_Top#(parameter BITS_ADDR = 8,parameter BITS_DATA = 8,
parameter IN_ADDR1 = 32'h00000100,parameter IN_ADDR2 = 32'h00000101,
parameter IN_ADDR3 = 32'h00000102,
parameter OUT_ADDR1 = 32'h000000FF,parameter LED_PORT = 4'd4,
parameter OUT_ADDR2 = 32'h000000FE,parameter LED_RGB_PORT1 = 4'd3,
parameter OUT_ADDR3 = 32'h000000FD,parameter LED_RGB_PORT2 = 4'd3,
parameter BTN_PORT = 4'd3, parameter SW_PORT = 4'd2 )
    (
    input CLK,
    input [1:0]SW,
    input [3:0]BTN,
    input io,
    output vdd,
    output gnd,
    output [3:0]LEDS,
    output [2:0]LED_RGB1,
    output [2:0]LED_RGB2
    );
    assign vdd = 1;
    assign gnd = 0;
    //wire ZeroOut;
    wire RST;
    assign RST = BTN[0];
    
    wire [31:0]Instr;
    
    //Cosas PC
    wire [31:0]PCNext,PCPlus4,PCTarget;
    reg [31:0] PC; 
    //IO Control Unit
    wire PCSrc,MemWrite,AluSrc,RegWrite;
    wire [1:0] ResultSrc;
    wire [2:0] ImmSrc,ALUControl;
    
    //IO Register File
    wire [31:0]RD1,RD2;
    //Extend
    wire [31:0] ImmExt;
    //ALU
    wire [31:0] SrcA,SrcB,AluResult;
    wire [BITS_ADDR-3:0] DMA;
    wire zero;
    //DataMem
    wire [31:0] ReadData;
    wire [BITS_ADDR-1:0] IMA;
    //Otros
    wire [31:0] IN_DATA1;
    wire [31:0] IN_DATA2;
    wire [31:0] IN_DATA3;
    reg [31:0] IOMUX;
    reg [31:0] Result;
    
    assign IMA = PC[BITS_ADDR-1:0];
    
    ROM_memory #(.BITS_DATA(BITS_DATA),.BITS_ADDR(BITS_ADDR)) Instruction_Memory(
        //Entradas
        .PC(IMA),
        //Salidas
        .ReadInstr(Instr)

    );
    
    ControlUnit Control_Unit(
        //Entradas
        .op(Instr[6:0]),
        .funct3(Instr[14:12]),
        .funct75(Instr[30]),
        .zero(zero),
        //Salidas
        .PCSrc(PCSrc),
        .MemWrite(MemWrite),
        .AluSrc(AluSrc),
        .RegWrite(RegWrite),
        .ResultSrc(ResultSrc),
        .ImmSrc(ImmSrc),
        .ALUControl(ALUControl)
        
    );
    
    Register_File Register_File(
        //Entradas
        .RST(RST),
        .CLK(CLK),
        .A1(Instr[19:15]),
        .A2(Instr[24:20]),
        .A3(Instr[11:7]),
        .WE3(RegWrite),
        .WD3(Result),
        //Salidas
        .RD1(RD1),
        .RD2(RD2)
    
    );
    
    Extend Extend(
        //Entradas
        .Instr(Instr[31:7]),
        .ImmSrc(ImmSrc),
        //Salidas
        .ImmExt(ImmExt)    
    
    );
    
    assign SrcA = RD1;
    assign SrcB = AluSrc ? ImmExt:RD2;
    
    ALU ALU(
        //Entradas
        .A(SrcA),
        .B(SrcB),
        .ALUControl(ALUControl),
        //Salidas
        .Result(AluResult),
        .Zero(zero)
    );
    
    assign DMA = AluResult[BITS_ADDR-1:2];
    
    DataMem #(.BITS_DATA(BITS_DATA),.BITS_ADDR(BITS_ADDR)) Data_Memory(
        //Entradas
        .CLK(CLK),
        .AluResult(DMA),
        .WriteData(RD2),
        .WE(MemWrite),
        
        //Salidas
        .ReadData(ReadData)
    );
    //Mux 4 a 1 para Result
    
    always @(*) begin
        case(ResultSrc)
            2'b00 : Result <= AluResult;
            2'b01 : Result <= IOMUX;
            2'b10 : Result <= PCPlus4;
            2'b11 : Result <= ImmExt;
            default : Result <= AluResult;
        endcase
    end
    
    //PC FlipFlop
    always @(posedge CLK) begin
        if(RST) PC <= 0;
        else PC <= PCNext;
    end
    //PCSrc Mux 2 a 1
    assign PCTarget = PC+ImmExt;
    assign PCPlus4 = PC+4;
    assign PCNext = (PCSrc ? PCTarget : PCPlus4);
   
    
    // PERIFERICOS
    // SWITCHES IN
    INDriver #(.ADDRESS_ENABLE(IN_ADDR1),.BITS_PORT(SW_PORT)) Switches(
        .enable_addr(AluResult),
        .data_in(SW),
        .data_out(IN_DATA1)
    );
    
    INDriver #(.ADDRESS_ENABLE(IN_ADDR2),.BITS_PORT(BTN_PORT)) BTNs(
        .enable_addr(AluResult),
        .data_in(BTN[3:1]),
        .data_out(IN_DATA2)
    );
    // Sensor Prox
    INDriver #(.ADDRESS_ENABLE(IN_ADDR3),.BITS_PORT(1)) IO0(
        .enable_addr(AluResult),
        .data_in(io),
        .data_out(IN_DATA3)
    );

    //Result Mux
    always @(*) begin
        case(AluResult)
            IN_ADDR1: IOMUX = IN_DATA1;
            IN_ADDR2: IOMUX = IN_DATA2;
            IN_ADDR3: IOMUX = IN_DATA3;
            default: IOMUX = ReadData;
        endcase
    end
    //assign IOMUX = (AluResult == IN_ADDR1) ? IN_DATA : ReadData;
    
    //LEDS OUT
    OUTDriver #(.ADDRESS_ENABLE(OUT_ADDR1),.BITS_PORT(LED_PORT)) LEDOut(
        .CLK(CLK),
        .RST(RST),
        .enable_addr(AluResult),
        .data_in(RD2[LED_PORT-1:0]),
        .data_out(LEDS)
    );
    
    OUTDriver #(.ADDRESS_ENABLE(OUT_ADDR2),.BITS_PORT(LED_RGB_PORT1)) LEDRGB1(
        .CLK(CLK),
        .RST(RST),
        .enable_addr(AluResult),
        .data_in(RD2[LED_RGB_PORT1-1:0]),
        .data_out(LED_RGB1)
    );
    
    OUTDriver #(.ADDRESS_ENABLE(OUT_ADDR3),.BITS_PORT(LED_RGB_PORT2)) LEDRGB2(
        .CLK(CLK),
        .RST(RST),
        .enable_addr(AluResult),
        .data_in(RD2[LED_RGB_PORT2-1:0]),
        .data_out(LED_RGB2)
    );
    
endmodule
