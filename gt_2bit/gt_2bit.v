module gt_2bit(
    input wire [1:0] a, b,
    output wire isgreater
);

    assign isgreater = (a[1] & ~b[1]) | (a[0] & ~b[1] & ~b[0]) | (a[0]  & a[1] & ~b[0]);

endmodule