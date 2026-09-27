module fourto16decoder(
    input wire [3:0] in,
    output wire [15:0] out
);

    twoto4decoder zerotothree (.in(in[1:0]), .en(~in[2] & ~in[3]), .out(out[3:0]));
    twoto4decoder fourtoseven (.in(in[1:0]), .en(in[2] & ~in[3]), .out(out[7:4]));
    twoto4decoder eighttoeleven (.in(in[1:0]), .en(~in[2] & in[3]), .out(out[11:8]));
    twoto4decoder twelvetofifteen (.in(in[1:0]), .en(in[2] & in[3]), .out(out[15:12]));

endmodule