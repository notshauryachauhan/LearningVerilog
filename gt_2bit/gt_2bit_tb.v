`timescale 1ns/10ps

module gt_2bit_testbench;
    reg [1:0] test_in0, test_in1;
    wire test_out;

    gt_2bit uut(.a(test_in0), .b(test_in1), .isgreater(test_out));

    initial
        begin

            $dumpfile("dump.vcd");
            $dumpvars(0, gt_2bit_testbench);

            //test vector 1
            test_in0 = 2'b00;
            test_in1 = 2'b00;
            #200;

            //test vector 2
            test_in0 = 2'b00;
            test_in1 = 2'b01;
            #200;

            //test vector 3
            test_in0 = 2'b00;
            test_in1 = 2'b10;
            #200;

            //test vector 4
            test_in0 = 2'b00;
            test_in1 = 2'b11;
            #200;

            //test vector 5
            test_in0 = 2'b01;
            test_in1 = 2'b00;
            #200;

            //test vector 6
            test_in0 = 2'b01;
            test_in1 = 2'b01;
            #200;

            //test vector 7
            test_in0 = 2'b01;
            test_in1 = 2'b10;
            #200;

            //test vector 8
            test_in0 = 2'b01;
            test_in1 = 2'b11;
            #200;

            //test vector 9
            test_in0 = 2'b10;
            test_in1 = 2'b00;
            #200;

            //test vector 10
            test_in0 = 2'b10;
            test_in1 = 2'b01;
            #200;

            //test vector 11
            test_in0 = 2'b10;
            test_in1 = 2'b10;
            #200;

            //test vector 12
            test_in0 = 2'b10;
            test_in1 = 2'b11;
            #200;

            //test vector 13
            test_in0 = 2'b11;
            test_in1 = 2'b00;
            #200;

            //test vector 14
            test_in0 = 2'b11;
            test_in1 = 2'b01;
            #200;

            //test vector 15
            test_in0 = 2'b11;
            test_in1 = 2'b10;
            #200;

            //test vector 16
            test_in0 = 2'b11;
            test_in1 = 2'b11;
            #200;

            $finish;
        end
    
endmodule