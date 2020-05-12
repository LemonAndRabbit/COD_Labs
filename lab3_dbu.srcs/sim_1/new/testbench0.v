module testbench0;
    reg clk,rst;
    reg [2:0] sel;
    reg m_rf,inc,dec,succ,step;
    wire [15:0] led;
    wire [31:0] seg_toprint;
    wire [7:0] an;
    wire [6:0] ca;
    wire run;
    wire [31:0] m_data,rf_data;
    
    //connect top module
    top my_top(.clk(clk),.rst(rst),.succ(succ),.step(step),.sel(sel),.m_rf(m_rf),.inc(inc),.dec(dec),
        .led(led),.an(an),.ca(ca),.seg_toprint(seg_toprint),.run(run),.m_data(m_data),.rf_data(rf_data));
        
    parameter PERIOD = 2, 
    CYCLE = 70;
    initial
    begin
        clk = 0;
        repeat (2 * CYCLE)
            #(PERIOD/2) clk =~clk;
        $finish;
    end
    
    initial 
    begin
        rst = 1;
        sel = 0;
        m_rf = 0;
        inc = 0;
        dec = 0;
        succ = 0;
        step = 0;
        
        #PERIOD;
        
        rst = 0;
        sel = 3;
        m_rf = 0;
        inc = 0;
        dec = 0;
        succ = 0;
        step = 0;
        
        #PERIOD;
        
        rst = 0;
        sel = 3;
        m_rf = 0;
        inc = 0;
        dec = 0;
        succ = 0;
        step = 1;
        
        #(PERIOD*3);    //执行了一条指令
        
        sel = 2;
        succ = 1;
        step = 0;
        
        #(PERIOD*20);
        
        sel = 0;
        succ = 0;
        step = 0;
        m_rf = 1;
        #(PERIOD*3);
        
        inc = 1;
        #(PERIOD*3);
        inc = 0;
        #PERIOD;
        inc = 1;
        m_rf = 1;        
        #(PERIOD*10);
        inc = 0;
        #PERIOD;
        inc = 1;
        #PERIOD;
        inc = 0;
        #PERIOD;
        inc = 1;
        #PERIOD;
        inc = 0;
        #PERIOD;
        inc = 1;
        #PERIOD;
        inc = 0;
        #PERIOD;
        inc = 1;
        #PERIOD;
        inc = 0;
        #PERIOD;
        inc = 1;
        #PERIOD;
        inc = 0;
        #PERIOD;
        inc = 1;
        m_rf = 0;
    end
    
    
    
endmodule
