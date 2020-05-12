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
            if(succ)    //�������ִ��
                run <= 1;
            else
            begin
                if(step_r1 & ~ step_r2) //���ִ��һ��
                begin
                    run <= 1;
                end
                else
                    run <= 0;
            end
        end                
    end
endmodule
