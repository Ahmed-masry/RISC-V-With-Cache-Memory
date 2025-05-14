module instrMemory (
    input [31:0] Pc,      // Pc input to read instr
    output reg [31:0] instr // Output instr
);

    // Define the instruction memory array
    reg [31:0] memory [0:255];

    // Initialize the instruction memory with example instructions
    initial begin
        memory[0]  = 32'b000000001100_00000_000_00011_0010011; // addi x3, x0, 12  >12
        memory[1]  = 32'b000000011100_00011_000_00111_0010011; // addi x7, x3, 26  >40
        memory[2]  = 32'b1111111_00010_00111_110_00100_0110011; // or x4, x7, x2   >40
        memory[3]  = 32'b0000000_00100_00011_111_00101_0110011; // and x5, x3, x4  >8
        memory[4]  = 32'b0000001_00100_00101_000_00110_0110011; // add x6, x5, x4   >48
        memory[5]  = 32'b0000000_00111_00101_000_01000_1100011; // beq x5, x7, end 0010_1000 = 40 >not taken
        memory[6]  = 32'b0000000_00100_00011_010_00001_0110011; // slt x1, x3(12), x4(28) >1
        memory[7]  = 32'b0000000_00100_00100_000_01000_1100011; // beq x4, x4, around 1000 = 8 >taken
        memory[8]  = 32'b000000000000_00000_000_00101_0010011; // addi x5, x0, 0
        memory[9]  = 32'b0000000_00010_00111_010_00001_0110011; // around: slt x1, x7(40), x2(0) >0
        memory[10] = 32'b0000000_00111_00011_010_01010_0100011; // sw x7, 10(x3) 1010 =84  >40
        memory[11] = 32'b0000000_01010_00011_010_00010_0000011; // lw x2, 10(x3)
        memory[12] = 32'b0_00_0000_0100_0_0000_0000_01000_1101111; // jal x8, end  1000 = 8
        memory[13] = 32'b000000000001_00000_000_00010_0010011; // sub x2, x0, 1
        memory[14] = 32'b0100000_01001_00010_000_01001_0110011; // end: sub x9, x2, x9
        memory[15] = 32'b0000000_00110_00011_010_00101_0100011; // sw x6, 5(x3) 101 = 5>>>>>>>>>>48
       
    end

    // Read the instr on every change of Pc
    always @(*) begin
        instr = memory[Pc[11:2]]; // Memory is word-Pcable, so use Pc[11:2] to make read mem {0,1,2,.....}
    end
endmodule
