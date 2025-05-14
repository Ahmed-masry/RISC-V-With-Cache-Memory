module ALU (
    input wire [31:0] secA,       // Source register 1
    input wire [31:0] secB,       // Source register 2
    input wire [2:0] ALUControl,  // ALU control signal (3-bit)
    output reg [31:0] ALUResult,  // ALU result
    output reg zero               // Zero flag
);

    always @(*) begin
        case (ALUControl)
            3'b000: ALUResult = secA + secB;            // ADD (Addition)
            3'b001: ALUResult = secA - secB;            // SUB (Subtraction)
            3'b101: ALUResult = (secA < secB) ? 32'b1 : 32'b0;  // SLT (Set Less Than)
            3'b011: ALUResult = secA | secB;            // OR  (Bitwise OR)
            3'b010: ALUResult = secA & secB;            // AND (Bitwise AND)
            default: ALUResult = 32'b0;                 // Default to 0
        endcase

        // Set zero flag
        zero = (ALUResult == 32'b0);
    end

endmodule
