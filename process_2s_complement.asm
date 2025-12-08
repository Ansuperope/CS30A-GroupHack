// ==============================================
// ac_process_2s_complement
// flowchart: process_2s_complement
// ----------------------------------------------
// OVERVIEW
//  This function will preform the 2s complement:
//      1. it flips all the bits (done here)
//      2. adds 1 (done in process_add_binary)
// ==============================================
(ac_process_2s_complement)
// ----- INITIALIZATIONS -----
// ac_index = 0
@ac_index
M=0

// ac_last_num = 15
@15
D=A
@ac_last_num
M=D
// ----- END INITIALIZATIONS -----

// ========== FLIP BITS FOR LOOP ==========
(AC_2S_COMPLEMENT_LOOP)

// ---- CHECK IF ac_index < ac_last_num (15) -----
@ac_index
D=M

@ac_last_num
D=M-D

@ac_process_add_binary
D;JLE
// ----- END CHECK IF ac_index < ac_last_num (15) ----- 

// ---- get R[index] -----
@ac_index
D=M
@R0
A=D+A           // R[index]

// ----- check bit value: if R[index] == 0 -----
D=M             // D = R[index]
@AC_BIT_0
D;JEQ

// ----- flip bit: 1 -> 0 -----
@ac_index
D=M
@IR0
A=D+A      // IR[index]
M=0

// --- jump to increment index / next step ---
@AC_2S_COMP_INC_INDEX
0;JMP

// ----- flip bit: 0 -> 1 -----
(AC_BIT_0)
@ac_index
D=M
@IR0
A=D+A      // IR[index]
M=1

// ---- incrememnt ac_index -----
(AC_2S_COMP_INC_INDEX)
@ac_index
M=M+1

// ----- loop again -----
@AC_2S_COMPLEMENT_LOOP
0;JMP
// ========== END FLIP BITS FOR LOOP ==========


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
// ==============================================
(ac_process_add_binary)

// ========== CHECK FOR CARRIES ==========
// ----- INITIALIZATIONS -----
// ac_index = 0
@ac_index
M=0

// ac_last_num = 15
@15
D=A
@ac_last_num
M=D
// ----- END INITIALIZATIONS -----

// ========== ADD 1 TO FIRST DIGIT ==========
@IR0
M=M+1

// ===== CHECK IF CARRY =====
(AC_CHECK_CARRY)

// ----- CHECK IF ac_index < ac_last_num (15) -----
@ac_index
D=M

@ac_last_num
D=M-D

// exit loop
@NEXT
D;JLE
// ----- END CHECK IF ac_index < ac_last_num (15) ----- 

// ----- CHECK IF IR[index] == 2 (CARRY) -----
@ac_index
D=M
@IR0
A=D+A       // IR[index]
D=M         // D = IR[index]

@1
D=D-A
@AC_ADD_BINARY_INC_INDEX
D;JLE
// ----- END CHECK IF IR[index] == 2 (CARRY) -----

// ----- if IR[index] == 2 then IR[index] = 0 -----
@ac_index
D=M
@IR0
A=D+A       // IR[index]
M=0

// ===== IF index = 14 / ON LAST DIGIT / OVERFLOW =====
@ac_index
D=M

@14
D=D-A   // index - 14

// index == 14
@AC_ADD_BINARY_INC_INDEX
D;JEQ
// ===== END IF index = 14 / ON LAST DIGIT / OVERFLOW =====

// ----- add 1 to next binary digit -----
@ac_index
D=M
@1
D=D+A
@IR0
A=D+A       // A = address of IR[index+1]
M=M+1       // IR[index]++

// ----- incrememnt ac_index -----
(AC_ADD_BINARY_INC_INDEX)
@ac_index
M=M+1

// ----- loop again -----
@AC_CHECK_CARRY
0;JMP
// ===== END CHECK IF CARRY =====

// ========== END CHECK FOR CARRIES ==========

// ========== DONE - ac_process_add_binary ==========
(NEXT)

// ----- replace when using -----
@NEXT
0;JMP