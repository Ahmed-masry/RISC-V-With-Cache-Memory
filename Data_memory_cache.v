module Data_memory_cache (
    input wire clk, rst,
    input wire rd_en_dm, wr_en_dm,
    input wire [31:0] data_in,
    input wire [9:0] address,
    output reg [127:0] data_out,
    output reg done
);

wire [9:0] wanted_address = {address[9:2], 2'b00};
reg [31:0] memory [0:1023]; // 4 KB word addressable
reg [1:0] counter;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        done <= 1'b0;
        counter <= 2'b0;
        data_out <= 128'b0;
    end else if (!rd_en_dm && wr_en_dm) begin
        counter <= counter + 1;
        memory[address] <= data_in;
        if (counter == 2'b11) begin
            done <= 1'b1;
            counter <= 2'b0;
        end else begin
            done <= 1'b0;
        end
    end else if (rd_en_dm && !wr_en_dm) begin
        data_out <= {memory[wanted_address + 3], memory[wanted_address + 2], memory[wanted_address + 1], memory[wanted_address]};
        counter <= counter + 1;
        if (counter == 2'b11) begin
            done <= 1'b1;
            counter <= 2'b0;
        end else begin
            done <= 1'b0;
        end
    end else begin
        done <= 1'b0;
    end
end

endmodule
