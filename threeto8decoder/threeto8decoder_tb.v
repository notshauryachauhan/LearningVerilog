`timescale 1ns/10ps

module threeto8decoder_testbench;
    reg [2:0] in1;

    wire [7:0] outtest;

    integer i;

    threeto8decoder uut (.in(in1), .out(outtest));

    initial
        begin

            $dumpfile("dump.vcd");
            $dumpvars(0, threeto8decoder_testbench);

            for (i = 0; i < 8; i = i + 1) begin
                in1 = i;
                #200;
            end

            $finish;
        end
    
endmodule