module main_decoder( op,zero,PCSrc,ResultSrc,MemWrite,ALUSrc,ImmSrc,RegWrite,ALUOp);
    input [6:0] op;
    input zero;
    output wire RegWrite,ALUSrc,MemWrite,ResultSrc,PCSrc;
    output wire [1:0]ImmSrc,ALUOp;
    
    wire Branch;
    assign Branch = (op==7'b1100_011)?1'b1:1'b0;
    assign RegWrite= ((op==7'b0000011) || (op==7'b0110_011))? 1'b1:1'b0;
    assign ALUSrc = ((op==7'b0000011) || (op==7'b0100_011))? 1'b1:1'b0;
    assign MemWrite =(op==7'b0100_011)? 1'b1:1'b0;
    assign ResultSrc = (op==7'b0000_011)? 1'b1:1'b0;
    assign Branch = (op==7'b110_0011)?1'b1:1'b0;
    assign ImmSrc = (op==7'b0100_011)?2'b01:(op==7'b1100_011)?2'b10:2'b00;
    assign ALUOp = (op==7'b0110_011)?2'b10:(op==7'b1100_011)?2'b01:2'b00;
    
    assign PCSrc = zero & Branch;
  
    
    

endmodule
