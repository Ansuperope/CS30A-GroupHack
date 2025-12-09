// ==============================================
// ac_process_to_decimal
// flowchart: process_to_decimal
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
//  Inputs (get from 2s complement):
//      IR[0 - 14]  - value to convert to decimal
//
//  Output (to output):
//      FUNC_POS    - where to jump if sign is positive (0)
//      FUNC_NEG    - where to jump if sign is negative (1)
//
//  Variables:
//      NEXT        - jumps to next part (continues program)
// ==============================================
(ac_process_to_decimal)

// ========== CONVERT TO DECIMAL ==========
// ----- IR0 - FIRST DIGIT -----
@IR0

// ----- IR1 -----

// ----- IR2 -----



// ----- IR14 - LAST DIGIT -----
// ========== END CONVERT TO DECIMAL ==========


// ========== DONE - ac_process_to_decimal - REPLACE ==========
(NEXT)

// ----- replace when using -----
@NEXT
0;JMP