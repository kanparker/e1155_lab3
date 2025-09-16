`timescale 1ns/1ns
`default_nettype none
`define N_TV 16
module read_writer_tb();
	logic clk, reset;
	logic [31:0] vectornum,errors;
	logic [12:0] testvectors[10000:0];
	logic stop,stop_expected;
	logic [3:0] cin,rows,control_1,control_2,control_1exp,control_2exp;
	
	// instantiate device under test
	read_writer dut(clk,reset,rows,columns,control_1,control_2);
	
	// at start of test, load vectors and pulse reset
	initial
		begin
			$readmemb("read_writer.tv", testvectors, 0, `N_TV - 1);
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
			#1; {cin,clamps_expected,cout_expected,stop_expected} = testvectors[vectornum];
			$display("%b %b %b %b", cin, clamps_expected, cout_expected,stop_expected);
		end

// check results on falling edge of clk
	always @(negedge clk)
		if (~reset) begin // skip during reset
			if(cout !==cout_expected) begin
					$display("Error: inputs = %b", cin);
					$display(" Cout outputs = %b (%b expected)", cout, cout_expected);
					errors = errors + 1;
				end;
			if(clamps !==clamps_expected) begin
					$display("Error: inputs = %b", cin);
					$display(" Clamps outputs = %b (%b expected)", clamps, clamps_expected);
					errors = errors + 1;
				end;
			if(stop !==stop_expected) begin
					$display("Error: inputs = %b", cin);
					$display(" Stop outputs = %b (%b expected)", stop, stop_expected);
					errors = errors + 1;
				end;
				
			assign vectornum = vectornum +1;
			
			if (testvectors[vectornum] === 13'bx) begin
				$display("%d tests completed with %d errors", vectornum, errors);
				$stop;
			end
				
			
			
		
			
		end
		
		
		
		
		

endmodule 