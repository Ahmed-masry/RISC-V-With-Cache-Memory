module RegisterFile (
    input clk,               // Clock signal
    input reset,             // Reset signal
    input [4:0] read_addr1,  // Read address 1
    input [4:0] read_addr2,  // Read address 2
    input [4:0] write_addr,  // Write address
    input [31:0] Result, // Data to write into the register
    input reg_write,         // Register write enable signal

    output reg [31:0] read_data1, // Data read from register 1
    output reg [31:0] read_data2  // Data read from register 2
);

    // Define the register file as an array of 32 registers, each 32 bits wide
    reg [31:0] regfile [31:0];

    // Read data on positive clock edge
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset all registers to 0 on reset
            integer i;
            for (i = 0; i < 32; i = i + 1) begin
                regfile[i] <= 0;
            end
        end else if (reg_write) begin
            // Write data to the register on the positive clock edge
            if (write_addr != 5'b00000) // Register 0 is hard-wired to 0
                regfile[write_addr] <= Result;
        end
    end

    // Read data combinationally
    always @(*) begin
        // Read data from the registers
        read_data1 = (read_addr1 != 5'b00000) ? regfile[read_addr1] : 32'b0;
        read_data2 = (read_addr2 != 5'b00000) ? regfile[read_addr2] : 32'b0;
    end

endmodule
