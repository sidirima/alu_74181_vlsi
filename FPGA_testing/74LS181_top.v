`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
//
// Module Name: TopLevel_ActiveLow_Wrapper
// Description: Wrapper module for 74LS181 ALU to support Active Low 
//              DIP switches (inputs) and Active Low LEDs (outputs).
////////////////////////////////////////////////////////////////////////////////

module TopLevel_ActiveLow_Wrapper (
    input [3:0] A_ext,
    input [3:0] B_ext,
    input [3:0] S_ext,
    input CNb_ext,
    input M_ext,
    output [3:0] F_ext,
    output AEB_ext,
    output X_ext,
    output Y_ext,
    output CN4b_ext
);

    // Εσωτερικά σήματα Active High για την ALU σου
    wire [3:0] A_int;
    wire [3:0] B_int;
    wire [3:0] S_int;
    wire CNb_int;
    wire M_int;
    
    wire [3:0] F_int;
    wire AEB_int;
    wire X_int;
    wire Y_int;
    wire CN4b_int;

    // 1. Αντιστροφή Εισόδων: 
    // Τα Active Low switches (0 όταν πατηθούν/on) γίνονται Active High (1) για το κύκλωμα.
    assign A_int   = ~A_ext;
    assign B_int   = ~B_ext;
    assign S_int   = ~S_ext;
    assign CNb_int = ~CNb_ext;
    assign M_int   = ~M_ext;

    // 2. Αντιστροφή Εξόδων:
    // Τα Active High αποτελέσματα του κυκλώματος αντιστρέφονται ώστε να οδηγούν σωστά τα Active Low LEDs (0 για να ανάψουν).
    assign F_ext     = ~F_int;
    assign AEB_ext   = ~AEB_int;
    assign X_ext     = ~X_int;
    assign Y_ext     = ~Y_int;
    assign CN4b_ext  = ~CN4b_int;

    // 3. Instantiation του βασικού σου κυκλώματος (CKT74LS181)
    CKT74LS181 alu_instance (
        .S(S_int),
        .A(A_int),
        .B(B_int),
        .M(M_int),
        .CNb(CNb_int),
        .F(F_int),
        .X(X_int),
        .Y(Y_int),
        .CN4b(CN4b_int),
        .AEB(AEB_int)
    );

endmodule
