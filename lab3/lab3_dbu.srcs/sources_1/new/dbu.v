module dbu(
    input clk,
    input rst,
    input succ,
    input step,
    input [2:0] sel,
    input m_rf,
    input inc,
    input dec,
    input [31:0] m_data,
    input [31:0] rf_data,
    input Jump,
    input Branch,
    input Reg_Dst,
    input RegWrite,
//    input Memread,    //no such signal
    input MemtoReg,
    input MemWrite,
    input [2:0] ALUop,
    input ALUsrc,
    input ALUzero,
    input [31:0] pc_in,
    input [31:0] pc_out,
    input [31:0] instr,
    input [31:0] rf_rd1,
    input [31:0] rf_rd2,
    input [31:0] alu_y,
    input [31:0] m_rd,
    output run,
    output [15:0] m_rf_addr,
    output [15:0] led,
    output [7:0] an,
    output [6:0] ca,
    output reg [31:0] seg_toprint   //for test
    );       
    //øÿ÷∆run–≈∫≈
    control_run my_control_run(.clk(clk),.rst(rst),.succ(succ),.step(step),.run(run));
    
    //if (sel == 0)
    wire [31:0] sel0_seg_toprint;
    sel0 my_sel0(.clk(clk),.rst(rst),.m_rf(m_rf),.dec(dec),.inc(inc),.rf_data(rf_data),.m_data(m_data),
                .m_rf_addr(m_rf_addr),.sel0_seg_toprint(sel0_seg_toprint));
    
    //detemine what to print by seg
//    reg [31:0] seg_toprint;   //moved for test
    always@(*)
    begin
        case(sel)
            3'd0: seg_toprint = sel0_seg_toprint;
            3'd1: seg_toprint = pc_in;
            3'd2: seg_toprint = pc_out;
            3'd3: seg_toprint = instr;
            3'd4: seg_toprint = rf_rd1;
            3'd5: seg_toprint = rf_rd2;
            3'd6: seg_toprint = alu_y;
            3'd7: seg_toprint = m_rd;
        endcase 
    end
    
    //seg
    control_seg my_control_seg(.seg_toprint(seg_toprint),.clk(clk),.an(an),.ca(ca));
    
    //led
    assign led = (sel == 0)? m_rf_addr:{4'b0,Jump, Branch, Reg_Dst, RegWrite, 1'b1, MemtoReg, MemWrite, ALUop, ALUsrc, ALUzero};
    
endmodule
