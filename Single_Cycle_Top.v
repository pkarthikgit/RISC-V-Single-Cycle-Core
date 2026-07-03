`include "Program_counter.v"
`include "instruction_mem.v"
`include "sign_extend.v"
`include "alu.v"
`include "Control_unit_Top.v"
`include "data_memory.v"
`include "PC_Adder.v"

module Single_Cycle_top(clk,rst);
    input clk,rst;
    wire [31:0]PC_Top,RD_Instr,RD1_Top,Imm_Ext_Top,ALUResult_Top,ReadData_Top,PC_Next_Top,RD2_Top,SrcB,Result;
    wire RegWrite_Top,MemWrite,ALUSrc,ResultSrc;
    wire [2:0]ALU_Control_Top;
    wire [1:0]Imm_Src_Top;
    reg [31:0] IR_dbg;
    
    always @(posedge clk) begin
    IR_dbg <= RD_Instr;
    end
    
    P_C PC(.clk(clk),
           .rst(rst),
           .PC_NEXT(PC_Next_Top),
           .PC(PC_Top));
           
    PC_Adder PC_adder(.a(PC_Top),.b(32'h4),.s(PC_Next_Top));
    
    instr_mem IM(.A(PC_Top),
                 .rst(rst),
                 .RD(RD_Instr));
                 
    reg_file Reg_File(.clk(clk),
                      .rst(rst),
                      .A1(IR_dbg[19:15]),//RS1
                      .A2(IR_dbg[24:20]),
                      .A3(IR_dbg[11:7]),
                      .WD3(Result),
                      .WE3(RegWrite_Top),
                      .RD1(RD1_Top),
                      .RD2(RD2_Top));
    sign_extend Sign_ext(.In(IR_dbg),//immediate value
                         .Imm_Src(Imm_Src_Top[0]),
                         .Imm_Ext(Imm_Ext_Top));
    mux Register_to_ALU(.a(RD2_Top), 
                        .b(Imm_Ext_Top),
                        .s(ALUSrc), 
                        .c(SrcB));
    alu ALU(.A(RD1_Top),
            .B(SrcB),
            .ALUControl(ALU_Control_Top),//control unit
            .Result(ALUResult_Top),
            .cout(),
            .N(),
            .Z(),
            .C(),
            .V());
            
    Control_Unit_Top CU(.zero(),
                    .funct3(IR_dbg[14:12]),
                     .Op(IR_dbg[6:0]),
                     
                     .funct7(),//not applicable for load word
                     .PCSrc(),
                     .ResultSrc(ResultSrc),
                     .MemWrite(MemWrite),
                     .ALUSrc(ALUSrc),
                     .ImmSrc(Imm_Src_Top),
                     .RegWrite(RegWrite_Top),
                     .ALUControl(ALU_Control_Top));
    data_memory data_mem(.clk(clk),
                         .rst(rst),
                         .A(ALUResult_Top),
                         .RD(ReadData_Top),
                         .WD(RD2_Top),
                         .WE(MemWrite));
                         
     mux Data_Mem_to_Reg(.a(ALUResult_Top),
                         .b(ReadData_Top),                   
                         .s(ResultSrc),
                         .c(Result));       
endmodule
