module instr_mem( 
    input [31:0]A,
    input rst,
    output [31:0]RD);
    
    reg [31:0]MEM[1023:0];
     initial begin
        MEM[0] = 32'hFFC4A303;  // lw x6, -4(x9)
        MEM[1] = 32'h00832383;
        MEM[2] = 32'h0064A423;
        MEM[3] = 32'h0062E233;
    end

    assign RD=(rst==1'b0)?32'h00000000:MEM[A[31:2]];
   
    endmodule
