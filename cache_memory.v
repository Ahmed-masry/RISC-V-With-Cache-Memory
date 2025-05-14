module cache_memory (
    input wire clk, rst,
    input wire wr_en_cm, rd_en_cm, mem_to_cache_en,
    input wire [9:0] address,
    input wire [127:0] data_in_dm,
    input wire [31:0] data_in_mc,
    output wire hit_miss,
    output reg [31:0] data_out
); 

reg [127:0] cache_mem[0:31];
reg [2:0] tag[0:31];
reg valid[0:31];

assign hit_miss = ((tag[address[6:2]] == address[9:7]) && (valid[address[6:2]] == 1'b1));
integer i;

always @(posedge clk, posedge rst) begin
    if (rst) begin
        data_out <= 'b0;
        for (i = 0; i < 32; i = i + 1) begin
            tag[i] <= 'b0;
            valid[i] <= 'b0;
            cache_mem[i] <= 'b0;
        end
    end else if (wr_en_cm && !rd_en_cm && !mem_to_cache_en) begin
        case (address[1:0])
            2'b11: cache_mem[address[6:2]][127:96] <= data_in_mc;
            2'b10: cache_mem[address[6:2]][95:64] <= data_in_mc;
            2'b01: cache_mem[address[6:2]][63:32] <= data_in_mc;
            2'b00: cache_mem[address[6:2]][31:0] <= data_in_mc;
        endcase
    end else if (!wr_en_cm && !rd_en_cm && mem_to_cache_en) begin
        cache_mem[address[6:2]] <= data_in_dm;
        tag[address[6:2]] <= address[9:7];
        valid[address[6:2]] <= 1'b1;
    end
end

always @* begin
    if (!wr_en_cm && rd_en_cm && !mem_to_cache_en) begin
        case (address[1:0])
            2'b11: data_out = cache_mem[address[6:2]][127:96];
            2'b10: data_out = cache_mem[address[6:2]][95:64];
            2'b01: data_out = cache_mem[address[6:2]][63:32];
            2'b00: data_out = cache_mem[address[6:2]][31:0];
        endcase
    end else begin
        data_out = data_out;
    end
end

endmodule
