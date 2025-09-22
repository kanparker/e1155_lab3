module row_sweep(
	input logic clk, reset,
	input logic stop,
	output logic [3:0] rows
);
	logic [1:0]current_state = 2'b00;
	typedef enum logic[3:0]{r1=4'b0001, r2 = 4'b0010, r3=4'b0100, r4=4'b1000} row_output;
	row_output output_state;

	
	always_ff@(posedge clk, reset)
		if(reset) begin
			current_state <= 2'b00;			end
		else if(stop)
			begin
				current_state <= current_state + 2'b01;
			end
		else begin
			current_state <= current_state;
		end
	always_comb
		begin
			case(current_state)
				2'b00: output_state = r1;
				2'b01: output_state =r2;
				2'b10: output_state = r3;
				2'b11: output_state = r4;
				default: output_state = r1;
			endcase
		end
	assign rows = output_state;
	
endmodule