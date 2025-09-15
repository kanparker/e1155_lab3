`timescale 1ns/1ns
`default_nettype none
`define N_TV 21
module row_sweep_tb();
	logic clk, reset;
	logic [31:0] vectornum,errors;
	logic [13:0] testvectors[10000:0];
	logic stop;
	logic [3:0] rows, rows_expected;
	
	// instantiate device under test
	row_sweep dut(clk,reset,stop,rows);
	
	// at start of test, load vectors and pulse reset
	initial
		begin
			$readmemb("e155_lab3_row_sweep.tv", testvectors, 0, `N_TV - 1);
			vectornum = 0; errors = 0; reset = 1; #22; reset = 0;
			
		end
		
	always
		begin
			clk=1; #5;
			clk=0; #5;
		end
		// apply test vectors on rising edge of clk
	always @(posedge clk)
		begin
			#1; {stop,rows_expected} = testvectors[vectornum];
			
		end

// check results on falling edge of clk
	always @(negedge clk)
		if (~reset) begin // skip during reset
			if(rows !=rows_expected) begin
					$display("Error: inputs = %b", {stop});
					$display(" outputs = %b (%b expected)", rows, rows_expected);
					errors = errors + 1;
				end;
			
			if (testvectors[vectornum] === 14'bx) begin
				$display("%d tests completed with %d errors", vectornum, errors);
				$stop;
			end
				
			
			assign vectornum = vectornum +1;
		
			
		end
		
		
		
		
		

endmodule 