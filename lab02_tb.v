//=========================================================================
// Name & Email must be EXACTLY as in Gradescope roster!
// Name: 
// Email: 
// 
// Assignment name: 
// Lab section: 
// TA: 
// 
// I hereby certify that I have not received assistance on this assignment,
// or used code, from ANY outside source other than the instruction team
// (apart from what was provided in the starter file).
//
//=========================================================================

`timescale 1ns / 1ps

module myalu_tb;
    parameter NUMBITS = 32;

    // Inputs
    reg clk;
    reg reset;
    reg [NUMBITS-1:0] A;
    reg [NUMBITS-1:0] B;
    reg [1:0] alu_op;
    reg [5:0] instr_5_0;
    
    
    // Outputs
    wire [NUMBITS-1:0] result;
    reg [NUMBITS-1:0] expected_result;
    wire [3:0] alu_contr;
    wire zero;


    // -------------------------------------------------------
    // Setup output file for possible debugging uses
    // -------------------------------------------------------
    initial
    begin
        $dumpfile("lab02.vcd");
        $dumpvars(0);
    end

    // -------------------------------------------------------
    // Instantiate the Unit Under Test (UUT)
    // -------------------------------------------------------

    alu_control control(
        .alu_op(alu_op),
        .funct(instr_5_0),
        .alu_control(alu_contr)
    );

    alu uut (
        .alu_control(alu_contr),
        .A(A), 
        .B(B), 
        .result(result), 
        .zero(zero)
    );

    initial begin 
    
        clk = 0; reset = 1; #50; 
        clk = 1; reset = 1; #50; 
        clk = 0; reset = 0; #50; 
        clk = 1; reset = 0; #50; 
         
        forever begin 
            clk = ~clk; #50; 
        end 
    end 
    
    integer totalTests = 0;
    integer failedTests = 0;
    
    task test_case(
        input [1:0] alu_op_val, 
        input [5:0] instr_5_0_val,
        input [NUMBITS-1:0] A_val,
        input [NUMBITS-1:0] B_val,
        input expected_zero_val,
        input [NUMBITS-1:0] expected_result_val);
        begin
            totalTests = totalTests + 1;
            alu_op = alu_op_val;
            instr_5_0 = instr_5_0_val;
            A = A_val;
            B = B_val;
            expected_result = expected_result_val;

            #100; // Wait 
            if (expected_result !== result || zero !== expected_zero_val) begin
                $write("failed\n");
                failedTests = failedTests + 1;
            end else begin
                $write("passed\n");
            end
            #10; // Wait 
        end

    endtask

    initial begin // Test suite
        // Reset
        @(negedge reset); // Wait for reset to be released (from another initial block)
        @(posedge clk);   // Wait for first clock out of reset 
        #10; // Wait 10 cycles 

        // Additional test cases
        // ---------------------------------------------
        // Testing unsigned additions 
        // --------------------------------------------- 

        // Code necessary for each test case 
        $write("\tTest Case 1: And ... ");
        test_case(2, 6'h24, 32'h1111, 32'hffff, 1'b0, 32'h1111);

        // Copy the code above and change params to do tests from table        

        // -------------------------------------------------------
        // End testing
        // -------------------------------------------------------
        $write("\n-------------------------------------------------------");
        $write("\nTesting complete\nPassed %0d / %0d tests", totalTests-failedTests,totalTests);
        $write("\n-------------------------------------------------------\n");
        $finish;
    end
endmodule