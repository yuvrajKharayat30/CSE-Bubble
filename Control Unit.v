// Ashish Meena (210214)
// Yuvraj Kharayat (211208)

`timescale 1ns/1ps

module control (IR , PCcontrol, Alucontrol, WriteReg, ALUsrc, MemWrite, MemToReg, RegWrite, Link, Immediate);

// input signals
input wire[31:0] IR;

// output signals
output reg[1:0] PCcontrol;
output reg[3:0] Alucontrol;
output reg[4:0] WriteReg;
output reg ALUsrc, MemWrite, MemToReg, RegWrite, Link;
output reg[31:0] Immediate;

// signals to decode the instruction
wire[31:0] signed_im, unsigned_im;
assign signed_im = { {16{IR[15]}} , IR[15:0]};
assign unsigned_im = { 16'd0 , IR[15:0]};
wire [4:0] rs,rt,rd;
assign rs = IR[25:21];
assign rt = IR[20:16];
assign rd = IR[15:11];

// constants and parameters to represent operations and instruction types
parameter RFORMAT = 1'b0;
parameter IFORMAT = 1'b1;
localparam ADD_FUNC =  {3'd4,3'd0};
localparam SUB_FUNC = {3'd4,3'd2};
localparam ADDU_FUNC= {3'd4,3'd1};
localparam SUBU_FUNC ={3'd4,3'd3};
localparam AND_FUNC ={3'd4,3'd4};
localparam OR_FUNC ={3'd4,3'd5};
localparam SLL_FUNC ={3'd0,3'd0};
localparam SRL_FUNC ={3'd0,3'd2};
localparam SLT_FUNC ={3'd5,3'd2};
parameter ADD = 0;
parameter SUB = 1;
parameter AND = 2;
parameter OR = 3;
parameter SLL = 4;
parameter SRL = 5;
parameter SLT = 6;

// decode the instruction and set control signals
always@(IR) begin
    Link = 0;

    // R-format instructions
    if(IR[31:26] == 6'b000000) begin
        PCcontrol = 0;
        WriteReg = rd;
        ALUsrc = RFORMAT;
        MemWrite = 0;
        MemToReg = 0;
        RegWrite = 1;

        // set Alucontrol based on function code
        case(IR[5:0])
        ADD_FUNC: Alucontrol = 0;
        SUB_FUNC: Alucontrol = 1;
        ADDU_FUNC: Alucontrol = 0;
        SUBU_FUNC: Alucontrol = 1;
        AND_FUNC: Alucontrol = 2;
        OR_FUNC: Alucontrol = 3;
        SLL_FUNC: Alucontrol = 4;
        SRL_FUNC: Alucontrol = 5;
        SLT_FUNC: Alucontrol = 6;
        6'b001_000: begin   //jr instruction
            PCcontrol = 2;
            Alucontrol = 0;
        end
        endcase 
    end

    // I-format instructions
    else if (IR[31:29] == 3'b001) begin
        PCcontrol = 0;
        WriteReg = rt;
        ALUsrc = IFORMAT;
        MemWrite = 0;
        MemToReg = 0;
        RegWrite = 1;

        // set Immediate and Alucontrol based on opcode
        case(IR[28:26])
            3'b000: begin//add
                Immediate = signed_im;
                Alucontrol = 0;
            end
            3'b001:begin    //addiu
                Immediate = unsigned_im;
                Alucontrol = 0;
            end
            3'b010:begin    //slti
                Immediate = signed_im;
                Alucontrol = 6;
            end
            3'b011:begin    //sltiu
                Immediate = unsigned_im;
                Alucontrol = 6;
            end
            3'b100:begin    //andi
                Immediate = unsigned_im;
                Alucontrol = 2;
            end
            3'b101:begin    //ori
                Immediate = unsigned_im;
                Alucontrol = 3;
            end
        endcase        
    end

    else if (IR[31:29]==3'b011) begin  //branch
        PCcontrol = 1;
        WriteReg = rt;
        ALUsrc = RFORMAT;
        Alucontrol = 0;
        MemWrite = 0;
        MemToReg = 0;
        RegWrite = 0;
        Immediate = signed_im;     

        case(IR[28:26])
        3'b000: //beq
            Alucontrol = 7;
        3'b001: //bne
            Alucontrol = 8;
        3'b010: //bgt
            Alucontrol = 9;
        3'b011: //bgte
            Alucontrol = 10;
        3'b100: //ble
            Alucontrol = 11;
        3'b110: //bleq
            Alucontrol = 12;
        endcase

    end

    else if (IR[31:26]==2) begin    //j
        PCcontrol = 3;
        WriteReg = rd;  
        ALUsrc = IFORMAT;   
        Alucontrol = 15;     
        MemWrite = 0;
        MemToReg = 0;
        RegWrite = 0;
    end

    else if (IR[31:26]==3) begin    //jal
        PCcontrol = 3;
        WriteReg = 31;  
        ALUsrc = IFORMAT;  
        Alucontrol = 15; 
        MemWrite = 0;
        MemToReg = 0;
        RegWrite = 0;
        Link = 1;
    end
    else if (IR[31:26]==6'b100011) begin  //lw
        PCcontrol = 0;
        WriteReg = rt;
        ALUsrc = IFORMAT;
        Alucontrol = 0;    //add
        MemWrite = 0;
        MemToReg = 1;
        RegWrite = 1;    
        Immediate = signed_im;     
    end

    else if (IR[31:26]==6'b101011) begin  //sw
        PCcontrol = 0;
        WriteReg = rt;
        ALUsrc = IFORMAT;
        Alucontrol = 0;    //add
        MemWrite = 1;
        MemToReg = 0;
        RegWrite = 0; 
        Immediate = signed_im;        
    end
    
end
endmodule
