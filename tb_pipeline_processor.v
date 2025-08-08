module tb_pipeline_processor;
    reg clk;
    reg reset;

    pipeline_processor uut (
        .clk(clk),
        .reset(reset)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        reset = 1;
        #10;
        reset = 0;

        // Initialize instruction memory
        uut.instruction_memory[0] = 16'b0001_00_01_00000000; // ADD R0, R1
        uut.instruction_memory[1] = 16'b0010_00_01_00000000; // SUB R0, R1
        uut.instruction_memory[2] = 16'b0011_00_00_00001010; // LOAD R0, 10
        uut.instruction_memory[3] = 16'b0011_01_00_00001111; // LOAD R1, 15

        #100;
        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time=%0t | PC=%0d | R0=%0d | R1=%0d | R2=%0d | R3=%0d",
                  $time, uut.PC,
                  uut.register_file[0],
                  uut.register_file[1],
                  uut.register_file[2],
                  uut.register_file[3]);
    end

endmodule
