module ControlUnit_main_decoder(
    input [6:0] op,               // 7-bit operation code
    output reg RegWrite,          // Register write enable
    output reg [1:0] ImmSrc,      // Immediate source
    output reg ALUSrc,            // ALU source select
    output reg MemWrite,MemRead,          // Memory write enable
    output reg [1:0] ResultSrc,   // Result source select
    output reg Branch,            // Branch control signal
    output reg jumb,              // Jump control signal
    output reg [1:0] ALUOp        // ALU operation select
);

    always @(*) begin
        // Default values
        RegWrite = 0;
        ImmSrc = 2'b00;
        ALUSrc = 0;
        MemWrite = 0;
	MemRead = 0;
        ResultSrc = 2'b00;
        Branch = 0;
        jumb = 0;
        ALUOp = 2'b00;

        case(op)
            7'b0000011: begin // lw
		MemRead = 1;
                RegWrite = 1;
                ImmSrc = 2'b00;
                ALUSrc = 1;
                ResultSrc = 2'b01;
                ALUOp = 2'b00;
            end

            7'b0100011: begin // sw
                MemWrite = 1;
                ALUSrc = 1;
                ALUOp = 2'b00;
                ImmSrc = 2'b01;
            end

            7'b0110011: begin // R-type
                RegWrite = 1;
                ALUOp = 2'b10;
            end

            7'b1100011: begin // beq
                Branch = 1;
                ALUOp = 2'b01;
                 ImmSrc = 2'b10;
            end

            7'b0010011: begin // addi
                RegWrite = 1;
                ALUOp = 2'b10;
                ALUSrc = 1;
            end

            7'b1101111: begin // ori
                RegWrite = 1;
                ImmSrc = 2'b11;
                ResultSrc = 2'b10;
                jumb = 1;
            end
        endcase
    end
endmodule
