module ALUDecoder(
    input [1:0] ALUOp,          // ALU operation code
    input [2:0] funct3,         // Function code for R-type instructions
    input  funct7_5,       // Bit 5 of funct7 for R-type instructions
    input  op_5,             // Operation code
    output reg [2:0] ALUControl // Control signal for the ALU (3-bit)
);
    always @(*) begin
        case(ALUOp)
            2'b00: ALUControl = 3'b000; // add (lw, sw)
            2'b01: ALUControl = 3'b001; // subtract (beq)
            2'b10: begin
                case(funct3)
                    3'b000: begin   
                        if ({op_5, funct7_5} == 2'b11)
                            ALUControl = 3'b001; // sub
                        else
                            ALUControl = 3'b000; // add
                    end
                    3'b010: ALUControl = 3'b101; // set less than (slt)
                    3'b110: ALUControl = 3'b011; // or
                    3'b111: ALUControl = 3'b010; // and
                    default: ALUControl = 3'b000; // default
                endcase
            end
            default: ALUControl = 3'b000; // default
        endcase
    end
endmodule
