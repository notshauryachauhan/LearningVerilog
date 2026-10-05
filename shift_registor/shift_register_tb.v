`timescale 1ns / 1ps

module shift_register_tb;

    // Testbench signals
    reg clk;
    reg reset;
    reg s_in;
    wire s_out;

    // Instantiate the two-segment shift register
    shift_register #(8) uut (
        .clk(clk),
        .reset(reset),
        .data_in(s_in),
        .data_out(s_out)
    );

    // Clock generator: toggles every 5ns to create a 10ns clock cycle
    always #5 clk = ~clk;

    initial begin
        // Generate waveform file for Surfer/GTKWave
        $dumpfile("dump.vcd");
        // Dump all variables in the testbench, and drill down into the UUT to see r_reg
        $dumpvars(0, shift_register_tb);

        // Monitor terminal output to watch the bits shift in real-time
        $monitor("Time=%0t | reset=%b | s_in=%b | r_reg=%b | s_out=%b", 
                 $time, reset, s_in, uut.r_reg, s_out);

        // 1. Initialize and apply reset
        clk = 0;
        s_in = 0;
        reset = 1;
        #15; // Hold reset high for a cycle and a half
        
        // Release reset
        reset = 0;
        #5;

        // 2. Feed a sequence of bits serially into s_in
        // We wait 10ns (one full clock cycle) between each input to sync with the clock
        s_in = 1; #10; // Shift in 1
        s_in = 0; #10; // Shift in 0
        s_in = 1; #10; // Shift in 1
        s_in = 1; #10; // Shift in 1
        s_in = 0; #10; // Shift in 0
        s_in = 0; #10; // Shift in 0
        s_in = 1; #10; // Shift in 1
        s_in = 1; #10; // Shift in 1 (Register should now hold 10110011)

        // 3. Feed zeros to flush the data out through s_out
        s_in = 0; #80;

        $finish;
    end

endmodule