module bcd_incrementor(
    input wire [11:0] inputnumber,
    output wire [11:0] outputnumber
);

reg [3:0] firstdigit, seconddigit, thirddigit;
reg [3:0] firstdigitincremented, seconddigitincremented, thirddigitincremented;

always @(*) begin

    firstdigit = inputnumber[3:0];
    seconddigit = inputnumber[7:4];
    thirddigit = inputnumber[11:8];
    
    seconddigitincremented = inputnumber[7:4];
    thirddigitincremented = inputnumber [11:8];

    firstdigitincremented = firstdigit + 1;

    if(firstdigitincremented == 4'b1010) begin
        firstdigitincremented = 4'b0;
        seconddigitincremented = seconddigit + 1;

        if(seconddigitincremented == 4'b1010) begin
            seconddigitincremented = 4'b0;
            thirddigitincremented = thirddigit + 1;

            if(thirddigitincremented == 4'b1010) begin
                thirddigitincremented = 4'b0;
            end
        end
    end
end

assign outputnumber = {thirddigitincremented, seconddigitincremented, firstdigitincremented};

endmodule