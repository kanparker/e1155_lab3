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
    top dut(.clk(clk), .cols(cols), .reset(reset), .rows(rows), .d0(d0), .d1(d1), .seg(seg), .gate1(gate1), .gate2(gate2));
	
    // ensures rows = 4'b1111 when no key is pressed
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
        #100;
        assert (d0 == exp_d0 && d1 == exp_d1)
            $display("PASSED!: %s -- got d0=%h d1=%h expected d0=%h d1=%h at time %0t.", msg, d0, d1, exp_d0, exp_d1, $time);
        else
            $error("FAILED!: %s -- got d0=%h d1=%h expected d0=%h d1=%h at time %0t.", msg, d0, d1, exp_d0, exp_d1, $time);
        #50;
    endtask

    // apply stimuli and check outputs
    initial begin
        reset = 1;

        // no key pressed
        keys = '{default:0};

        #22 reset = 0;
		
        // press key at row=1, col=2
        #50 keys[1][2] = 1;
        check_key(4'h0, 4'hx, "First key press");

        // release button
        keys[1][2] = 0;

        // press another key at row=0, col=0
        keys[2][3] = 1;
        check_key(4'hc, 4'h6, "Second key press");

        // release buttons
        #100 keys = '{default:0};

        #100 $stop;
    end

    // add a timeout
    initial begin
        #5000; // wait 5 us
        $error("Simulation did not complete in time.");
        $stop;
    end
endmodule