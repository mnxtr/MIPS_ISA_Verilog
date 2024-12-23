// file: MIPS_SCP.v

// This module implements a single-cycle MIPS processor (MIPS_SCP).
// It includes the datapath, control unit, RAM, and ROM components.

// Inputs:
// - clk: Clock signal
// - reset: Reset signal

// Internal signals:
// - PC: Program Counter
// - Instr: Instruction fetched from ROM
// - ReadData: Data read from RAM
// - WriteData: Data to be written to RAM
// - ALUResult: Result from the ALU
// - RegDst: Register Destination control signal
// - RegWrite: Register Write control signal
// - ALUSrc: ALU Source control signal
// - Jump: Jump control signal
// - MemtoReg: Memory to Register control signal
// - PCSrc: Program Counter Source control signal
// - Zero: Zero flag from ALU
// - MemWrite: Memory Write control signal
// - ALUControl: ALU control signal

// Instantiated modules:
// - Datapath: The datapath component that performs the core processing
// - Controlunit: The control unit that generates control signals based on the instruction
// - ram: Data memory (RAM) for storing and retrieving data
// - rom: Instruction memory (ROM) for storing and fetching instructions

// The MIPS_SCP module integrates these components to form a single-cycle MIPS processor.

`include "datapath.v"
`include "ram.v"
`include "rom.v"
`include "control.v"

`timescale 1ns/1ns


module MIPS_SCP(input clk,
                input reset);
                
wire [31:0] PC, Instr, ReadData, WriteData, ALUResult;
wire RegDst,RegWrite, ALUSrc, Jump, MemtoReg, PCSrc , Zero, MemWrite;
wire [3:0] ALUControl;

Datapath datapathcomp(clk, reset, RegDst,RegWrite, ALUSrc,Jump,MemtoReg ,
                     PCSrc,ALUControl,ReadData, Instr, PC, Zero, 
                     WriteData,ALUResult);


Controlunit controller(Instr[31:26], Instr[5:0], Zero,MemtoReg,MemWrite,
                        ALUSrc, RegDst, RegWrite, Jump, PCSrc, ALUControl);


ram dmem(clk,MemWrite,ALUResult, WriteData, ReadData);

rom imem(PC,Instr);

endmodule
