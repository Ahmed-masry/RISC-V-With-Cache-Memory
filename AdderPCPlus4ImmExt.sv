module AdderPCPlus4ImmExt(
    input wire [31:0] Pc,
    input wire [31:0] imm_ext,
    output wire [31:0] pc_target
);
    assign pc_target = Pc + imm_ext;
endmodule
