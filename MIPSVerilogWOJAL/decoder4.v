// file: decoder4.v

// This module implements a 4-to-16 decoder. It takes a 4-bit input 'a' and 
// produces a 16-bit output 'y'. The output 'y' is a one-hot encoded signal 
// where only one bit is set to '1' based on the value of the input 'a'.
// 
// Inputs:
//   - a: 4-bit input signal
//
// Outputs:
//   - y: 16-bit one-hot encoded output signal
//
// The module uses an always block that is sensitive to any changes in the 
// input 'a'. Inside the always block, a series of if-else statements are 
// used to determine which bit of the output 'y' should be set to '1' based 
// on the value of 'a'. For example, if 'a' is 4'b0000, then 'y' will be 
// 16'b0000000000000001, and if 'a' is 4'b1111, then 'y' will be 
// 16'b1000000000000000.


`timescale 1ns/1ns

module decoder4( input [3:0]   a,
                 output reg [15:0] y
                );
                
always @(*) begin

        if(a == 4'b0000)
            y <= 16'b0000000000000001;
        else if(a == 4'b0001)
            y <= 16'b0000000000000010;
        else if(a == 4'b0010)
            y <= 16'b0000000000000100;
        else if(a == 4'b0011)
            y <= 16'b0000000000001000;
        else if(a == 4'b0100)
            y <= 16'b0000000000010000;
        else if(a == 4'b0101)
            y <= 16'b0000000000100000;
        else if(a == 4'b0110)
            y <= 16'b0000000001000000;
        else if(a == 4'b0111)
            y <= 16'b0000000010000000;
        else if(a == 4'b1000)
            y <= 16'b0000000100000000;
        else if(a == 4'b1001)
            y <= 16'b0000001000000000;
        else if(a == 4'b1010)
            y <= 16'b0000010000000000;
        else if(a == 4'b1011)
            y <= 16'b0000100000000000;
        else if(a == 4'b1100)
            y <= 16'b0001000000000000;
        else if(a == 4'b1101)
            y <= 16'b0010000000000000;
        else if(a == 4'b111)
            y <= 16'b0100000000000000;
        else if(a == 4'b1111)
            y <= 16'b1000000000000000;
    end

endmodule 