module control_run(
    input clk,
    input rst,
    input succ,
    input step,
    output reg run
    );   
    reg step_r1,step_r2;
    always@(posedge clk)
    begin
        if(rst)
        begin
            step_r1 <= 0;
            step_r2 <= 0;
        end
        else
        begin
            step_r1 <= step;
            step_r2 <= step_r1;
        end
    end   
    always@(posedge clk)
    begin
        if(rst)
            run <= 0;
        else
        begin
            if(succ)    //如果连续执行
                run <= 1;
            else
            begin
                if(step_r1 & ~ step_r2) //如果执行一步
                begin
                    run <= 1;
                end
                else
                    run <= 0;
            end
        end                
    end
endmodule
