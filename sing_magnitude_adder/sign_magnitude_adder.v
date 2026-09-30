module sign_magnitude_adder(
    input [3:0] a, b,
    output reg [3:0] result
);

    always @* begin
        if (a[3] == b[3]) begin
            result[2:0] = a[2:0] + b[2:0];
            result[3] = a[3];
        end

        else begin
            if(a[2:0] > b[2:0]) begin
                result[2:0] = a[2:0] - b[2:0];
                result[3] = a[3];
            end

            else begin
                result[2:0] = b[2:0] - a[2:0];
                result[3] = b[3];
            end
        end

        if(result == 4'b1000) begin
            result = 4'b0000;
        end

    end

endmodule