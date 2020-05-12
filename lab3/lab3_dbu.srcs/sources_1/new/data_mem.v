module Data_Mem(
    input [31:0] address,
    input [31:0] dpra,
    input [31:0] Write_data,
    input MemWrite,
    input clk,
    input run,
    output [31:0] Read_data,
    output [31:0] dpo
    );
    //����� clk & run ����ֲ�ʽRAM��clk�ڣ���һ��succ����������ʱ�������أ��ʽ�run����MemWrite��
    dist_mem_gen_data_mem data_dist_mem(.a(address[9:2]),.d(Write_data),.clk(clk),.we(MemWrite & run),.spo(Read_data),.dpra(dpra[9:2]),.dpo(dpo));
endmodule