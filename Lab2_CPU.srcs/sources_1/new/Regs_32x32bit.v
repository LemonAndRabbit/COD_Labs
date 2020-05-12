module Regs_32x32bit(
    input [4:0] Read_register1,
    input [4:0] Read_register2,
    input [4:0] Write_register,
    input [31:0] Write_data,
    input clk,
    input RegWrite,
    output [31:0] Read_data1,
    output [31:0] Read_data2
    );
    reg [31:0] regs[31:0];  //32*32 regs
    assign Read_data1 = (Read_register1==0)? 0:regs[Read_register1];
    assign Read_data2 = (Read_register2==0)? 0:regs[Read_register2];
    
    always@(posedge clk)
    begin
        if(RegWrite)
            regs[Write_register] <= Write_data;
    end
        
endmodule
