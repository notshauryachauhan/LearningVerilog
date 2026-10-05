`timescale 1ns/1ps

module bcd_incrementor_testbench();
    reg [11:0] testinput;
    wire [11:0] actualoutput;

    bcd_incrementor uut (
        .inputnumber(testinput), 
        .outputnumber(actualoutput)
    );

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, bcd_incrementor_testbench);
        
        // %h prints the values in hex, which visually matches BCD perfectly
        $monitor("Time=%0t | Input=%h | Output=%h", $time, testinput, actualoutput);

        testinput = 12'h000; #20;
        testinput = 12'h001; #20;
        testinput = 12'h009; #20;
        testinput = 12'h010; #20;
        testinput = 12'h099; #20;
        testinput = 12'h120; #20;
        testinput = 12'h999; #20;

        $finish;
    end
endmodule