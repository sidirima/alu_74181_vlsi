`timescale 1ns / 1ps

module tb_CKT74LS181_annotated;

    // Είσοδοι
    reg [3:0] S;
    reg [3:0] A;
    reg [3:0] B;
    reg CNb;
    reg M;

    // Έξοδοι
    wire [3:0] F;
    wire AEB, X, Y, CN4b;

    // Instantiate της ALU (CKT74LS181)
    CKT74LS181 uut (
        .S(S), 
        .A(A), 
        .B(B), 
        .M(M), 
        .CNb(CNb), 
        .F(F), 
        .X(X), 
        .Y(Y), 
        .CN4b(CN4b), 
        .AEB(AEB)
    );

    integer i;

    initial begin
        // Σταθερές τιμές εισόδου για επαλήθευση
        // A = 4'hA (1010_2 = 10), B = 4'h3 (0011_2 = 3)
        A = 4'hA; 
        B = 4'h3; 
        CNb = 1'b1;
        M = 1'b1;
        S = 4'b0000;

        $display("==========================================================================================");
        $display("                   74LS181 ANNOTATED EXHAUSTIVE TESTBENCH (A=10, B=3)                     ");
        $display("==========================================================================================");
        $display("Time     | M | CNb | S (Bin) | A | B | F (Hex) | CN4b | AEB | Expected Description / Operation");
        $display("------------------------------------------------------------------------------------------");

        // -----------------------------------------------------------------
        // 1. ΔΟΚΙΜΗ ΟΛΩΝ ΤΩΝ ΛΟΓΙΚΩΝ ΠΡΑΞΕΩΝ (M = 1)
        // -----------------------------------------------------------------
        $display("\n--- [LOGIC OPERATIONS: M = 1] ---");
        M = 1'b1;
        CNb = 1'b1;
        
        for (i = 0; i < 16; i = i + 1) begin
            S = i[3:0];
            #10;
            $write("%0t ns | %b |  %b  |  %b | %h | %h |    %h    |   %b  |  %b  | ", 
                     $time, M, CNb, S, A, B, F, CN4b, AEB);
            print_expected_logic(S);
        end

        // -----------------------------------------------------------------
        // 2. ΔΟΚΙΜΗ ΟΛΩΝ ΤΩΝ ΑΡΙΘΜΗΤΙΚΩΝ ΠΡΑΞΕΩΝ ΧΩΡΙΣ CARRY IN (M = 0, CNb = 1)
        // -----------------------------------------------------------------
        $display("\n--- [ARITHMETIC OPERATIONS: M = 0, CNb = 1 (No Carry In)] ---");
        M = 1'b0;
        CNb = 1'b1;
        
        for (i = 0; i < 16; i = i + 1) begin
            S = i[3:0];
            #10;
            $write("%0t ns | %b |  %b  |  %b | %h | %h |    %h    |   %b  |  %b  | ", 
                     $time, M, CNb, S, A, B, F, CN4b, AEB);
            print_expected_arithmetic(S, CNb);
        end

        // -----------------------------------------------------------------
        // 3. ΔΟΚΙΜΗ ΟΛΩΝ ΤΩΝ ΑΡΙΘΜΗΤΙΚΩΝ ΠΡΑΞΕΩΝ ΜΕ CARRY IN (M = 0, CNb = 0)
        // -----------------------------------------------------------------
        $display("\n--- [ARITHMETIC OPERATIONS: M = 0, CNb = 0 (With Carry In / +1)] ---");
        M = 1'b0;
        CNb = 1'b0;
        
        for (i = 0; i < 16; i = i + 1) begin
            S = i[3:0];
            #10;
            $write("%0t ns | %b |  %b  |  %b | %h | %h |    %h    |   %b  |  %b  | ", 
                     $time, M, CNb, S, A, B, F, CN4b, AEB);
            print_expected_arithmetic(S, CNb);
        end

        $display("==========================================================================================");
        $display("                                 TESTBENCH COMPLETED                                      ");
        $display("==========================================================================================");
        $finish;
    end

    // Task για εκτύπωση σχολίων στις Λογικές Πράξεις
    task print_expected_logic;
        input [3:0] sel;
        begin
            case (sel)
                4'b0000: $display("F = ~A (Expected: 5)");
                4'b0001: $display("F = ~(A | B) (Expected: 4)");
                4'b0010: $display("F = ~A & B (Expected: 2)");
                4'b0011: $display("F = 0 (Expected: 0)");
                4'b0100: $display("F = ~(A & B) (Expected: C)");
                4'b0101: $display("F = ~B (Expected: C)");
                4'b0110: $display("F = A ^ B [XOR] (Expected: 9)");
                4'b0111: $display("F = A & ~B (Expected: 8)");
                4'b1000: $display("F = ~A | B (Expected: 3)");
                4'b1001: $display("F = ~(A ^ B) [XNOR] (Expected: 6)");
                4'b1010: $display("F = B (Expected: 3)");
                4'b1011: $display("F = A & B [AND] (Expected: 2)");
                4'b1100: $display("F = 1 (Expected: F)");
                4'b1101: $display("F = A | ~B (Expected: B)");
                4'b1110: $display("F = A | B [OR] (Expected: B)");
                4'b1111: $display("F = A (Expected: A)");
            endcase
        end
    endtask

    // Task για εκτύπωση σχολίων στις Αριθμητικές Πράξεις (για A=10, B=3)
    task print_expected_arithmetic;
        input [3:0] sel;
        input cin_b;
        begin
            if (cin_b == 1'b1) begin // Χωρίς Carry-in (Cin = 0)
                case (sel)
                    4'b0000: $display("F = A (Expected: A)");
                    4'b0001: $display("F = A | B (Expected: B)");
                    4'b0010: $display("F = A | ~B (Expected: B)");
                    4'b0011: $display("F = -1 [2's comp of 0] (Expected: F)");
                    4'b0100: $display("F = A + (A & ~B) (Expected: 2)");
                    4'b0101: $display("F = (A | B) + (A & ~B) (Expected: 3)");
                    4'b0110: $display("F = A - B - 1 (Expected: 6)");
                    4'b0111: $display("F = (A & ~B) - 1 (Expected: 7)");
                    4'b1000: $display("F = A + (A & B) (Expected: C)");
                    4'b1001: $display("F = A + B [Addition] (Expected: D)");
                    4'b1010: $display("F = (A | ~B) + (A & B) (Expected: E)");
                    4'b1011: $display("F = (A & B) - 1 (Expected: 1)");
                    4'b1100: $display("F = A + A [Shift Left] (Expected: 4)");
                    4'b1101: $display("F = (A | B) + A (Expected: 5)");
                    4'b1110: $display("F = (A | ~B) + A (Expected: 5)");
                    4'b1111: $display("F = A - 1 [Decrement] (Expected: 9)");
                endcase
            end else begin // Με Carry-in / +1 (Cin = 1)
                case (sel)
                    4'b0000: $display("F = A + 1 [Increment] (Expected: B)");
                    4'b0001: $display("F = (A | B) + 1 (Expected: C)");
                    4'b0010: $display("F = (A | ~B) + 1 (Expected: C)");
                    4'b0011: $display("F = 0 (Expected: 0)");
                    4'b0100: $display("F = A + (A & ~B) + 1 (Expected: 3)");
                    4'b0101: $display("F = (A | B) + (A & ~B) + 1 (Expected: 4)");
                    4'b0110: $display("F = A - B [Subtraction] (Expected: 7)");
                    4'b0111: $display("F = A & ~B (Expected: 8)");
                    4'b1000: $display("F = A + (A & B) + 1 (Expected: D)");
                    4'b1001: $display("F = A + B + 1 (Expected: E)");
                    4'b1010: $display("F = (A | ~B) + (A & B) + 1 (Expected: F)");
                    4'b1011: $display("F = A & B (Expected: 2)");
                    4'b1100: $display("F = A + A + 1 (Expected: 5)");
                    4'b1101: $display("F = (A | B) + A + 1 (Expected: 6)");
                    4'b1110: $display("F = (A | ~B) + A + 1 (Expected: 6)");
                    4'b1111: $display("F = A (Expected: A)");
                endcase
            end
        end
    endtask

endmodule
