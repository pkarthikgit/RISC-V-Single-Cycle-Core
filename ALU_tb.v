`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.12.2025 17:56:50
// Design Name: 
// Module Name: alu_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module alu_tb( );
   reg [31:0]A,B;
   reg [2:0]ALUControl;
   wire [31:0] Result;
   wire N,Z,C,V;
   integer i;
   alu ALU1(.A(A),.B(B),.ALUControl(ALUControl),.Result(Result),.N(N),.C(C),.V(V),.Z(Z));
   
   task reset();
    begin
        A=32'd0;
        B=32'd0;
        ALUControl=3'd0;
    end
   endtask
   
   initial begin
        reset();
        #10;
        $monitor("A=%d | B=%d | ALUControl=%d | Result=%d",A,B,ALUControl,Result);
        for(i=0;i<=3'd6;i=i+1)
            begin
            A=$random;
            B=$random;
            ALUControl=i;
            #10;
            end
        
        #100 $finish;
   end
endmodule
