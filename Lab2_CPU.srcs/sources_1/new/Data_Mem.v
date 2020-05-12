module Data_Mem(
    input [31:0] address,
    input [31:0] dpra,
    input [31:0] Write_data,
    input MemWrite,
    input clk,
    output [31:0] Read_data,
    output [31:0] dpo
    );
    dist_mem_gen_data_mem data_dist_mem(.a(address[9:2]),.d(Write_data),.clk(clk),.we(MemWrite),.spo(Read_data),.dpra(dpra[9:2]),.dpo(dpo));
endmodule
