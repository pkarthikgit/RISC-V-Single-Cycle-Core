`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.12.2025 17:19:10
// Design Name: 
// Module Name: alu
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


module alu( input [31:0] A,B,
            input [2:0]ALUControl,
            output [31:0] Result,
            output cout,N,Z,C,V
    );
    
    wire [31:0]mux_1;
    wire [31:0]mux_2;
    wire [31:0]not_B;
    wire [31:0]sum,A_and_B,A_or_B;
   // wire N,Z,C,V;
   wire slt;
    assign not_b=~B;
    assign mux_1= (ALUControl[0]==1'b1)?~B:B;
    assign {cout,sum}=A + mux_1+ ALUControl[0];
    assign A_and_B= A & B;
    assign A_or_B= A | B;
    assign slt={32'h0,sum[31]};
    
    assign mux_2=  (ALUControl==2'b00)?sum:
                   (ALUControl==3'b01)?sum:
                   (ALUControl==2'b10)?A_and_B:
                   (ALUControl==2'b11)?A_or_B:
                   (ALUControl==3'b101)?slt:32'h0;
                   
    assign Result= mux_2;
    assign Z=&(~Result);
    assign N= Result[31];
    assign C= cout &(~ALUControl[1]);
    assign V=(~ALUControl[1]) & (A[31] ^sum[31]) & (~(A[31] ^ B[31] ^ALUControl[0]));
    
    
 endmodule
