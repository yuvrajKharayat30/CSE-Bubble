// Ashish Meena (210214)
// Yuvraj Kharayat (211208)

`timescale 1ns/1ps
`include "mux.v"
module muxtb();
reg[31:0] a,b,c,d;
wire [31:0] out;

reg[1:0] s;


mux32bit_4option uut(a,b,c,d,s,out);

initial begin
    a=10;
    b=20;
    c=30;
    d=40;
    s=3;
    $monitor("%d",out);
end

endmodule