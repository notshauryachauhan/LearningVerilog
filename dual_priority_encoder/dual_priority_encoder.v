module dual_priority_encoder(
    input [11:0] req,
    output reg [3:0] idx_out,
    output reg [3:0] idx_out_2
);

/* too programmy

integer i,j;

always @(req) begin :search_block
    idx_out = 4'b0;
    idx_out_2 = 4'b0;

    for(i = 11; i >=0; i = i - 1) begin
        if(req[i]) begin
            idx_out = i;
            for (j = i - 1; j >= 0; j = j - 1) begin
                if(req[j]) begin
                    idx_out_2 = j;
                    disable search_block;
                end
            end
            disable search_block;
        end
    end
    
end

*/

always @(*) begin

    idx_out = 4'b0;
    idx_out_2 = 4'b0;
    
    begin : find_first
        for (integer i = 11; i >= 0; i = i - 1) begin
            if (req[i]) begin
                idx_out = i;
                disable find_first; 
            end
        end
    end
    

    reg [11:0] masked_req;
    masked_req = req & ~(12'b1 << idx_out);
    

    begin : find_second
        for (integer j = 11; j >= 0; j = j - 1) begin
            if (masked_req[j]) begin
                idx_out_2 = j;
                disable find_second;
            end
        end
    end
end

endmodule