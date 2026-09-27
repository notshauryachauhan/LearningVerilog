`timescale 1ns/10ps

module fourto16decoder_testbench;
    reg [3:0] in1;

    wire [15:0] outtest;

    integer i;

    fourto16decoder uut (.in(in1), .out(outtest));

    initial
        begin

            $dumpfile("dump.vcd");
            $dumpvars(0, fourto16decoder_testbench);

            for (i = 0; i < 16; i = i + 1) begin
                in1 = i;
                #200;
            end

            $finish;
        end
    
endmodule