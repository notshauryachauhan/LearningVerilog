`timescale 1ns/10ps

module twoto4decoder_testbench;
    reg [1:0] in1;
    reg en;

    wire [3:0] outtest;

    integer i;

    twoto4decoder uut(.en(en), .in(in1), .out(outtest));

    initial
        begin

            $dumpfile("dump.vcd");
            $dumpvars(0, twoto4decoder_testbench);


            en = 0;
            for (i = 0; i < 4; i = i + 1) begin
                in1 = i;
                #200;
            end

            en = 1;
            for (i = 0; i < 4; i = i + 1) begin
                in1 = i;
                #200;
            end

            $finish;
        end
    
endmodule