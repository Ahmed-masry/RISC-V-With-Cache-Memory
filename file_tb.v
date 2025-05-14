module tb_Data_memory_cache;

reg clk, rst;
reg rd_en_dm, wr_en_dm;
reg [31:0] data_in;
reg [9:0] address;
wire [127:0] data_out;
wire done;

Data_memory_cache uut (
  .clk(clk),
  .rst(rst),
  .rd_en_dm(rd_en_dm),
  .wr_en_dm(wr_en_dm),
  .data_in(data_in),
  .address(address),
  .data_out(data_out),
  .done(done)
);

initial begin
  // Clock generation
  clk = 0;
  forever #5 clk = ~clk;
end

initial begin
  // Initialize inputs
  rst = 1;
  rd_en_dm = 0;
  wr_en_dm = 0;
  data_in = 32'b0;
  address = 10'b0;
  
  // Reset the module
  #10 rst = 0;

  // Write some data to memory
  #10 wr_en_dm = 1; address = 10'b0; data_in = 32'hAABBCCDD;
  #20 wr_en_dm = 0;

  // Read the data from memory
  #10 rd_en_dm = 1; address = 10'b0;
  #20 rd_en_dm = 0;

  // Check output
  #10 $display("Data Out: %h", data_out);
  
  // End the simulation
  #10 $finish;
end

endmodule

