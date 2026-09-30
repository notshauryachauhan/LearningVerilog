`timescale 1ns/10ps

module sign_magnitude_adder_testbench;
    reg [3:0] a,b;
    wire [3:0] addertest;
    
    sign_magnitude_adder uut(
        .a(a), .b(b), .result(addertest)
    );

    integer i,j;

    initial
        begin

            $dumpfile("dump.vcd");
            $dumpvars(0, sign_magnitude_adder_testbench);
            $monitor("Time=%0t | a=%b b=%b | result=%b", $time, a, b, addertest);

            for (i = 0; i < 16; i = i + 1) begin
                a = i;
                for (j = 0; j < 16; j = j + 1) begin
                    b = j;
                    #200;
                end
            end

        end
endmodule