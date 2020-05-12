module Add(
    input [31:0] oprand1,
    input [31:0] oprand2,
    output [31:0] opout
    );
    assign opout = oprand1 + oprand2;
endmodule
