module lab3_top_tb();
    logic           clk;    // system clock
    logic           reset;  // active high reset
    tri     [3:0]   rows;   // 4-bit row output
    tri     [3:0]   cols;   // 4-bit column input
    logic   [3:0]   d0;     // new key
    logic   [3:0]   d1;     // previous key
	logic [6:0] seg;
	logic gate1, gate2;
    // matrix of key presses: keys[row][col]
    logic [3:0][3:0] keys;

    // dut
    top dut(clk, cols, reset, rows, d0, d1, seg, gate1, gate2);
	
	
    // ensures rows = 4'b0000 when no key is pressed
	pulldown(cols[0]);
    pulldown(cols[1]);
    pulldown(cols[2]);
    pulldown(cols[3]);

    // keypad model using tranif
    genvar r, c;
    generate
        for (r = 0; r < 4; r++) begin : row_loop
            for (c = 0; c < 4; c++) begin : col_loop
                // when keys[r][c] == 1, connect cols[c] <-> rows[r]
                tranif1 key_switch(rows[r], cols[c], keys[r][c]);
            end
        end
    endgenerate

    // generate clock
    always begin
        clk = 0; #5;
        clk = 1; #5;
    end

    // task to check expected values of d0 and d1
    task check_key(input [3:0] exp_d0, exp_d1, string msg);
        #500;
        assert (d0 == exp_d0 && d1 == exp_d1)
            $display("PASSED!: %s -- got d0=%h d1=%h expected d0=%h d1=%h at time %0t.", msg, d0, d1, exp_d0, exp_d1, $time);
        else
            $error("FAILED!: %s -- got d0=%h d1=%h expected d0=%h d1=%h at time %0t.", msg, d0, d1, exp_d0, exp_d1, $time);
        #50;
    endtask

    // apply stimuli and check outputs
    initial begin
        reset = 1;#22;

        // no key pressed
        keys = '{default:0};

        #22 reset = 0;
		#500
        // press key at row=0, col=0
        #50 keys[0][0] = 1;
		#500
        check_key(4'ha, 4'hx, "First key press");

        // release button
        keys[0][0] = 0;

        // press another key at row=1, col=0
        keys[1][0] = 1;
		#500
        check_key(4'h7, 4'ha, "Second key press");

        // release buttons
        #500 keys[1][0] = 0;

         
		
		 // press another key at row=2, col=0
        keys[2][0] = 1;
		#500
        check_key(4'h4, 4'h7, "third key press");

        // release buttons
        #500 keys[2][0] = 0;

        
		
		 // press another key at row=3, col=0
        keys[3][0] = 1;
		#500
        check_key(4'h1, 4'h4, "fourth key press");
		
		#500
		keys[3][0]=0;
		keys[0][1] = 1;
		#500
        check_key(4'h0, 4'h1, "fifth key press");

        // release button
        #500 keys[0][1] = 0;
		keys[1][1] = 1;
		#500
        check_key(4'h8, 4'h0, "sixth key press");

        // release button
        #500 keys[1][1] = 0;
		keys[2][1] = 1;
		#500
        check_key(4'h5, 4'h8, "seventh key press");

        // release button
        #500 keys[2][1] = 0;
		keys[3][1] = 1;
		#100
        check_key(4'h2, 4'h5, "eight key press");

        // release button
        #100 keys[3][1] = 0;
		keys[0][2] = 1;
		#100
        check_key(4'hb, 4'h2, "ninth key press");

        // release button
        #100 keys[0][2] = 0;
		keys[1][2] = 1;
		#100
        check_key(4'h9, 4'hb, "tenth key press");

        // release button
        #100 keys[1][2] = 0;
		
		keys[2][2] = 1;
		#100
        check_key(4'h6, 4'h9, "11th key press");

        // release button
        #100 keys[2][2] = 0;
		keys[3][2] = 1;
		#100
        check_key(4'h3, 4'h6, "12th key press");

        // release button
        #100 keys[3][2] = 0;
		keys[0][3] = 1;
		#100
        check_key(4'hf, 4'h3, "13th key press");

        // release button
        #100 keys[0][3] = 0;
		keys[1][3] = 1;
		#100
        check_key(4'he, 4'hf, "14th key press");

        // release button
        #100 keys[1][3] = 0;
		keys[2][3] = 1;
		#100
        check_key(4'hd, 4'he, "15th key press");

        // release button
        #100 keys[2][3] = 0;
		keys[3][3] = 1;
		#100
        check_key(4'hc, 4'hd, "16th key press");

        // release button
        #100 keys[3][3] = 0;
        // release buttons
        #100 keys = '{default:0};

		$stop;
    end

    // add a timeout
    initial begin
        #5000000; // wait 50 us
        $error("Simulation did not complete in time.");
        $stop;
    end
endmodule