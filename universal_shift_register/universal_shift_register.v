module universal_shift_register #(parameter bits = 8)(
    input wire clk,
    input wire reset,
    input wire [1:0] ctrl,
    input wire [bits - 1 : 0] d,
    output wire [bits - 1 : 0] q
);

reg [bits - 1 : 0] r_reg;
reg [bits - 1 : 0] r_next;

always @ (posedge clk) begin
    if (reset) r_reg <= 0;
    else r_reg <= r_next;
end

always @ (*) begin
    case (ctrl)
        2'b00: r_next = r_reg;
        2'b01: r_next = {d[bits - 1], r_reg[bits-1:1] };
        2'b10: r_next = {r_reg[bits-2:0], d[0]};
        2'b11: r_next = d;
    endcase
end

assign q = r_reg;

endmodule