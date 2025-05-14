`timescale 1ns / 1ps

module tb_Data_memory_system_module;

    // Inputs
    reg clk;
    reg rst;
    reg mem_read;
    reg mem_write;
    reg [9:0] word_address;
    reg [31:0] data_in;

    // Outputs
    wire stall;
    wire [31:0] data_out;

    // Instantiate the Unit Under Test (UUT)
    Data_memory_system_module uut (
        .clk(clk),
        .rst(rst),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .word_address(word_address),
        .data_in(data_in),
        .stall(stall),
        .data_out(data_out)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 0;
        mem_read = 0;
        mem_write = 0;
        word_address = 0;
        data_in = 0;

        // Reset the design
        rst = 1;
       #80;
        rst = 0;
       #80;

        // Write operation
        @(negedge clk);
        mem_write = 1;
        word_address = 10'h004; // Write to address 4
        data_in = 32'hDEADBEEF;
       #80;
        mem_write = 0;

        // Read operation
        @(negedge clk);
        mem_read = 1;
        word_address = 10'h004; // Read from address 4
        #80;
        mem_read = 0;

        // Wait for the read to complete
        #50;

        // Additional write operation
        @(negedge clk);
        mem_write = 1;
        word_address = 10'h008; // Write to address 8
        data_in = 32'hCAFEBABE;
       #80;
        mem_write = 0;

        // Additional read operation
        @(negedge clk);
        mem_read = 1;
        word_address = 10'h008; // Read from address 8
        #80;
        mem_read = 0;

        // Wait for the read to complete
        #50;

        // Check for a cache miss and fetch from data memory
        @(negedge clk);
        mem_read = 1;
        word_address = 10'h100; // Read from address 256, likely a miss and fetch
        #80;
        mem_read = 0;

        // Wait for the read to complete
        #50;

        // Finish simulation
        $finish;
    end

endmodule
