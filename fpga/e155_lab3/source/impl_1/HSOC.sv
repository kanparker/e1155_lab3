module HSOC(
	output logic clk
);

	logic int_osc;
	
	
	
	// Internal high-speed oscillator
	HSOSC hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));
	
	assign clk = int_osc;
	

endmodule