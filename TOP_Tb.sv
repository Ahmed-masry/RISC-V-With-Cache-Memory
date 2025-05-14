module TOP_Tb;

    reg clk;
    reg reset;
    wire [31:0] result;

    // Instantiate the DUT (Device Under Test)
    TOP dut (
        .clk(clk),
        .reset(reset),
        .result(result)
    );

    // Clock generation
    always begin
        #1 clk = ~clk; // 100MHz clock
    end
integer k=0;
    // Task to display register file contents
    task display_registers;
        integer i;
        begin
            $display("Register file contents :");
            for (i = 0; i < 32; i = i + 1) begin
                $display("R%d = %d", i, dut.reg_file.regfile[i]);
            end
        end
    endtask

    // Initial setup
    initial begin
    
        // Initialize signals
        clk = 0;
        reset = 1;

        // Release reset after some time
        #2 reset = 0;

        repeat(20)begin
        #2;
        
        // Display register file contents
        display_registers();
        end
        // End simulation
        $stop;
    end

endmodule
