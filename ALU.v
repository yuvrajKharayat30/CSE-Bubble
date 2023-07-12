// Ashish Meena (210214)
// Yuvraj Kharayat (211208)

// Define the timescale for the module
`timescale 1ns/1ps

// Define the ALU module
module ALU (input1 , input2 , shamt, Alucontrol , out , zero);

    // Declare the input signals for the ALU module
    input wire [31:0] input1,input2;
    input wire[4:0] shamt;
    input wire[3:0] Alucontrol;

    // Declare the output signals for the ALU module
    output reg[31:0] out;
    output wire zero;

    // Calculate the zero flag
    assign zero = (out==32'd0);

    // Define the different ALU operations as parameters
    parameter ADD = 0;
    parameter SUB = 1;
    parameter AND = 2;
    parameter OR = 3;
    parameter SLL = 4;
    parameter SRL = 5;
    parameter SLT = 6;
    parameter BEQ = 7;
    parameter BNE = 8;
    parameter BGT = 9;
    parameter BGTE = 10;
    parameter BLE = 11;
    parameter BLEQ = 12;

    // Define the always block to calculate the output based on the ALU operation
    always @(*) begin
        case(Alucontrol)
            ADD: out = input1 + input2;
            SUB: out = input1 - input2;
            AND: out = input1 & input2;
            OR: out = input1 | input2;
            SLL: out = input1 << shamt;
            SRL: out = input1 >> shamt;
            SLT: out = (input1<input2)? 1:0;
            BEQ: out = (input1==input2)?1:0;
            BNE: out = (input1!=input2)?1:0;
            BGT: out = (input1>input2)?1:0;
            BGTE: out = (input1>=input2)?1:0;
            BLE: out = (input1<input2)?1:0;
            BLEQ: out = (input1<=input2)?1:0;
        endcase
    end
endmodule
