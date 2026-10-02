`timescale 1ns/10ps

module barrel_shifter_tb;
    reg [7:0] inputtest;
    reg [2:0] amttest;
    wire [7:0] outputtest;

    barrel_shifter uut(
        .a(inputtest),
        .amt(amttest),
        .y(outputtest)
    );

    integer i, j;

    initial
        begin

        $dumpfile("dump.vcd");
        $dumpvars(0, barrel_shifter_tb);


        for(i = 0; i < 256; i = i + 1) begin
            inputtest = i;
            for(j = 0; j < 8; j = j+1) begin
                amttest = j;
                #200;
            end
        end

        $finish;

        end

endmodule
