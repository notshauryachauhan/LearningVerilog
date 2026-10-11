module free_running_binary_counter #(parameter bits = 8) (
    input wire clk,
    input wire reset,
    output wire max_tick,
    output wire [bits - 1 : 0] count
);

reg [bits - 1 : 0] r_reg;

wire [bits - 1 : 0] r_next;

always @ (posedge clk) begin
    if (reset) r_reg <= 0;
    else r_reg <= r_next;
end

assign r_next = r_reg + 1'b1;

assign count = r_reg;
assign max_tick = (r_reg == (2**bits - 1)) ? 1'b1 : 1'b0;

endmodule