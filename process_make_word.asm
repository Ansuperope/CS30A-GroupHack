// ==============================================
// ac_process_make_word
// flowchart: ac_process_make_word
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
//      R[0 - 14]  - value to make binary word
//
//  Output (to output):
//      binary_word - combines all R0 - R14 in one word
//
//  Variables:
//      ac_return   - pointer to return to main function
//      NEXT        - jumps to next part (continues program)
// ==============================================
(ac_process_make_word)

// ========== MAKE WORD ==========
// ----- INITIALIZE -----
// binary_word = 0
@binary_word
M=0

// ===== IR0 - FIRST DIGIT =====
@R0
D=M
// --- if == 0, skip ---
@AC_CHECK_IR1
D; JEQ

// --- if == 1 ---
@1
D=A
@binary_word
M=D+M

// ===== IR1 =====
(AC_CHECK_IR1)
@R1
D=M
// --- if == 0, skip ---
@AC_CHECK_IR2
D; JEQ

// --- if == 1 ---
@10
D=A
@binary_word
M=D+M

// ===== IR2 =====
(AC_CHECK_IR2)
@R2
D=M
// --- if == 0, skip ---
@AC_CHECK_IR3
D; JEQ

// --- if == 1 ---
@100
D=A
@binary_word
M=D+M

// ===== IR3 =====
(AC_CHECK_IR3)
@R3
D=M
// --- if == 0, skip ---
@AC_CHECK_IR4
D; JEQ

// --- if == 1 ---
@1000
D=A
@binary_word
M=D+M

// ===== IR4 =====
(AC_CHECK_IR4)
@R4
D=M
// --- if == 0, skip ---
@AC_CHECK_IR5
D; JEQ

// --- if == 1 ---
@10000
D=A
@binary_word
M=D+M

// ===== IR5 =====
(AC_CHECK_IR5)
@R5
D=M
// --- if == 0, skip ---
@AC_CHECK_IR6
D; JEQ

// --- if == 1 ---
@100000
D=A
@binary_word
M=D+M

// ===== IR7 =====
(AC_CHECK_IR7)
@R7
D=M
// --- if == 0, skip ---
@AC_CHECK_IR8
D; JEQ

// --- if == 1 ---
@10000000
D=A
@binary_word
M=D+M

// ===== IR8 =====
(AC_CHECK_IR8)
@R8
D=M
// --- if == 0, skip ---
@AC_CHECK_IR9
D; JEQ

// --- if == 1 ---
@100000000
D=A
@binary_word
M=D+M

// ===== IR9 =====
(AC_CHECK_IR9)
@R9
D=M
// --- if == 0, skip ---
@AC_CHECK_IR10
D; JEQ

// --- if == 1 ---
@1000000000
D=A
@binary_word
M=D+M

// ===== IR10 =====
(AC_CHECK_IR10)
@R10
D=M
// --- if == 0, skip ---
@AC_CHECK_IR11
D; JEQ

// --- if == 1 ---
@10000000000
D=A
@binary_word
M=D+M

// ===== IR11 =====
(AC_CHECK_IR11)
@R11
D=M
// --- if == 0, skip ---
@AC_CHECK_IR12
D; JEQ

// --- if == 1 ---
@100000000000
D=A
@binary_word
M=D+M

// ===== IR12 =====
(AC_CHECK_IR12)
@R12
D=M
// --- if == 0, skip ---
@AC_CHECK_IR13
D; JEQ

// --- if == 1 ---
@1000000000000
D=A
@binary_word
M=D+M

// ===== IR13 =====
(AC_CHECK_IR13)
@R13
D=M
// --- if == 0, skip ---
@AC_CHECK_IR14
D; JEQ

// --- if == 1 ---
@10000000000000
D=A
@binary_word
M=D+M

// ===== IR14 - LAST DIGIT =====
(AC_CHECK_IR14)
@R14
D=M
// --- if == 0, skip ---
@NEXT
D; JEQ

// --- if == 1 ---
@100000000000000
D=A
@binary_word
M=D+M
// ========== END MAKE WORD ==========


// ========== DONE - ac_process_to_decimal - REPLACE ==========
(NEXT)

// ----- replace when using -----
@NEXT
0;JMP