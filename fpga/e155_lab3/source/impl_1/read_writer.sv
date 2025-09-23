module read_writer(
	input logic clk, reset,
	input logic [3:0] rows, columns,
	output logic [3:0] control_1, control_2
);
	logic cstatus;
	logic [3:0] new_control, next_control_1,next_control_2;
	typedef enum logic[3:0]{idle, update, hold} states;
	states current_state, next_state;
	
	
	
	always_ff @(posedge clk, reset)
		if(reset) begin
			current_state<= idle;
			control_1<=4'b0000;
			control_2<=4'b0000;
			end
		else begin
			current_state<=next_state;
			control_1<=next_control_1;
			control_2<=next_control_2;
			end
	
	always_comb
		begin
			cstatus = |columns;
			case(rows)
				4'b0001: begin
						case(columns)
							4'b0001: new_control = 4'b1010;
							4'b0010: new_control = 4'b0000;
							4'b0100: new_control = 4'b1011;
							4'b1000: new_control = 4'b1111;
							default: new_control = 4'b0000;
						endcase
					end
				4'b0010: begin
						case(columns)
							4'b0001: new_control = 4'b0111;
							4'b0010: new_control = 4'b1000;
							4'b0100: new_control = 4'b1001; 
							4'b1000: new_control = 4'b1110;
							default: new_control = 4'b0000;
						endcase
					end
				4'b0100: begin
					case(columns)
							4'b0001: new_control = 4'b0100;
							4'b0010: new_control = 4'b0101;
							4'b0100: new_control = 4'b0110;
							4'b1000: new_control = 4'b1101;
							default: new_control = 4'b0000;
						endcase
					end
				4'b1000:begin
					case(columns)
							4'b0001: new_control = 4'b0001;
							4'b0010: new_control = 4'b0010;
							4'b0100: new_control = 4'b0011;
							4'b1000: new_control = 4'b1100;
							default: new_control = 4'b0000;
						endcase
					end
				default: new_control =4'b0000;
			
			endcase
			end
			
			always_comb begin
			case(current_state)
				idle: begin
					next_control_1 = control_1;
					next_control_2 = control_2;
					if(cstatus) begin
						next_state = update;
						end
					else next_state = idle;
					end
				
				update: begin
					next_control_2 = control_1;
					next_control_1 = new_control;
					next_state = hold;
					end
					
				hold: begin
					next_control_1 = control_1;
					next_control_2 = control_2;
					if(cstatus) next_state = hold;
					else next_state = idle;
					end
				default: begin
						next_state = idle;
						next_control_1 = control_1;
						next_control_2 = control_2;
						end
			endcase
		
			end
		
		
endmodule