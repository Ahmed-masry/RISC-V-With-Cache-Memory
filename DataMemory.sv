module DataMemory (
    input wire clk,                // Clock signal
    input wire reset,              // Reset signal
    input wire [31:0] ALUresult,     // ALUresult for memory access
    input wire [31:0] write_data,  // Data to write into memory
    input wire mem_write,          // Memory write enable
    output reg [31:0] ReadData    // Data read from memory
);
    reg [31:0] memory [0:31]; 


    // Synchronous write
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            integer i;
            for (i = 0; i < 32; i = i + 1) begin
                memory[i] <= 32'b0;
            end
        end else if (mem_write) begin
            memory[ALUresult] <= write_data; // store
        end
    end

    // Asynchronous read
    always @(*) begin
            ReadData = memory[ALUresult]; // Memory is byte-ALUresultable read
    end
endmodule
