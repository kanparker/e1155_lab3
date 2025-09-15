module stop_clamp(
	input logic [3:0]cin,
	output logic stop,
	output logic [3:0]clamps,
	output logic [3:0] cout
);

	always_comb
	begin
		stop = (cin[0]|cin[1])|(cin[2]|cin[3]);
			
		case(cin[3:0])
			4'b0000: begin
				clamps[3:0] = 4'b1111;
				cout[3:0] = 4'b0000;
				end
			4'b0001: begin
				clamps[3:0] = 4'b0001;
				cout[3:0] = 4'b0001;
				end
			4'b001x: begin
				clamps[3:0] = 4'b0010;
				cout[3:0] = 4'b0010;
				end
			4'b01xx: begin
				clamps[3:0] = 4'b0100;
				cout[3:0] = 4'b0100;
				end
			4'b1xxx: begin
				clamps[3:0] = 4'b1000;
				cout[3:0] = 4'b1000;
				end
			default: begin
				clamps[3:0] = 4'b1111;
				cout[3:0] = 4'b0000;
				end
		endcase
	end
endmodule