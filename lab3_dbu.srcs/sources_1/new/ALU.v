module ALU
    #(parameter WIDTH = 32)
    (output [WIDTH-1:0] y,  //运算结果
    output zf,  //零标志
//    output cf,  //进位/借位标志
//    output of,  //溢出标志
    input [WIDTH-1:0] a,b,  //两操作数
    input [2:0] m   //操作类型
    );
    reg z,c,o;
    reg [WIDTH-1:0] yr;
    always@(*)
    begin
        c = 0;
        o = 0;
        case (m)
            3'b000: 
                begin
                {c,yr} = a + b;
                o = (~a[WIDTH-1]&~b[WIDTH-1]&yr[WIDTH-1])|(a[WIDTH-1]&b[WIDTH-1]&~yr[WIDTH-1]);
                end
            3'b001: 
                begin
                {c,yr} = a - b;
                o = (~a[WIDTH-1]&b[WIDTH-1]&yr[WIDTH-1])|(a[WIDTH-1]&~b[WIDTH-1]&~yr[WIDTH-1]);
                end
            3'b010:
                begin
                yr = a&b;
                end
            3'b011:
                begin
                yr = a|b;
                end
            3'b100:
                begin
                yr = a^b;
                end
            default:
                yr = 0;
        endcase
    end
    assign zf = ~|yr;
    assign y = yr;
//    assign of = o;
//    assign cf = c;
endmodule
