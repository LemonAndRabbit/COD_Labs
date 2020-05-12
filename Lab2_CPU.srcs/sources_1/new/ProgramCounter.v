module ProgramCounter(
    input rst,
    input clk,
    input [31:0] next_pc,
    output reg [31:0] pc
    );
    always@(posedge clk)
    begin
        pc <= rst? 0:next_pc;
    end
endmodule
