module Mux2to1_RG_f(
    input wire [31:0]RD2,   
    input wire [31:0] imm_ext,    
    input wire ALUSrc,          
    output wire [31:0] SrcB 
);
    assign SrcB = ALUSrc ? imm_ext : RD2;
endmodule
