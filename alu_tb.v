// Ashish Meena (210214)
// Yuvraj Kharayat (211208)

// Set the time scale for the simulation
timescale 1ns/1ps

// Include the ALU module
`include "ALU.v"

// Declare inputs and control signals
module alutb();
reg[31:0] input1, input2;
reg[4:0] shamt;
reg[3:0] Alucontrol;

// Declare output signals
wire [31:0] out;
wire zero;

// Declare integer variable
integer i;

// Instantiate the ALU module with the specified inputs and outputs
ALU uut (input1, input2, shamt, Alucontrol, out, zero);

// Define the initial block for simulation
initial begin

    // Set initial input values
    input1 = 10;
    input2 = 20;
    shamt = 2;

    // Iterate over possible values of Alucontrol and display the output and zero flags
    for (i = 0; i < 13; i = i + 1) begin
        Alucontrol = i;
        #1 $display("%d %d", out, zero);
        #5;
    end
end

endmodule
