module ALU
    #(parameter WIDTH = 32)
    (output [WIDTH-1:0] y,  //������
    output zf,  //���־
//    output cf,  //��λ/��λ��־
//    output of,  //�����־
    input [WIDTH-1:0] a,b,  //��������
    input [2:0] m   //��������
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
