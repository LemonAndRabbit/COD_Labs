module ALUcontrol(
    input [1:0] ALUop,
    input [5:0] instructions,
    output reg [2:0] m
    );
    always@(*)
    begin
        case (ALUop)
            2'b00: m = 3'b000;  //plus
            2'b01: m = 3'b001;  //minus
            2'b10:  //R-type
                begin
                    case (instructions)
                        6'b10_0000: m = 3'b000;  //add
                        6'b10_0010: m = 3'b001; //minus
                        6'b10_0100: m = 3'b010; //and
                        6'b10_0101: m = 3'b011; //or
                        default:    m = 3'b000;
                    endcase
                end
            default: m = 3'b000;
        endcase
    end
endmodule
