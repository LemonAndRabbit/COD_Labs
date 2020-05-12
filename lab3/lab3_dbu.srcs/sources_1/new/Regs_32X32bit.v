module Regs_32x32bit(
    input [4:0] Read_register1,
    input [4:0] Read_register2,
    input [4:0] Write_register,
    input [4:0] m_rf_addr,
    input [31:0] Write_data,
    input clk,
    input run,
    input RegWrite,
    output [31:0] Read_data1,
    output [31:0] Read_data2,
    output [31:0] rf_data
    );
    reg [31:0] regs[31:0];  //32*32 regs
    assign Read_data1 = (Read_register1==0)? 0:regs[Read_register1];
    assign Read_data2 = (Read_register2==0)? 0:regs[Read_register2];
    assign rf_data = (m_rf_addr==0)? 0:regs[m_rf_addr];
    
    always@(posedge clk)
    begin
        if(RegWrite & run)
            regs[Write_register] <= Write_data;
    end
        
endmodule
