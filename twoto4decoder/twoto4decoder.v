module twoto4decoder(
    input wire en, 
    input wire [1:0] in,
    output wire p0, p1, p2, p3
);

    assign p0 = en & ~in[0] & ~in[1];
    assign p1 = en & ~in[1] &  in[0];
    assign p2 = en &  in[1] & ~in[0];
    assign p3 = en &  in[0] &  in[1];

endmodule