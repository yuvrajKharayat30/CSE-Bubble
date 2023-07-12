// Ashish Meena (210214)
// Yuvraj Kharayat (211208)

// Define the timescale for the module
`timescale 1ns/1ps

// Define the Text module
module Text (rst , clk , r_addr , w_addr , w_en , dout , din);

// Declare inputs and outputs
input wire rst, clk, w_en;
input wire[31:0] r_addr, w_addr, din;
output wire[31:0] dout;

// Declare a 32-bit register memory with 65536 words
reg[31:0] mem [65535:0];

// Initialize memory with program instructions
initial
begin

mem[0] = {6'b001000 , 5'd0 , 5'd23 , 16'd0}; //addi
mem[1] = {6'b001000 , 5'd0 , 5'd16 , 16'd0}; //addi
mem[2] = {6'b001000 , 5'd0 , 5'd22 , 16'd9}; //addi
mem[3] = {6'b001000 , 5'd0 , 5'd17 , 16'd0}; //addi
mem[4] = {6'b000000 , 5'd17 , 5'd23 , 5'd15 , 5'd0 , 6'd32}; //add
mem[5] = {6'b100011 , 5'd15 , 5'd8, 16'd0}; //lw
mem[6] = {6'b100011 , 5'd15 , 5'd9, 16'd1}; //lw
mem[7] = {6'b000000 , 5'd8  , 5'd9, 5'd10 , 5'd0, 6'b101010}; //slt
mem[8] = {6'b011001 , 5'd10 , 5'd0, 16'd3}; //bne
mem[9] = {6'b101011 , 5'd15 , 5'd9, 16'd0}; //sw
mem[10] = {6'b101011 , 5'd15 , 5'd8, 16'd1}; //sw
mem[11] = {6'b001000 , 5'd17 , 5'd17 , 16'd1}; //addi
mem[12] = {6'b000000 , 5'd22 , 5'd16 , 5'd21 , 5'd0 , 6'd34}; //sub
mem[13] = {6'b011001 , 5'd17 , 5'd21, 16'd65527}; //bne
mem[14] = {6'b001000 , 5'd16 , 5'd16 , 16'd1}; //addi
mem[15] = {6'b001000 , 5'd0 , 5'd17 , 16'd0}; //addi
mem[16] = {6'b011001 , 5'd16 , 5'd22, 16'd65524}; //bne

end

assign dout = mem[r_addr[15:0]];

always@(posedge clk) begin
   if (w_en) begin
        mem[w_addr[15:0]] = din;
   end
end
endmodule

// Define the Data module
module Data (rst , clk , r_addr , w_addr , w_en , dout , din);

// Declare inputs and outputs
input wire rst, clk, w_en;
input wire[31:0] r_addr, w_addr, din;
output wire[31:0] dout;

// Declare a 32-bit register memory with 65536 words
reg[31:0] mem [65535:0];

assign dout = mem[r_addr[15:0]];

//store the numbers to be sorted in data memory
initial begin
mem[0] = 32'd431;
    mem[1] = 32'd413;
    mem[2] = 32'd143;
    mem[3] = 32'd134;
    mem[4] = 32'd314;
    mem[5] = 32'd341;
    mem[6] = 32'd0;
    mem[7] = 32'd4;
    mem[8] = 32'd3;
    mem[9] = 32'd1;
end

initial begin
    $monitor("%d, %d, %d, %d, %d, %d, %d, %d, %d, %d", mem[0], mem[1], mem[2], mem[3], mem[4], mem[5], mem[6], mem[7], mem[8], mem[9]);
end

always@(posedge clk) begin
   if (w_en) begin
        mem[w_addr[15:0]] = din;
   end
end
endmodule
