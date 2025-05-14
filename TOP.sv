module TOP(
    input wire clk,
    input wire reset,
    output wire [31:0] result
);

    // PC
    wire [31:0] pc, pc_next, pc_plus4, pc_target;
    
    // Instruction Memory
    wire [31:0] instruction;
    
    // Control Signals
    wire [1:0] result_src, imm_src;
    wire [2:0] alu_control;
    wire pc_src, mem_write,mem_read, alu_src, reg_write;
    
    // Register File
    wire [4:0] rs1, rs2, rd;
    wire [31:0] read_data1, read_data2, write_data;
    
    // Immediate Generation
    wire [31:0] imm_ext;
    
    // ALU
    wire [31:0] alu_result,src_b;
    wire zero;
    
    // Data Memory
    wire [31:0] read_data;
    wire  stall;
    // Assignments
    assign rs1 = instruction[19:15];
    assign rs2 = instruction[24:20];
    assign rd = instruction[11:7];

 // Instantiate modules
    AdderPCPlus4 adder_pc_plus4 (
        .pc(pc),
        .pc_plus4(pc_plus4)
    );

AdderPCPlus4ImmExt adder_pc_plus4_immext (
        .Pc(pc),
        .imm_ext(imm_ext),
        .pc_target(pc_target)
    );

// PC Logic
Mux2to1_PC mux_pc (
        .pc_plus4(pc_plus4),
        .pc_target(pc_target),
        .Pcsrc(pc_src),
        .Pc_next(pc_next)
    );

PC pc_reg (
        .clk(clk),
        .reset(reset),
        .Pc_next(pc_next),
	.en(!stall),
        .PC(pc)
    );
    /* -------------------------------------------------------------------------- */
    /*                               End oF Part PC                               */
    /* -------------------------------------------------------------------------- */


// Instantiate Instruction Memory
    instrMemory instr_mem(
        .Pc(pc),
        .instr(instruction)
    );

    /* -------------------------------------------------------------------------- */
    /*                               End oF Part Instruction                              
    /* -------------------------------------------------------------------------- */

 // Instantiate Control Unit
    ControlUnit control_unit(
        .op(instruction[6:0]),
        .funct3(instruction[14:12]),
        .funct7(instruction[31:25]),
        .Zero(zero),
        .PCSrc(pc_src),
        .ResultSrc(result_src),
        .MemWrite(mem_write),
	.mem_read(mem_read),
        .ALUControl(alu_control),
        .ALUSrc(alu_src),
        .ImmSrc(imm_src),
        .RegWrite(reg_write)
    );

    /* -------------------------------------------------------------------------- */
    /*                               End oF Part Control Unit                               */
    /* -------------------------------------------------------------------------- */
     // Instantiate Register File
    RegisterFile reg_file(
        .clk(clk),
        .reg_write(reg_write),
        .read_addr1(rs1),
        .read_addr2(rs2),
        .write_addr(rd),
        .Result(write_data),
        .read_data1(read_data1),
        .read_data2(read_data2),
         .reset(reset)
    );

    /* -------------------------------------------------------------------------- */
    /*                               End oF Part Register File                               */
    /* -------------------------------------------------------------------------- */


    // Instantiate Immediate Extension Unit
    SignExtend imm_gen(
        .instr(instruction),
        .imm_src(imm_src),
        .imm_ext(imm_ext)
    );
    /* -------------------------------------------------------------------------- */
    /*                               End oF Part Immediate Extension Unit                               *
    /* -------------------------------------------------------------------------- */

      // ALU Source Mux
    Mux2to1_RG_f ALU_ource (
        .ALUSrc(alu_src),
        .RD2(read_data2),
        .imm_ext(imm_ext),
        .SrcB(src_b)
    );
    /* -------------------------------------------------------------------------- */
    /*                               End oF Part ALU Source Mux                               */
    /* -------------------------------------------------------------------------- */

  // Instantiate ALU
    ALU alu(
        .secA(read_data1),
        .secB(src_b),
        .ALUControl(alu_control),
        .ALUResult(alu_result),
        .zero(zero)
    );
    /* -------------------------------------------------------------------------- */
    /*                               End oF Part ALU                               */
    /* ------------------
        -------------------------------------------------------- */
    // Data Memory
   /* DataMemory data_mem(
        .clk(clk),
        .mem_write(mem_write),
        .ALUresult(alu_result),
        .write_data(read_data2),
        .ReadData(read_data),
        .reset(reset)
    );


*/
Data_memory_system_module data_mem(
        .clk(clk),
        .mem_write(mem_write),
	.mem_read(mem_read),
        .word_address(alu_result[9:0]),
        .data_in(read_data2),
        .data_out(read_data),
        .rst(reset),
        .stall(stall)
    );

    /* -------------------------------------------------------------------------- */
    /*                               End oF Part Data Memory                               */
    /* -------------------------------------------------------------------------- */
// Result Mux
    Mux3to1 result_mux(
        .ResultSrc(result_src),
        .ALU_Result(alu_result),
        .ReadData(read_data),
        .pc_plus4(pc_plus4),
        .Result(write_data)
    );
    /* -------------------------------------------------------------------------- */
    /*                               End oF Part Result Mux                               */
    /* -------------------------------------------------------------------------- */
  assign result = write_data;
    
endmodule