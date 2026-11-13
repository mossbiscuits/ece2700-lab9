`timescale 1ns / 1ps

// This is simply an example of testbench design that becomes painful.
// It's simpler to write once, but horrible to debug/modify.

module tb_painful;
    
    reg clk, rst, din;
    wire solution;
    
    FSMDetect DUT (
    	.clk(clk),
    	.rst(rst),
    	.din(din),
    	.solution(solution)
    );

    initial begin
      clk=0;
      din=0; #10;
      clk=1;
      rst = 1; #10;
      clk=0;
      clk=0; #10;
      rst = 0; 
      din = 1; 
      clk=0; #10;
      clk=1; #10;
      din = 0; 
      clk=0; #10;
      clk=1; #10;
      din = 1; 
      clk=0; #10;
      clk=1; #10;
      din = 0; 
      clk=0; #10;
      clk=1; #10;
      din = 1; 
      clk=0; #10;
      clk=1; #10;
      din = 0; 
      clk=0; #10;
      clk=1; #10;
      din = 1; 
      clk=0; #10;
      clk=1; #10;
      $stop;
    end
    
endmodule
