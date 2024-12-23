// Datapath Module
// This module represents the datapath of a MIPS processor. It includes the program counter (PC),
// arithmetic logic unit (ALU), register file, and various multiplexers and adders to handle
// instruction execution and data flow.

// Inputs:
// - clk: Clock signal
// - reset: Reset signal
// - RegDst: Control signal to select the destination register
// - RegWrite: Control signal to enable writing to the register file
// - ALUSrc: Control signal to select the second ALU operand
// - Jump: Control signal to handle jump instructions
// - MemtoReg: Control signal to select the data to write back to the register file
// - PCSrc: Control signal to select the next PC value
// - ALUControl: Control signal to specify the ALU operation
// - ReadData: Data read from memory
// - Instr: Instruction fetched from memory

// Outputs:
// - PC: Current program counter value
// - ZeroFlag: Zero flag from the ALU indicating if the result is zero
// - datatwo: Data read from the second register
// - ALUResult: Result from the ALU operation

// Internal Wires:
// - PCNext: Next value of the program counter
// - PCplus4: Program counter incremented by 4
// - PCbeforeBranch: Program counter before branch
// - PCBranch: Program counter after branch
// - extendedimm: Sign-extended immediate value
// - extendedimmafter: Shifted immediate value after sign extension
// - MUXresult: Result from the memory or ALU to be written back to the register file
// - dataone: Data read from the first register
// - aluop2: Second operand for the ALU
// - writereg: Destination register address
// file: Datapath.v


`include "adder.v"
`include "alu32.v"
`include "flopr_param.v"
`include "mux2.v"
`include "mux4.v"
`include "regfile32.v"
`include "signext.v"
`include "sl2.v"

`timescale 1ns/1ns

module Datapath(input clk,
                input reset,
                input RegDst,
                input RegWrite,
                input ALUSrc,
                input Jump,
                input MemtoReg,
                input PCSrc,
                input [3:0] ALUControl,
                input [31:0] ReadData,
                input [31:0] Instr,
                output [31:0] PC,
                output ZeroFlag,
                output [31:0] datatwo, 
                output [31:0] ALUResult);


wire [31:0] PCNext, PCplus4, PCbeforeBranch, PCBranch;
wire [31:0] extendedimm, extendedimmafter, MUXresult, dataone, aluop2;
wire [4:0] writereg;

// PC 
flopr_param #(32) PCregister(clk,reset, PC,PCNext);
  adder #(32) pcadd4(PC, 32'd4 ,PCplus4);
slt2 shifteradd2(extendedimm,extendedimmafter);
adder #(32) pcaddsigned(extendedimmafter,PCplus4,PCbeforeBranch);
mux2 #(32) branchmux(PCplus4 , PCbeforeBranch, PCSrc, PCBranch);
mux2 #(32) jumpmux(PCBranch, {PCplus4[31:28],Instr[25:0],2'b00 }, Jump,PCNext);

// Register File 

registerfile32 RF(clk,RegWrite, reset, Instr[25:21], Instr[20:16], writereg, MUXresult, dataone,datatwo); 
mux2 #(31) jalmux(5'b11111,Instr[15:11],jal, Writeopmux);
mux2 #(5) writeopmux(Instr[20:16],Writeopmux,RegDst, writereg);
mux2 #(32) resultmux(ALUResult, ReadData, MemtoReg,MUXresult);

// ALU

alu32 alucomp(dataone, aluop2, ALUControl, Instr[10:6], ALUResult, ZeroFlag);
signext immextention(Instr[15:0],extendedimm);
mux2 #(32) aluop2sel(datatwo,extendedimm, ALUSrc, aluop2);


endmodule