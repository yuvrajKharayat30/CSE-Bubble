// Ashish Meena (210214)
// Yuvraj Kharayat (211208)

`timescale 1ns/1ps  // define timescale for simulation

`include "Top.v"  // include the design module to be tested

module tb ();

reg clk,rst;

core uut (rst , clk);  // instantiate the design module

initial begin
    clk=0;
    rst=1;
    #1 rst=0;  // set reset signal low after 1 time unit
end

initial begin
    $dumpfile("test.vcd");  // specify the name of the waveform file
    $dumpvars(0,tb);  // dump all signals in the testbench module to the waveform file
    #5000 $finish;  // end the simulation after 5000 time units
end

always #5 clk=~clk;  // toggle clock signal every 5 time units
endmodule
