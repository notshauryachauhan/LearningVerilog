`timescale 1ns/10ps

module gt_4bit_testbench;
    reg [3:0] test0_in, test1_in;
    wire test_out;

    integer i,j;

    gt_4bit uut(.a(test0_in), .b(test1_in), .isgreater(test_out));

    initial
        begin

            $dumpfile("dump.vcd");
            $dumpvars(0, gt_4bit_testbench);

            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    test0_in = i;
                    test1_in = j;
                    #200;
                end
            end

            $finish;
        end
    
endmodule

