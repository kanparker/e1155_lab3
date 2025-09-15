module synchronizer(
	input logic [3:0] cin,
	input logic clk, reset,
	output logic [3:0] cout
);
	logic [3:0] cmid;
	
	always_ff @(posedge clk, reset)
		if(reset) begin
			cmid[3:0] <= 4'b0000;
			cout[3:0] <= 4'b0000;
			end
		else begin
			cout <= cmid;
			cmid <= cin;
			end
		
	

			
			
endmodule