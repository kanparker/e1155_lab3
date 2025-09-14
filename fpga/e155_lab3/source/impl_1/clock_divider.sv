module clock_divider(
	input 	logic clk,
	input logic reset,
	output 	logic slow_clk
);

	
	logic [31:0] counter = 0;
	logic [31:0] P;
	
	assign P = 32'b01000000000000000000000000000000;
	
	
	
	// Simple clock divider
	always_ff @(posedge clk,reset)
		if(reset) begin
			counter <= 0;
		end 
		else begin
					counter <= counter + P;
				end
	
	assign slow_clk = counter[31];
	

endmodule