module SignExtend (
    input [31:0] instr,       // 32-bit instruction
    input [1:0] imm_src,      // Control signal to select immediate type
    output reg [31:0] imm_ext // Sign-extended immediate value
);

    always @(*) begin
        case(imm_src)
            2'b00: imm_ext = {{20{instr[31]}}, instr[31:20]}; // I-type: 12-bit signed immediate
            2'b01: imm_ext = {{20{instr[31]}}, instr[31:25], instr[11:7]}; // S-type: 12-bit signed immediate
            2'b10: imm_ext = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0}; // B-type: 13-bit signed immediate
            2'b11: imm_ext = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0}; // J-type: 21-bit signed immediate
            default: imm_ext = 32'b0; // Default to 0 for undefined imm_src
        endcase
    end

endmodule
