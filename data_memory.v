module data_memory(clk,rst,A,RD,WD,WE);
    input clk,rst;
    input [31:0] A,WD;
    input WE;
    output [31:0]RD;
    
    reg [31:0]DATA_MEM[1023:0];
    
      assign RD = (~rst) ? 32'd0 : DATA_MEM[A];
    
    always@(posedge clk)
    begin
        if(WE==1'b1)
        begin
            DATA_MEM[A]<=WD;     
        end
    end
   always@(posedge clk)begin
        DATA_MEM[28] = 32'h00000020;
        DATA_MEM[40] = 32'h00000002;
        DATA_MEM[5] =  32'h00000001;
    end
endmodule
