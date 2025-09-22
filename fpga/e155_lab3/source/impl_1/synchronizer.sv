module synchronizer(
	input logic cin,
	input logic clk, reset, clamp,
	output logic cout
);
	logic cmid;
	
	always_ff @(posedge clk, reset)
		if(reset) begin
			cmid <= 1'b0;
			cout <= 1'b0;
			end
		else if(clamp) begin
				cout <= cmid;
				cmid <= cin;
				end
		else begin
				cout<= 1'b0;
			end
			
		
	

			
			
endmodule