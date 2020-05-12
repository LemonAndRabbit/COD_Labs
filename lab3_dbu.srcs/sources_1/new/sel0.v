module sel0(
    input clk,
    input rst,
    input m_rf,
    input dec,
    input inc,
    input [31:0] rf_data,
    input [31:0] m_data,
    output reg [15:0] m_rf_addr,
    output [31:0] sel0_seg_toprint
    );
    //时钟取边沿
    reg dec_r1,dec_r2,inc_r1,inc_r2;
    always@(posedge clk)
    begin
        if(rst)
            {dec_r1,dec_r2,inc_r1,inc_r2} <= 4'b0000;
        else
        begin
            dec_r1 <= dec;
            dec_r2 <= dec_r1;
            inc_r1 <= inc;
            inc_r2 <= inc_r1;
        end
    end
    
    //增减地址计数
    always@(posedge clk)
    begin
        if(rst)
            m_rf_addr <= 0;
        else
        begin
            if(inc_r1 & ~inc_r2)
                m_rf_addr <= m_rf_addr + 1;
            else if(dec_r1 & ~dec_r2)
                m_rf_addr <= m_rf_addr - 1;
        end
    end
    
    assign sel0_seg_toprint = m_rf? m_data:rf_data;
endmodule
