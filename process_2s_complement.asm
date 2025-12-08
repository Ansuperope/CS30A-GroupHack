// ==============================================
// ac_process_2s_complement
// flowchart: process_2s_complement
// ----------------------------------------------
// OVERVIEW
//  This function will preform the 2s complement:
//      1. it flips all the bits (done here)
//      2. adds 1 (done in process_add_binary)
// ----------------------------------------------
// DATA TABLE
//  Inputs (Receieve from input):
//      R[0 - 14]   - binary values from input
//                  0 is the first number
//                  14 is the last number
//
//  Output (Send to next step):
//      IR[0 - 14]  - opposite binary values from input
//                  0 is the first number
//                  14 is the last number
//
//  Variables:
//      ac_index    - counter of how many times we
//                  looped / index of array
//
//      ac_last_num - lenght of array / how many 
//                  times to loop
//
//      NEXT        - next step of program, replace
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

@NEXT
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

// ========== NEXT - REPLACE ==========
(NEXT)

// ----- replace when using -----
@NEXT
0;JMP