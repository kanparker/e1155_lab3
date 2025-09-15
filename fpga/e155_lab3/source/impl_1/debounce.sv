module debounce(
	input raw_data,
	input clk,
	output filtered_data
);


	logic [15:0] counter;
	logic [15:0] P;
	
	assign counter = 0;
	always_ff @(posedge clk,counter[15])
		counter = counter+P;
		if(counter[15])
			if(raw_data) begin
					filtered_data = 1'b1;
					P = 16'b1111111111111111;
				end
			else 
				begin
					filtered_data = 1'b0;
					counter = 0;
					P = 0;
				end
	
	always_ff @(posedge raw_data)
		P = 1;

	

			
			
endmodule