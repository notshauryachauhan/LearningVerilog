`timescale 1ns/1ps

module dual_priority_encoder_tb;

    // Testbench signals: reg for inputs, wire for outputs
    reg [11:0] req;
    wire [3:0] idx_out;
    wire [3:0] idx_out_2;

    // Instantiate the Unit Under Test (UUT)
    dual_priority_encoder uut (
        .req(req),
        .idx_out(idx_out),
        .idx_out_2(idx_out_2)
    );

    initial begin
        // Generate waveform file for Surfer/GTKWave
        $dumpfile("dump.vcd");
        $dumpvars(0, dual_priority_encoder_tb);
        
        // Print updates to the terminal whenever a signal changes
        $monitor("Time=%0t | req=%b | first=%d second=%d", $time, req, idx_out, idx_out_2);

        // Test 1: Only one bit is active (Bit 5)
        // Expect: first = 5, second = 0
        req = 12'b0000_0010_0000; 
        #10;

        // Test 2: Two standard active bits (Bits 9 and 2)
        // Expect: first = 9, second = 2
        req = 12'b0010_0000_0100; 
        #10;

        // Test 3: Adjacent highest bits (Bits 11 and 10)
        // Expect: first = 11, second = 10
        req = 12'b1100_0000_0000; 
        #10;

        // Test 4: All bits active (Stress test)
        // Expect: first = 11, second = 10 (the rest are ignored)
        req = 12'b1111_1111_1111; 
        #10;

        // Test 5: No bits active
        // Expect: first = 0, second = 0
        req = 12'b0000_0000_0000; 
        #10;
        
        // Test 6: Lowest possible bits (Bits 1 and 0)
        // Expect: first = 1, second = 0
        req = 12'b0000_0000_0011; 
        #10;

        $finish; // End the simulation
    end

endmodule