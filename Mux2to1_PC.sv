module Mux2to1_PC(
    input wire [31:0] pc_plus4,    // Input 0 (PC + 4)
    input wire [31:0] pc_target,    // Input 1 (PC + 4 + ImmExt)
    input wire Pcsrc,           // Pcsrcector (PCSrc)
    output wire [31:0] Pc_next    // Pc_next (PCNext)
);
    assign Pc_next = Pcsrc ? pc_target : pc_plus4;
endmodule
