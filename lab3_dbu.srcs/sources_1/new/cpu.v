module cpu(
    input clk,
    input rst,
    input run,  //add the run signal
    
    input [15:0] m_rf_addr, //added m_rf_addr
    output [31:0] m_data,   //added m_data
    output [31:0] rf_data,  //added rf_data
    
    output Jump,
    output Branch,
    output RegDst,
    output RegWrite,
    output MemtoReg,
    output MemWrite,
    output [2:0] m,   //ALUop
    output ALUsrc,
    output zero,    //ALUzero
    
    output [31:0] pc,
    output [31:0] next_pc,
    output [31:0] instruction,
    output [31:0] Read_data1,
    output [31:0] Read_data2,
    output [31:0] y,
    output [31:0] Read_data
    );
    wire [31:0] mux_temp_pc,pc_4;   //delete pc for test
    wire [31:0] jump_add,beq_add;
//    wire [31:0] instruction;      //for test
//    wire RegDst,Jump,Branch,MemWrite;     //delete ALUsrc,RegWrite,MemtoReg for test
    wire [1:0] ALUop;
//    wire [31:0] Write_data;       //for test
//    wire [31:0] Read_data1,Read_data2;        //for test
//    wire [31:0] extended;     //for test
//    wire zero;
    wire [31:0] Write_data;
    
    //PC
    ProgramCounter my_PC_reg(.rst(rst),.clk(clk),.next_pc(next_pc),.pc(pc),.run(run));  //added run
    
    //Adder 1
    parameter pc_inc = 32'd4;
    Add my_adder1(.oprand1(pc),.oprand2(pc_inc),.opout(pc_4));
    
    //Beq_function
    Add my_adder2(.oprand1(pc_4),.oprand2({extended[30:0],2'b00}),.opout(beq_add));
    assign mux_temp_pc = (Branch&zero)? beq_add:pc_4;
    
    //Jump_function
    assign jump_add = {pc_4[31:28],instruction[25:0],2'b00};
    assign next_pc = Jump? jump_add:mux_temp_pc;
    
    //Instruction Memory
    Instruction_Memory my_ins_mem(.Read_address(pc),.Instruction(instruction));
    
    //Control Unit
    ControlUnit my_CU(.Instructions(instruction[31:26]),.RegDst(RegDst),.Jump(Jump),.Branch(Branch),
        .MemtoReg(MemtoReg),.ALUop(ALUop),.MemWrite(MemWrite),.ALUsrc(ALUsrc),.RegWrite(RegWrite));
    
    //Regsiters
    wire [4:0] Write_reg;
    assign Write_reg = RegDst? instruction[15:11]:instruction[20:16];
    Regs_32x32bit my_regs(.Read_register1(instruction[25:21]),.Read_register2(instruction[20:16]),
        .Write_register(Write_reg),.Write_data(Write_data),.clk(clk),.RegWrite(RegWrite),
        .Read_data1(Read_data1),.Read_data2(Read_data2),
        .run(run),.m_rf_addr(m_rf_addr[4:0]),.rf_data(rf_data)); //added run,rf_data function
    
    //Sign Extend
    wire [31:0] extended;
    assign extended = {{16{instruction[15]}},instruction[15:0]};
    
    //ALU & ALU Control
//    wire [2:0] m;     //for test
    ALUcontrol my_alu_control(.ALUop(ALUop),.instructions(instruction[5:0]),.m(m));
    wire [31:0] b;    //for test
    assign b = ALUsrc? extended:Read_data2;
    ALU my_alu(.y(y),.zf(zero),.a(Read_data1),.b(b),.m(m));
    
    //Data Memory
    Data_Mem my_data_mem(.address(y),.Write_data(Read_data2),.MemWrite(MemWrite),.clk(clk),
        .Read_data(Read_data),.run(run),.dpra({14'b0,m_rf_addr,2'b00}),.dpo(m_data));   //added run,m_data function
    
    //MemtoReg
    assign Write_data = MemtoReg? Read_data:y;
          
endmodule
