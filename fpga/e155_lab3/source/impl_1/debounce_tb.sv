`timescale 1ns/1ns
`default_nettype none
`define N_TV 21
module debounce_tb();
	logic clk, reset;
	logic raw_data, filtered_data;
	
	// instantiate device under test
	debounce dut(clk,reset,raw_data,filtered_data);
	
	// at start of test, load vectors and pulse reset
	initial
		begin
			raw_data = 0;
			reset = 1; #22; reset = 0;
			#1; raw_data = 1;
			#1; raw_data = 0;
			#1; raw_data = 1;
			#1; raw_data = 0;
			#1; raw_data = 1;
			#1; raw_data = 0;
			#1; raw_data = 1;
			#1; raw_data = 0;
			#1; raw_data = 1;
			#1; raw_data = 0;
			#1; raw_data = 1;
			#1; raw_data = 0;
			#1; raw_data = 1;
			#50; raw_data = 0;
			#50;
			
			
		end
		
	always
		begin
			clk=1; #5;
			clk=0; #5;
		end
		
		
		
		
		

endmodule 