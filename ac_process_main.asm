// ==============================================
// ac_process_main
// flowchart: process_main
// ----------------------------------------------
// OVERVIEW
//  This function contains all of processing. It
// does the following:
//
//  1. Gets inputs (16 bits) and converts it to a
// binary word.
//
//  2. Checks the sign of the binary word and
// performs 2s complement if its negative.
//
//  3. Converts the binary word to decimal
//
//  It will pass the binary word and the decimal
// value to output to be displayed.
// ----------------------------------------------
// DATA TABLE
//  Inputs (from input):
//      R[0 - 14] - binary word. 0 is first digit
//                14 is last digit
//
//      R[15]     - value checking, holds sign of binary word
//
//  Output (to output):
//      R[0 - 14]   - binary word
//      R[15]       - sign 
//      IR[0 - 14]  - decimal word to output
//
//  Variables:
//      NEXT        - jumps to next part (continues program)
// ==============================================
(AC_PROCESSING_MAIN)

// ==============================================
// ac_process_get_sign
// flowchart: process_get_sign
// ----------------------------------------------
// OVERVIEW
//  This function is a templated function. It will
// be used in multiple locations. It looks at the
// sign of our binary word and will preform
// specific tasks based off of the sign value:
//      0 = positive
//      1 = negative
// ==============================================
(ac_process_get_sign)

// ========== CHECK SIGN VALUE ==========
@R15        // binary sign, value to check
M=1         // R15 = 0 (neg) delete when done for testing only
D=M

@FUNC_POS   // where to jump to
D;JEQ       // if R15 == 0 (positive) jump
// ========== END CHECK SIGN VALUE ==========

// ========== SIGN 1 / NEGATIVE ==========
(FUNC_NEG)

// ----- insert code here -----

// ----- jump to next part -----
@NEXT
0;JMP
// ========== END SIGN 1 / NEGATIVE ==========

// ========== SIGN 0 / POS - JUMP TO ==========
(FUNC_POS)
// ----- insert code here -----
// ========== END SIGN 0 / POS - JUMP TO ==========

// ========== DONE - ac_process_get_sign ==========
(NEXT)

// ----- replace when using -----
@NEXT
0;JMP