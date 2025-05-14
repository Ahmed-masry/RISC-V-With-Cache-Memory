module Cache_controler (
  input wire clk, rst,
  input wire mem_read, mem_write,
  input wire hit_miss,
  input wire done, 
  output reg stall,
  output reg wr_en_cm, rd_en_cm, mem_to_cache_en,
  output reg wr_en_dm, rd_en_dm
);

  localparam idle     = 3'b000,
             reading  = 3'b001,
             reading_stall = 3'b010,
             writing       = 3'b011,
             writing_stall = 3'b100;

  reg [2:0] c_state, n_state;

  // State transition
  always @(posedge clk or posedge rst) begin
    if (rst)
      c_state <= idle;
    else
      c_state <= n_state;
  end

  // State machine logic
  always @* begin
    // Default values
    stall           = 1'b0;
    wr_en_cm        = 1'b0;
    rd_en_cm        = 1'b0;
    mem_to_cache_en = 1'b0;
    wr_en_dm        = 1'b0;
    rd_en_dm        = 1'b0;
    n_state         = c_state;

    case (c_state)
      idle: begin
        if (mem_read && hit_miss && !mem_write) begin
          n_state   = idle;
          stall     = 1'b0;
          rd_en_cm  = 1'b1;
        end else if (mem_read && !hit_miss && !mem_write) begin
          n_state   = reading;
          stall     = 1'b1;
          mem_to_cache_en = 1'b1;
        end else if (mem_write && !mem_read) begin
          n_state   = writing;
          stall     = 1'b1;
        
        end
      end

      reading: begin
        n_state         = reading_stall;
        stall           = 1'b1;
        rd_en_dm        = 1'b1;
        mem_to_cache_en = 1'b1;
      end

      reading_stall: begin
        if (done) begin
          stall           = 1'b0;
          rd_en_dm        = 1'b0;
          mem_to_cache_en = 1'b0;
          rd_en_cm        = 1'b1;
          n_state         = idle;
        end else begin
          stall           = 1'b1;
          rd_en_dm        = 1'b1;
          mem_to_cache_en = 1'b1;
          rd_en_cm        = 1'b0;
        end
      end

      writing: begin
        if (hit_miss) begin
          wr_en_cm        = 1'b1;
          wr_en_dm        = 1'b1;
          stall           = 1'b1;
          n_state         = writing_stall;
        end else begin
          wr_en_cm        = 1'b0;
          wr_en_dm        = 1'b1;
          n_state         = writing_stall;
        end
      end

      writing_stall: begin
        if (done) begin
          stall           = 1'b0;
          wr_en_dm        = 1'b0;
          n_state         = idle;
        end else begin
          stall           = 1'b1;
          wr_en_dm        = 1'b1;
        end
      end

      default: begin
        stall           = 1'b0;
        wr_en_cm        = 1'b0;
        rd_en_cm        = 1'b0;
        mem_to_cache_en = 1'b0;
        wr_en_dm        = 1'b0;
        rd_en_dm        = 1'b0;
        n_state         = idle;
      end
    endcase
  end

endmodule
