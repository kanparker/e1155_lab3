`timescale 1ns/1ns
`default_nettype none
`define N_TV 16
module stop_clamp_tb();
	logic clk, reset;
	logic [31:0] vectornum,errors;
	logic [13:0] testvectors[10000:0];
	logic stop ,stop_expected;
	logic [3:0] cin, clamps, clamps_expected, cout, cout_expected;
	
	// instantiate device under test
	stop_clamp dut(cin,stop,clamps,cout);
	
	// at start of test, load vectors and pulse reset
	initial
		begin
			$readmemb("stop_clamp.tv", testvectors, 0, `N_TV - 1);
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
			#1; {cin,clamps_expected,cout_expected, stop_expected} = testvectors[vectornum];
			
		end

// check results on falling edge of clk
	always @(negedge clk)
		if (~reset) begin // skip during reset
			if(cout !=cout_expected) begin
					$display("Error: inputs = %b", {cin});
					$display(" Cout outputs = %b (%b expected)", cout, cout_expected);
					errors = errors + 1;
				end;
			if(clamps !=clamps_expected) begin
					$display("Error: inputs = %b", {cin});
					$display(" Clamps outputs = %b (%b expected)", clamps, clamps_expected);
					errors = errors + 1;
				end;
			if(stop !=stop_expected) begin
					$display("Error: inputs = %b", {cin});
					$display(" Stop outputs = %b (%b expected)", stop, stop_expected);
					errors = errors + 1;
				end;
			
			if (testvectors[vectornum] === 14'bx) begin
				$display("%d tests completed with %d errors", vectornum, errors);
				$stop;
			end
				
			
			assign vectornum = vectornum +1;
		
			
		end
		
		
		
		
		

endmodule 