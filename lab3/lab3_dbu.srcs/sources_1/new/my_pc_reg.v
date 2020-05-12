module ProgramCounter(
    input rst,
    input clk,
    input [31:0] next_pc,
    input run,
    output reg [31:0] pc
    );
    always@(posedge clk)
    begin
//        pc = rst? 0:next_pc;
        if(rst)
            pc <= 0;
        else if(run)
            pc <= next_pc;
    end
endmodule
