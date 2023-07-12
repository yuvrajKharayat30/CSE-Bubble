// Ashish Meena (210214)
// Yuvraj Kharayat (211208)

// Define time scale and include necessary modules
`timescale 1ns/1ps
`include "memory.v"
`include "Control Unit.v"
`include "ALU.v"
`include "mux.v"

// Define the top-level module with inputs and outputs
module core (rst, clk);
input wire rst, clk;

// Define necessary wires and registers
reg [31:0] PC;
wire [31:0] PC_next, IR; 
reg [31:0] R [31:0];
wire [31:0] input1, input2;
wire [31:0] rs_data, rt_data;
reg [31:0] unused32 = 0;
reg unused1 = 0;
reg start;
wire [31:0] next_inst;
wire [31:0] ReadData, ALUout, Result;
wire ALUzero;
wire [4:0] shamt;

wire [1:0] PCcontrol;
wire [3:0] Alucontrol;
wire[4:0] WriteReg;
wire ALUsrc, MemWrite, MemToReg, RegWrite_en, Link;
wire [31:0] Immediate;

wire [31:0] PCplus1, branch_addr, jr_addr, j_addr;
assign PCplus1 = PC+1;
assign branch_addr = PC + Immediate;
assign jr_addr = rs_data;
assign j_addr = {PC[31:26], IR[25:0]};
mux32bit_4option PC_next_decider(PCplus1, branch_addr, jr_addr, j_addr, PCcontrol, ALUout, PC_next);

assign rs_data = R[IR[25:21]];
assign rt_data = R[IR[20:16]];
mux32bit Result_decider(ALUout, ReadData, MemToReg, Result);

assign input1 = rs_data;
assign shamt = IR[10:6];
mux32bit input2_decider(rt_data, Immediate, ALUsrc, input2);
ALU alu(input1, input2, shamt, Alucontrol, ALUout, ALUzero);

// Read instruction and data from memory
Text instruction (.rst(rst), .clk(clk), .r_addr(PC), .w_addr(unused32), .w_en(unused1), .din(unused32), .dout(IR));
Data var (.rst(rst), .clk(clk), .r_addr(ALUout), .w_addr(ALUout), .w_en(MemWrite), .din(rt_data), .dout(ReadData));

// Control unit module for generating control signals
control unit (IR, PCcontrol, Alucontrol, WriteReg, ALUsrc, MemWrite, MemToReg, RegWrite_en, Link, Immediate);

// Initializations in the reset block
always@(posedge rst) begin
    PC = 0;
    R[0] = 0;
    start = 0;
end

// Main clocked block
always@(posedge clk) begin

    if(start == 0) begin
        start = 1;
    end

    else begin
        if (RegWrite_en) R[WriteReg] = Result; // Write back to register file
        if (Link) R[31] = PCplus1; // Save return address in register 31
        //fetch
        PC = PC_next; // Update program counter to next instruction
    end
end


endmodule
