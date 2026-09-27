module threeto8decoder(
    input wire [2:0] in,
    output wire [7:0] out
);

    twoto4decoder twoto4lower (.in(in[1:0]), .en(~in[2]), .out(out[3:0]));
    twoto4decoder twoto4upper (.in(in[1:0]), .en(in[2]), .out(out[7:4]));

endmodule