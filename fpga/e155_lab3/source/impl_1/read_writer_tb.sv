`timescale 1ns/1ns
`default_nettype none
`define N_TV 13
module read_writer_tb();
	logic clk, reset;
	logic [31:0] vectornum,errors;
	logic [15:0] testvectors[10000:0];
	logic [3:0] rows,columns,control_1,control_2,control_1exp,control_2exp;
	
	// instantiate device under test
	read_writer dut(clk,reset,rows,columns,control_1,control_2);
	
	// at start of test, load vectors and pulse reset
	initial
		begin
			$readmemb("read_write.tv", testvectors, 0, `N_TV - 1);
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
			#1; {rows,columns,control_1exp,control_2exp} = testvectors[vectornum];
			///$display("%b %b %b %b", row, columns, cont,stop_expected);
		end

// check results on falling edge of clk
	always @(negedge clk)
		if (~reset) begin // skip during reset
			if(control_1 !==control_1exp) begin
					$display("Error: inputs = %b %b", columns, rows);
					$display(" Control_1 outputs = %b (%b expected)", control_1, control_1exp);
					errors = errors + 1;
				end;
			if(control_2 !==control_2exp) begin
					$display("Error: inputs = %b %b", columns, rows);
					$display(" Control_2 outputs = %b (%b expected)", control_2, control_2exp);
					errors = errors + 1;
				end;
				
			assign vectornum = vectornum +1;
			
			if (testvectors[vectornum] === 16'bx) begin
				$display("%d tests completed with %d errors", vectornum, errors);
				$stop;
			end
				
			
			
		
			
		end
		
		
		
		
		

endmodule 