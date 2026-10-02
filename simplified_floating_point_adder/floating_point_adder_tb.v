
`timescale 1ns/1ps

module tb;
    reg [12:0] a, b;
    wire [12:0] result;
    floating_point_adder uut (
        .a(a),
        .b(b),
        .result(result)
    );
    initial begin
        // Case 1: +1.0 + +1.0 (sign=0, exp=3, frac=8'h80)
        a = {1'b0, 4'd3, 8'h80};
        b = {1'b0, 4'd3, 8'h80};
        #10;
        $display("Case 1: a=%h b=%h -> result=%h (expected: 0480)", a, b, result);
        // Case 2: +1.0 + -1.0
        a = {1'b0, 4'd3, 8'h80};
        b = {1'b1, 4'd3, 8'h80};
        #10;
        $display("Case 2: a=%h b=%h -> result=%h (expected: 0000)", a, b, result);
        // Case 3: +1.0 + -0.75 (0.75 has exp=3, frac=8'h60)
        // 1.0 - 0.75 = 0.25 -> exp=1, frac=8'h80 -> result = {0, 4'd1, 8'h80} = 0180
        a = {1'b0, 4'd3, 8'h80};
        b = {1'b1, 4'd3, 8'h60};
        #10;
        $display("Case 3: a=%h b=%h -> result=%h (expected: 0180)", a, b, result);
        // Case 4: +2.0 + +0.5
        // 2.0 = exp=4, frac=8'h80
        // 0.5 = exp=2, frac=8'h80 -> aligned >> 2 = 8'h20
        // sum = 8'h80 + 8'h20 = 8'hA0 (exp=4, frac=8'hA0) -> 04A0
        a = {1'b0, 4'd4, 8'h80};
        b = {1'b0, 4'd2, 8'h80};
        #10;
        $display("Case 4: a=%h b=%h -> result=%h (expected: 04a0)", a, b, result);
        $finish;
    end
endmodule