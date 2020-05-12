module control_seg(
    input [31:0] seg_toprint,
    input clk,
    output reg [7:0] an,
    output [6:0] ca
    );
    //切换显示的计数
    reg [14:0] segclk_counter;
    reg [3:0] switch_light;
    reg [3:0] search;
    wire [7:0] temp;
    always@(posedge clk)
    begin
        if(segclk_counter<10000)
            segclk_counter<=segclk_counter+1;
        else
        begin
            segclk_counter<=0;
            switch_light<=switch_light+1;
        end            
    end
    
    always@(posedge clk)
    begin
        case(switch_light)
            3'b000  :   an<=8'b11111110;
            3'b001  :   an<=8'b11111101;
            3'b010  :   an<=8'b11111011;
            3'b011  :   an<=8'b11110111;
            3'b100  :   an<=8'b11101111;
            3'b101  :   an<=8'b11011111;
            3'b110  :   an<=8'b10111111;
            3'b111  :   an<=8'b01111111;
        endcase  
        case(switch_light)
            3'b000  :   search <= seg_toprint[3:0];
            3'b001  :   search <= seg_toprint[7:4];
            3'b010  :   search <= seg_toprint[11:8];
            3'b011  :   search <= seg_toprint[15:12];
            3'b100  :   search <= seg_toprint[19:16];
            3'b101  :   search <= seg_toprint[23:20];
            3'b110  :   search <= seg_toprint[27:24];
            3'b111  :   search <= seg_toprint[31:28];
        endcase  
    end
    
    assign ca=~temp[6:0];
    dist_mem_gen_0 myseg7(search,temp);
    
endmodule
