module floating_point_adder(
    input [12:0] a, b,
    output reg [12:0] result
);

    wire sign_a, sign_b;
    wire [3:0] exp_a, exp_b;
    wire [7:0] frac_a, frac_b;

    assign sign_a = a[12];
    assign exp_a  = a[11:8];
    assign frac_a = a[7:0];

    assign sign_b = b[12];
    assign exp_b  = b[11:8];
    assign frac_b = b[7:0];

    reg sign_big, sign_small;
    reg [3:0] exp_big, exp_small;
    reg [7:0] frac_big, frac_small;

    reg [3:0] exp_diff;
    reg [7:0] frac_small_aligned;

    reg [8:0] sum;
    reg [2:0] lead0;
    reg [7:0] frac_norm;
    reg [3:0] exp_norm;
    reg sign_norm;

    always @(*) begin
        if ({exp_a, frac_a} > {exp_b, frac_b}) begin
            sign_big   = sign_a;
            exp_big    = exp_a;
            frac_big   = frac_a;

            sign_small = sign_b;
            exp_small  = exp_b;
            frac_small = frac_b;
        end
        else begin
            sign_big   = sign_b;
            exp_big    = exp_b;
            frac_big   = frac_b;

            sign_small = sign_a;
            exp_small  = exp_a;
            frac_small = frac_a;
        end

        exp_diff           = exp_big - exp_small;
        frac_small_aligned = frac_small >> exp_diff;

        if (sign_big == sign_small)
            sum = {1'b0, frac_big} + {1'b0, frac_small_aligned};
        else
            sum = {1'b0, frac_big} - {1'b0, frac_small_aligned};

        if (sum[7])      lead0 = 3'd0;
        else if (sum[6]) lead0 = 3'd1;
        else if (sum[5]) lead0 = 3'd2;
        else if (sum[4]) lead0 = 3'd3;
        else if (sum[3]) lead0 = 3'd4;
        else if (sum[2]) lead0 = 3'd5;
        else if (sum[1]) lead0 = 3'd6;
        else             lead0 = 3'd7;

        if (sum[8]) begin
            exp_norm  = exp_big + 1'b1;
            frac_norm = sum[8:1];
            sign_norm = sign_big;
        end
        else if (sum[7:0] == 8'b0) begin
            exp_norm  = 4'b0000;
            frac_norm = 8'b00000000;
            sign_norm = 1'b0;
        end
        else if ({1'b0, lead0} > exp_big) begin
            exp_norm  = 4'b0000;
            frac_norm = 8'b00000000;
            sign_norm = 1'b0;
        end
        else begin
            exp_norm  = exp_big - lead0;
            frac_norm = sum[7:0] << lead0;
            sign_norm = sign_big;
        end

        result = {sign_norm, exp_norm, frac_norm};
    end

endmodule