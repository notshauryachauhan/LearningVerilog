module twoto4decoder(
    input wire en, 
    input wire [1:0] in,
    output wire [3:0] out
);

    assign out[0] = en & ~in[0] & ~in[1];
    assign out[1] = en & ~in[1] &  in[0];
    assign out[2] = en &  in[1] & ~in[0];
    assign out[3] = en &  in[0] &  in[1];

endmodule