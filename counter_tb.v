`timescale 1ns / 1ps

//testbench module.
module counter_tb;

    reg clk, reset, up_down;
    //reg [3:0] data;
    wire [3:0] count;
    
    //instanntiating counter design under test
    up_down_counter dut(
           .clk (clk_out), 
           .reset(reset), 
           .count(count),
           .up_down(up_down_sw));  //mapping test signals to counter inputs/outputs (ALL)
    
    //clock stimulus (start clock at active low, turn on and repeat alteration every 2 time-unit)
    initial begin
        clk <= 1'b0; 
        reset <= 1'b0;
    
    //input stimuli 
        reset <= 1'b1; #10  // assert reset for 5 time-unit (TU),
        reset <= 1'b0; #50  // then deactivate reset to low for 50 TUs
        reset <= 1'b1; #15
      
        up_down <= 1'b1; #20   //stimutate count up for 20TUs then count down
        up_down <= 1'b0; #20
       
       #20 $finish;