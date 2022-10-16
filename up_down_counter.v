`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Peter Mbua
// 
// Create Date: 10/15/2022 08:15:28 AM
// Design Name: un_down Counter
// Module Name: up_down_coubter
// Project Name: Training
// Target Devices: Nexys 4
// Tool Versions: 2021.1
// Description: The counter is triggered by a clock and a sync reset. 
                //one switch with alternating binary values is used to 
                //make the counter count up or down as needed.
// 
// Dependencies: 
// 
// Revision: 22.01
// Revision 0.01 - File Created
// Additional Comments: synchrounous reset used, clock divider used too to make the counter practical.
// 
//////////////////////////////////////////////////////////////////////////////////

module up_down_counter(
    input clk, 
    input reset,
    input up_down_sw,
    //input load,
   // input [3:0] data,
    output reg [3:0] count
    );
 
reg clk_out; // output clock after dividing the input clock by divisor
reg[27:0] counter=28'd0;
parameter DIVISOR = 28'd90000000;

always@(posedge clk) 
begin
  counter <= counter + 28'd1;
     if(counter>=(DIVISOR-1))
          counter <= 28'd0;
          clk_out <= (counter<DIVISOR/2)?1'b1:1'b0;
end 
 
always@(posedge clk_out) 
begin
    if (reset)         //set cuounter to 0
    count <= 0;   
    else if(up_down_sw)      // upward counting
        count <= count + 1;
    else                     //downward counting 
        count <= count - 1;
 end
endmodule
