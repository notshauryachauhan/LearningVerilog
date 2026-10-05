module shift_register #(parameter bits = 8)(
    input wire clk, reset,
    input wire data_in,
    output wire data_out
);

/* one-segment style, less preffered 

reg [bits - 1 : 0] reg_state;

always @ (posedge clk) begin
    if(reset) reg_state <= 0;

    else reg_state <= {reg_state[bits-2:0], data_in};
    
end

assign data_out = reg_state[bits-1];

*/

// 2 segment

reg [bits - 1: 0] r_reg;
wire [bits - 1: 0] r_next;

always @ (posedge clk) begin
    if (reset) r_reg <= 0;

    else r_reg <= r_next;
end

assign r_next = {r_reg[bits-2:0], data_in};
assign data_out = r_reg[bits - 1];

endmodule