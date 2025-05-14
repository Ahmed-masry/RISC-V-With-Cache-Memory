module Mux3to1(
    input wire [31:0] ReadData,    
    input wire [31:0] ALU_Result, 
    input wire [31:0] pc_plus4,   
    input wire [1:0]ResultSrc,          
    output reg [31:0] Result 
);

always @(*) begin
    case (ResultSrc)
        2'b00: Result = ALU_Result;
        2'b01: Result = ReadData;
        2'b10: Result = pc_plus4;
        default: Result = ALU_Result;
      
    endcase
end


endmodule
