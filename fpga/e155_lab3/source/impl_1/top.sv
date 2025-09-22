module top(
	//input logic clk,
	input logic [3:0]cols,
	input logic reset,
	output logic [3:0]rows,
	output logic [3:0] d0, d1,
	output logic [6:0]seg,
	output logic gate1, gate2
);
	//logic clk;
	logic tenkhz_clock,onekhz_clock,twkhz_clock,stop;
	logic [3:0] control_1, control_2;
	logic [3:0] csynched,cdebounced,cout,clamp;
	logic [31:0] p1, p2, p3;
	
	assign p1 = 32'b00000000000000010101111110010000;
	assign p2 = 32'b00000000000011011010011101000000;
	assign p3 = 32'b00000000000000001010111111001000;
	//assign p1 = 32'b10000000000000000000000011010111;
	//assign p2 = 32'b10000000000000000000100001100011;
	
	HSOC high_speed_clock(clk);
	clock_divider one_khz_clock(clk,p1,reset,onekhz_clock);
	clock_divider tenk_hz_clock(clk,p2,reset,tenkhz_clock);
	clock_divider twk_hz_clock(clk,p3,reset,twkhz_clock);

	//assign tenkhz_clock = clk;
	//assign onekhz_clock = clk;
	/*
	synch - 10k
	debounce- 1k 
	readwrite - 10k 
	display - 1K clock
	*/
	//rowsweeper
	row_sweep row_sweeper(twkhz_clock,reset,~stop,rows);
	//synchronizer
	synchronizer synchc0(cols[0],tenkhz_clock,reset,clamp[0],csynched[0]);
	synchronizer synchc1(cols[1],tenkhz_clock,reset,clamp[1],csynched[1]);
	synchronizer synchc2(cols[2],tenkhz_clock,reset,clamp[2],csynched[2]);
	synchronizer synchc3(cols[3],tenkhz_clock,reset,clamp[3],csynched[3]);
	
	//debouncer
	debounce debounce0(onekhz_clock,reset,csynched[0],cdebounced[0]);
	debounce debounce1(onekhz_clock,reset,csynched[1],cdebounced[1]);
	debounce debounce2(onekhz_clock,reset,csynched[2],cdebounced[2]);
	debounce debounce3(onekhz_clock,reset,csynched[3],cdebounced[3]);
	
	//stop_clamp
	stop_clamp filter_enabler(cdebounced,clamp,cout,stop);
	
	//read_write
	read_writer read_write(tenkhz_clock,reset,rows,cout,control_1,control_2);
	
	//display driver
	display_driver display_outputs(onekhz_clock,control_1,control_2,seg,gate1,gate2);
	
	assign d0 = control_1;
	assign d1 = control_2;
endmodule