`timescale 1ns / 1ps

module test0;
    reg clk,rst;
    reg [31:0] m_rf_addr;
    wire [31:0] m_data;
    
    wire [31:0] y;
    wire [31:0] pc;
    wire [2:0] m;
    wire [31:0] instruction;
    wire [31:0] b,Read_data1,Read_data2,Write_data;
    wire ALUsrc,RegWrite,MemtoReg;
    wire [31:0] extended;
    top test_top(.clk(clk),.rst(rst),.m_rf_addr(m_rf_addr),.m_data(m_data),.y(y),.pc(pc),.m(m),.instruction(instruction),.b(b),.Read_data1(Read_data1),.Read_data2(Read_data2),
            .ALUsrc(ALUsrc),.extended(extended),.RegWrite(RegWrite),.Write_data(Write_data),.MemtoReg(MemtoReg));
    
    parameter PERIOD = 2, 
    CYCLE = 50;
    
    initial
    begin
        clk = 0;
        repeat (2 * CYCLE)
            #(PERIOD/2) clk =~clk;
        $finish;
    end
    
    initial
    begin
        m_rf_addr = 32'hffff_ffff;
        rst = 1;
        #PERIOD;
        m_rf_addr = 32'hffff_ffff;
        rst = 0;
        #(PERIOD*40);
        m_rf_addr = 32'h0000_0008;
    end
    
endmodule
