module pipeline_processor (
    input clk,
    input reset
);

    // Define registers
    reg [15:0] instruction_memory [0:15];  // Simple instruction memory
    reg [7:0] register_file [0:3];          // 4 general-purpose registers

    reg [15:0] IF_ID;   // Pipeline register between IF and ID
    reg [15:0] ID_EX;   // Between ID and EX
    reg [15:0] EX_WB;   // Between EX and WB

    // Program Counter
    reg [3:0] PC;

    // Instruction Fields
    wire [3:0] opcode;
    wire [1:0] rd, rs;
    wire [7:0] immediate;

    assign opcode   = ID_EX[15:12];
    assign rd       = ID_EX[11:10];
    assign rs       = ID_EX[9:8];
    assign immediate= ID_EX[7:0];

    // ALU output
    reg [7:0] alu_result;

    // Write Back
    always @(posedge clk) begin
        if (reset) begin
            register_file[EX_WB[11:10]] <= 0;
        end else begin
            if (EX_WB[15:12] == 4'b0001 || EX_WB[15:12] == 4'b0010 || EX_WB[15:12] == 4'b0011)
                register_file[EX_WB[11:10]] <= alu_result;
        end
    end

    // Pipeline Stages
    always @(posedge clk) begin
        if (reset) begin
            PC <= 0;
            IF_ID <= 0;
            ID_EX <= 0;
            EX_WB <= 0;
        end else begin
            // Instruction Fetch
            IF_ID <= instruction_memory[PC];
            PC <= PC + 1;

            // Instruction Decode
            ID_EX <= IF_ID;

            // Execute
            case (opcode)
                4'b0001: alu_result <= register_file[rd] + register_file[rs]; // ADD
                4'b0010: alu_result <= register_file[rd] - register_file[rs]; // SUB
                4'b0011: alu_result <= immediate;                             // LOAD immediate
                default: alu_result <= 0;
            endcase

            // Write Back (pipeline reg)
            EX_WB <= ID_EX;
        end
    end

endmodule
