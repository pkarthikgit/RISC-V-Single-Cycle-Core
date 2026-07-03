`include "ALU_decoder.v"
`include "main_decoder.v"

module Control_Unit_Top(zero,Op,funct3,funct7,PCSrc,ResultSrc,MemWrite,ALUSrc,ImmSrc,RegWrite,ALUControl);
    input zero;
    input [6:0]Op;
    input [2:0]funct3;
    input [2:0]ALUControl;
    input [6:0]funct7;
    output ResultSrc,MemWrite,ALUSrc,RegWrite,PCSrc;
    output [1:0]ImmSrc;
    wire [1:0]ALUOp;
    
    main_decoder Main_dec(.op(Op),
                         .zero(zero),
                         .PCSrc(PCSrc),
                         .ResultSrc(ResultSrc),
                         .MemWrite(MemWrite),
                         .ALUSrc(ALUSrc),
                         .ImmSrc(ImmSrc),
                         .RegWrite(RegWrite),
                         .ALUOp(ALUOp));
                         
    ALU_decoder ALU_dec(.ALUOp(ALUOp),
                        .op5(Op[6:0]),
                        .funct3(funct3),
                        .funct7(funct7),
                        .ALUControl(ALUControl));
   
                        
                        

endmodule
