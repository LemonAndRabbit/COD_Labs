module Instruction_Memory(
    input [31:0] Read_address,
    output [31:0] Instruction
    );
    dist_mem_gen_0 ins_dist_mem(.a(Read_address[9:2]),.spo(Instruction));
endmodule