module debounce(
	input logic clk,reset,
	input logic raw_data,
	output logic filtered_data
);
	logic pvalue, nvalue;
	/*
	always_ff @(posedge clk, reset)
		if(reset) begin
			pvalue <= 0;
			end
		else begin
			pvalue <= raw_data;
			if(pvalue == nvalue) begin
				filtered_data <= raw_data;
				end
			end
	
	always_ff @(negedge clk)
		if(reset) begin
			nvalue <= 0;
			end
		else begin
			nvalue <= raw_data;
		end
		*/
	always_ff @(posedge clk, reset)
		if(reset) begin
			pvalue<=0;
			nvalue<=0;
			end
		else begin
			nvalue<=pvalue;
			pvalue<=raw_data;
			end
			
	always_comb
		begin
			filtered_data = nvalue&pvalue;
		end
	

			
			
endmodule