/*

module fifo_buffer(
    input wire [7:0] din,
    output wire [7:0] dout,
    input wire clk, rst, we, re,
    output reg full, empty
);

    reg [7:0] buffer [7:0];
    reg [7:0] buffer_next [7:0];

    reg [2:0] read_counter, read_counter_next;
    reg [2:0] write_counter, write_counter_next;

    reg full_next, empty_next;

    assign dout = buffer[read_counter];

    always @ (posedge clk or posedge rst) begin
        if (rst) begin
            read_counter  <= 3'b000;
            write_counter <= 3'b000;
            full          <= 1'b0;
            empty         <= 1'b1;
        end else begin
            read_counter  <= read_counter_next;
            write_counter <= write_counter_next;
            buffer        <= buffer_next;
            full          <= full_next;
            empty         <= empty_next;
        end
    end

    always @ (*) begin
        buffer_next        = buffer;
        read_counter_next  = read_counter;
        write_counter_next = write_counter;
        full_next          = full;
        empty_next         = empty;

        if (we & ~re & ~full) begin
            buffer_next[write_counter] = din;
            write_counter_next = write_counter + 3'b001;
            
            empty_next = 1'b0;
            
            if (write_counter_next == read_counter) begin
                full_next = 1'b1;
            end
        end
        
        else if (re & ~we & ~empty) begin
            read_counter_next = read_counter + 3'b001;
            
            full_next = 1'b0;
            
            if (read_counter_next == write_counter) begin
                empty_next = 1'b1;
            end
        end
    end

endmodule

*/

// apparently this is the industry standard way

module fifo_buffer(
    input wire [7:0] din,
    output wire [7:0] dout,
    input wire clk, rst, we, re,
    output wire full, empty
);

    reg [7:0] buffer [7:0];
    reg [7:0] buffer_next [7:0];

    reg [3:0] read_counter, read_counter_next;
    reg [3:0] write_counter, write_counter_next;

    always @ (posedge clk or posedge rst) begin
        if (rst) begin
            read_counter  <= 4'b0000;
            write_counter <= 4'b0000;
        end else begin
            read_counter  <= read_counter_next;
            write_counter <= write_counter_next;
            buffer        <= buffer_next; 
        end
    end

    always @ (*) begin
        buffer_next        = buffer;
        read_counter_next  = read_counter;
        write_counter_next = write_counter;

        if (we & ~full) begin
            buffer_next[write_counter[2:0]] = din;
            write_counter_next = write_counter + 4'b0001;
        end
        
        if (re & ~empty) begin
            read_counter_next = read_counter + 4'b0001;
        end
    end
    
    assign dout = buffer[read_counter[2:0]];

    assign empty = (write_counter == read_counter);

    assign full = (write_counter[2:0] == read_counter[2:0]) && 
                  (write_counter[3] != read_counter[3]);

endmodule