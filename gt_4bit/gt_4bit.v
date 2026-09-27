module gt_4bit(
    input wire [3:0] a,b,
    output wire isgreater
);

    wire bitgreaterupper, bitequalupper, bitgreaterlower;

    gt_2bit gt2_upper(
        .a(a[3:2]),
        .b(b[3:2]),
        .isgreater(bitgreaterupper)
    );

    gt_2bit gt2_lower(
        .a(a[1:0]),
        .b(b[1:0]),
        .isgreater(bitgreaterlower)
    );

    eq_2bit eq2_upper(
        .a(a[3:2]),
        .b(b[3:2]),
        .isequal(bitequalupper)
    );

    assign isgreater = (bitgreaterupper) | (~bitgreaterupper & bitequalupper & bitgreaterlower);
    
endmodule