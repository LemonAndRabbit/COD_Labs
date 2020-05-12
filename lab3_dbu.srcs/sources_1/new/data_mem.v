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
    //如果将 clk & run 接入分布式RAM的clk口，按一次succ将会有两个时钟上升沿，故将run接入MemWrite口
    dist_mem_gen_data_mem data_dist_mem(.a(address[9:2]),.d(Write_data),.clk(clk),.we(MemWrite & run),.spo(Read_data),.dpra(dpra[9:2]),.dpo(dpo));
endmodule