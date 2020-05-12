module top(
    input clk,
    input rst,
    input succ,
    input step,
    input [2:0] sel,
    input m_rf,
    input inc,
    input dec,
    output [15:0] led,
    output [7:0] an,
    output [6:0] ca,
    output [31:0] seg_toprint,
    output run,  //for test
    output [31:0] m_data,    //for test
    output [31:0] rf_data
    );
//    wire [31:0] rf_data;
    wire Jump,Branch,Reg_Dst,RegWrite,MemtoReg,MemWrite,ALUsrc,ALUzero;
    wire [2:0] ALUop;
    wire [31:0] pc_in,pc_out,instr,rf_rd1,rf_rd2,alu_y,m_rd;
//    wire run;
    wire [15:0] m_rf_addr;
    
    //connect with dbu
    dbu my_dbu(.clk(clk),.rst(rst),.succ(succ),.step(step),.sel(sel),.m_rf(m_rf),.inc(inc),.dec(dec),
        .m_data(m_data),.rf_data(rf_data),.Jump(Jump),.Branch(Branch),.Reg_Dst(Reg_Dst),.RegWrite(RegWrite),
        .MemtoReg(MemtoReg),.MemWrite(MemWrite),.ALUop(ALUop),.ALUsrc(ALUsrc),.ALUzero(ALUzero),.pc_in(pc_in),
        .pc_out(pc_out),.instr(instr),.rf_rd1(rf_rd1),.alu_y(alu_y),.m_rd(m_rd),.run(run),.m_rf_addr(m_rf_addr),
        .led(led),.an(an),.ca(ca),.seg_toprint(seg_toprint));
    
    //connect with cpu
    cpu my_cpu(.clk(clk),.rst(rst),.run(run),.m_data(m_data),.rf_data(rf_data),.m_rf_addr(m_rf_addr),.Jump(Jump),
        .Branch(Branch),.RegDst(Reg_Dst),.RegWrite(RegWrite),.MemtoReg(MemtoReg),.MemWrite(MemWrite),.m(ALUop),
        .ALUsrc(ALUsrc),.zero(ALUzero),.pc(pc_out),.next_pc(pc_in),.instruction(instr),.Read_data1(rf_rd1),
        .Read_data2(rf_rd2),.y(alu_y),.Read_data(m_rd));
endmodule
