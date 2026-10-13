module led_time_multiplexing(
    input wire [7:0] in0, in1, in2, in3,
    input wire clk,
    input wire reset,
    output reg [3:0] an,
    output reg [7:0] sseg
);

reg [17 : 0] r_reg;

wire [17 : 0] r_next;

always @ (posedge clk) begin
    if (reset) r_reg <= 0;
    else r_reg <= r_next;
end

assign r_next = r_reg + 1'b1;

always @(*) begin

    an = 4'b1111;
    sseg = 8'b00000000;

    case (r_reg[17:16])
        2'b00: begin
            an <= 4'b1110;
            sseg <= in0;
        end
        2'b01: begin
            an <= 4'b1101;
            sseg <= in1;
        end
        2'b10: begin
            an <= 4'b1011;
            sseg <= in2;
        end
        2'b11: begin
            an <= 4'b0111;
            sseg <= in3;
        end
    endcase
end

endmodule