`timescale 1ns / 1ps

module universal_shift_register_tb;

    // Parameters and signals
    parameter bits = 8;
    reg clk;
    reg reset;
    reg [1:0] ctrl;
    reg [bits-1:0] d;
    wire [bits-1:0] q;

    universal_shift_register #(bits) uut (
        .clk(clk),
        .reset(reset),
        .ctrl(ctrl),
        .d(d),
        .q(q)
    );

    // 10ns Clock generator
    always #5 clk = ~clk;

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, universal_shift_register_tb);

        // Monitor prints whenever a variable changes
        $monitor("Time=%0t | reset=%b | ctrl=%b | d=%b | q=%b", 
                 $time, reset, ctrl, d, q);

        // 1. Initialize and assert reset
        clk = 0;
        reset = 1;
        ctrl = 2'b00;
        d = 8'b00000000;
        #15; // Hold reset across the first clock edge
        
        reset = 0;
        #5;

        // 2. Test Parallel Load (ctrl = 11)
        // This instantly fills the register with a known pattern
        ctrl = 2'b11;
        d = 8'b10100101; 
        #10; 

        // 3. Test Hold State (ctrl = 00)
        // Changing 'd' here should do absolutely nothing to 'q'
        ctrl = 2'b00;
        d = 8'b11111111; 
        #20; // Hold for two full clock cycles

        // 4. Test Shift Left (ctrl = 10)
        ctrl = 2'b10;
        d = 8'b00000001; // d[0] is 1
        #10; 
        d = 8'b00000000; // d[0] is 0
        #20; // Shift in two 0s

        // 5. Test Shift Right (ctrl = 01)
        ctrl = 2'b01;
        d = 8'b10000000; // d[7] is 1
        #10;
        d = 8'b00000000; // d[7] is 0
        #20; // Shift in two 0s

        // 6. Final Parallel Clear
        ctrl = 2'b11;
        d = 8'b00000000;
        #10;

        $finish;
    end

endmodule