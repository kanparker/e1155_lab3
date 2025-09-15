module stop_clamp(
	input logic [3:0] cin,
	output logic [3:0] clamps,
	output logic [3:0] cout,
	output logic stop
);
	logic [3:0]cin_cleaned;
	
	always_comb
		begin
			stop = |cin; // |cin;
			/*	
			// if (cin==4'b0) begin clamps, cout
			// else begin clamps = cin, cout = cin end
			case(cin)
				4'b0001: cin_cleaned = 4'b0001;
				4'b001?: cin_cleaned = 4'b0010;
				4'b01??: cin_cleaned = 4'b0100;
				4'b1???: cin_cleaned = 4'b1000;
			endcase
			// cintmp -> cin, casez 1???, 01??, ...
			if(cin==4'b0) begin
				clamps = 4'b1111;
				cout =4'b0;
				end
			else begin
				clamps = cin_cleaned;
				cout = cin_cleaned;
				end
			
			*/	
			case(cin[3:0])
				4'b0000: begin
					clamps[3:0] = 4'b1111;
					cout[3:0] = 4'b0000;
					end
				4'b0001: begin
					clamps[3:0] = 4'b0001;
					cout[3:0] = 4'b0001;
					end
				4'b0010: begin
					clamps[3:0] = 4'b0010;
					cout[3:0] = 4'b0010;
					end
				4'b0011: begin
					clamps[3:0] = 4'b0010;
					cout[3:0] = 4'b0010;
					end
				4'b0100: begin
					clamps[3:0] = 4'b0100;
					cout[3:0] = 4'b0100;
					end
				4'b0101: begin
					clamps[3:0] = 4'b0100;
					cout[3:0] = 4'b0100;
					end
				4'b0110: begin
					clamps[3:0] = 4'b0100;
					cout[3:0] = 4'b0100;
					end
				4'b0111: begin
					clamps[3:0] = 4'b0100;
					cout[3:0] = 4'b0100;
					end
				4'b1000: begin
					clamps[3:0] = 4'b1000;
					cout[3:0] = 4'b1000;
					end
				4'b1001: begin
					clamps[3:0] = 4'b1000;
					cout[3:0] = 4'b1000;
					end
				4'b1010: begin
					clamps[3:0] = 4'b1000;
					cout[3:0] = 4'b1000;
					end
				4'b1011: begin
					clamps[3:0] = 4'b1000;
					cout[3:0] = 4'b1000;
					end
				4'b1100: begin
					clamps[3:0] = 4'b1000;
					cout[3:0] = 4'b1000;
					end
				4'b1101: begin
					clamps[3:0] = 4'b1000;
					cout[3:0] = 4'b1000;
					end
				4'b1110: begin
					clamps[3:0] = 4'b1000;
					cout[3:0] = 4'b1000;
					end
				4'b1111: begin
					clamps[3:0] = 4'b1000;
					cout[3:0] = 4'b1000;
					end
			endcase
		end
endmodule