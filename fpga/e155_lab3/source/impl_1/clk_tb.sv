

`timescale 1ns/1ns
`default_nettype none
`define N_TV 16
module clk_tb();
	logic clk, reset;
	logic slow_clk;
	
	clock_divider dut(clk, reset, slow_clk);
	
	//// Generate clock.
	always
		begin
			clk=1; #5;
			clk=0; #5;
		end
		
	initial
		begin
			
	
			reset=1; #22;
			reset=0;
			#1000;
			reset=1; #22;
			reset = 0;
			#1000;
		end
	
endmodule
