`timescale 1ns/10ps

module twoto4decoder_testbench;
    reg [1:0] in1;
    reg en;

    wire p0, p1, p2, p3;

    integer i;

    twoto4decoder uut(.en(en), .in(in1), .p0(p0), .p1(p1), .p2(p2), .p3(p3));

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