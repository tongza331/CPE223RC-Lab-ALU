`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/11/2021 03:19:04 PM
// Design Name: 
// Module Name: alu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module alu(
input [3:0] Ain,Bin,OPC4,
output reg [3:0] Aout,
input Clk,
//output reg Cin,
output reg Cout,
output wire V,
output wire Z // carry,overflow,zero
);
always @(posedge Clk)
begin 
    case(OPC4)
        4'b0000 : Aout = Bin; // 1- lw
        4'b0001 : Aout = Ain + Bin; // 2- add
        4'b0010 : Aout = Ain-Bin; // 3- sub
        4'b0101 : Aout = Ain&Bin;  // 4- and
        4'b0110 : Aout = Ain|Bin; // 5- or
        4'b0111 : Aout = ~Ain;  // 6- not
        4'b0100 : begin // 7- clear
                     Aout = 0;
                     Cout = 1'b0;
                  end
       4'b0011 : Aout = Ain; //8- store
    endcase
    case(OPC4[3:2])
        2'b10 : Aout <= Ain<<2'b10; // 8- SHL 0001 << 2  ?  0010
        2'b11 : Aout <= Ain>>2'b10; // 10- SHR 0100 >> 2  ?  0001
    endcase
 end
assign Z = ~(|Aout);
//assign V = ({Cout,Aout[3]} == 1'b01);
endmodule
