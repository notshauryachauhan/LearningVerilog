`timescale 1ns/10ps

module hex_to_sseg_testbench;
    reg [3:0] hexnumbertest;
    reg dp;
    wire [7:0] ssegtest;
    
    hex_to_sseg uut(
        .hexnumber(hexnumbertest),
        .dp(dp),
        .sseg(ssegtest)
    );

    integer i;

    initial
        begin

            $dumpfile("dump.vcd");
            $dumpvars(0, hex_to_sseg_testbench);

            dp = 0;

            for (i = 0; i < 16; i = i + 1) begin
                hexnumbertest = i;
                #200;
            end

            dp = 1;

            for (i = 0; i < 16; i = i + 1) begin
                hexnumbertest = i;
                #200;
            end

        end
endmodule