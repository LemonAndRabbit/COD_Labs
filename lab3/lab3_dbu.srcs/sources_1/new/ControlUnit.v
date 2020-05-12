module ControlUnit(
    input [31:26] Instructions,
    output reg RegDst,
    output reg Jump,
    output reg Branch,
    output reg MemtoReg,
    output reg [1:0] ALUop,
    output reg MemWrite,
    output reg ALUsrc,
    output reg RegWrite
    //Leave out MemRead
    );
    always@(*)
    begin
        {RegDst,Jump,Branch,MemtoReg,ALUop,MemWrite,ALUsrc,RegWrite} = 9'b0_0000_0000;
        case (Instructions)
            6'b00_0000: {RegDst,RegWrite,ALUop[1]} = 3'b111;    //add
            6'b00_1000: {RegWrite,ALUsrc} = 2'b11; //addi
            6'b10_0011: {ALUsrc,MemtoReg,RegWrite} = 3'b111;    //lw
            6'b10_1011: {ALUsrc,MemWrite} = 2'b11;  //sw
            6'b00_0100: {Branch,ALUop[0]} = 2'b11; //beq
            6'b00_0010: {Jump} = 1'b1; //jump
            //Since every signal has its default value, no need to add a default branch
        endcase            
    end
    
endmodule
