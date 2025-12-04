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
// ----------------------------------------------
// DATA TABLE
//  Inputs:
//      RAM[15]     - value checking, holds sign of binary word
//
//  Output:
//      FUNC_POS    - where to jump if sign is positive (0)
//      FUNC_NEG    - where to jump if sign is negative (1)
//
//  Variables:
//      NEXT        - jumps to next part (continues program)
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

// ========== NEXT - REPLACE ==========
(NEXT)

// ----- replace when using -----
@NEXT
0;JMP