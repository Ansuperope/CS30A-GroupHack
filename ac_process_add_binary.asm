// ==============================================
// ac_process_add_binary
// flowchart: process_add_binary
// ----------------------------------------------
// OVERVIEW
//  This function is a part of the process to preform
// 2s complement on a number. It adds 1 to a binary
// number. After it adds it will check:
//      1. if if the word overflows
//      2. if there's any carries
// ----------------------------------------------
// DATA TABLE
//  Inputs (from process_2s_complement):
//      IR0, ... IR14   - inverse of user input
//                      binary number
//
//  Output (to next step):
//      IR0, ... IR14   - inverse of user input
//                      binary number BUT with 1 added
//
//  Variables:
//      index       - access digits in binary word
//      last_num    - length of binary word. Used
//                  check if we are at the last digit
//      NEXT        - jumps to next part (continues program)
// ==============================================
(ac_process_add_binary)
// ========== DELETE - TESTING INPUTS ==========
// first digit
@IR0
M=0

// last digit

// ========== END DELETE - TESTING INPUTS ==========

// ========== ADD 1 TO LAST DIGIT ==========
@IR0
M=M+1

// ========== CHECK FOR CARRIES ==========
// ----- INITIALIZATIONS -----
// index = 0
@index
M=0

// last_num = 14
@14
D=A
@last_num
M=D
// ----- END INITIALIZATIONS -----

// ===== CHECK IF CARRY =====
(AC_CHECK_CARRY)

// ---- LOOP IF index < 14 -----
@AC_CHECK_CARRY
// D;JGE
// ===== END CHECK IF CARRY =====

// ===== CHECK IF OVERFLOW (at last number / IR14) =====

// ===== END CHECK IF OVERFLOW (at last number / IR14) =====

// ========== END CHECK FOR CARRIES ==========

// ========== NEXT - REPLACE ==========
(NEXT)

// ----- replace when using -----
@NEXT
0;JMP