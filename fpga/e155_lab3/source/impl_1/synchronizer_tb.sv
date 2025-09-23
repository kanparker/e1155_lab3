`timescale 1ns/1ns
`default_nettype none
`define N_TV 13
module synchronizer_tb();
	logic clk, reset;
	logic [31:0] vectornum,errors;
	logic [2:0] testvectors[10000:0];
	logic cin, cout, clamp, cout_expected;
	
	// instantiate device under test
	synchronizer dut(cin,clk,reset,clamp,cout);
	
	// at start of test, load vectors and pulse reset
	initial
		begin
			$readmemb("synchronizer.tv", testvectors, 0, `N_TV - 1);
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
			#1; {cin,cout_expected,clamp} = testvectors[vectornum];
			
		end

// check results on falling edge of clk
	always @(negedge clk)
		if (~reset) begin // skip during reset
			if(cout !=cout_expected) begin
					$display("Error: inputs = %b", {clamp});
					$display(" outputs = %b (%b expected)", cout, cout_expected);
					errors = errors + 1;
				end;
			
			if (testvectors[vectornum] === 3'bx) begin
				$display("%d tests completed with %d errors", vectornum, errors);
				$stop;
			end
				
			
			assign vectornum = vectornum +1;
		
			
		end
		
		
		
		
		

endmodule 