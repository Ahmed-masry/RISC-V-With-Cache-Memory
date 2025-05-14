module Data_memory_system_module (
    input wire clk,
    input wire rst,
    input wire mem_read,
    input wire mem_write,
    input wire [9:0] word_address,
    input wire [31:0] data_in,
    output wire stall,
    output wire [31:0] data_out
);

wire wr_en_cm, rd_en_cm, mem_to_cache_en, wr_en_dm, rd_en_dm;
wire [127:0] data_out_dm;
wire hit_miss, done;

// Cache Control Module
Cache_controler cache_ctrl (
    .clk(clk),
    .rst(rst),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .hit_miss(hit_miss),
    .done(done),
    .stall(stall),
    .wr_en_cm(wr_en_cm),
    .rd_en_cm(rd_en_cm),
    .mem_to_cache_en(mem_to_cache_en),
    .wr_en_dm(wr_en_dm),
    .rd_en_dm(rd_en_dm)
);

// Data Memory Cache Module
Data_memory_cache data_mem_cache (
    .clk(clk),
    .rst(rst),
    .rd_en_dm(rd_en_dm),
    .wr_en_dm(wr_en_dm),
    .data_in(data_in),
    .address(word_address),
    .data_out(data_out_dm),
    .done(done)
);

// Cache Memory Module
cache_memory cache_mem (
    .clk(clk),
    .rst(rst),
    .wr_en_cm(wr_en_cm),
    .rd_en_cm(rd_en_cm),
    .mem_to_cache_en(mem_to_cache_en),
    .address(word_address),
    .data_in_dm(data_out_dm),
    .data_in_mc(data_in),
    .hit_miss(hit_miss),
    .data_out(data_out)
);

endmodule
