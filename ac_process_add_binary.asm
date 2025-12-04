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
//      ac_index       - access digits in binary word
//      ac_last_num    - length of binary word. Used
//                  check if we are at the last digit
//      NEXT        - jumps to next part (continues program)
// ==============================================
(ac_process_add_binary)
// ========== DELETE - TESTING INPUTS ==========
// first digit
@IR0
M=0

@IR1
M=0

// last digit

// ========== END DELETE - TESTING INPUTS ==========

// ========== ADD 1 TO LAST DIGIT ==========
@IR0
M=M+1

// ========== CHECK FOR CARRIES ==========
// ----- INITIALIZATIONS -----
// pointer to function

// ac_index = 0
@ac_index
M=0

// ac_last_num = 15
@15
D=A
@ac_last_num
M=D
// ----- END INITIALIZATIONS -----

// ===== CHECK IF CARRY =====
(AC_CHECK_CARRY)

// ---- CHECK IF ac_index < ac_last_num (15) -----
@ac_index
D=M

@ac_last_num
D=M-D

@NEXT
D;JLE
// ----- END CHECK IF ac_index < ac_last_num (15) ----- 

@IR0
M=M+1

@IR1
M=M+1

// ---- incrememnt ac_index -----
@ac_index
M=M+1

// ----- loop again -----
@AC_CHECK_CARRY
0;JMP
// ===== END CHECK IF CARRY =====

// ===== CHECK IF OVERFLOW (at last number / IR14) =====

// ===== END CHECK IF OVERFLOW (at last number / IR14) =====

// ========== END CHECK FOR CARRIES ==========

// ========== NEXT - REPLACE ==========
(NEXT)

// ----- replace when using -----
@NEXT
0;JMP