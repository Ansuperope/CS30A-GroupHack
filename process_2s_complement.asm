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
//  Output (Send to process_add_binary):
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

(AC_2S_COMPLEMENT_LOOP)

// ---- CHECK IF ac_index < ac_last_num (15) -----
@ac_index
D=M

@ac_last_num
D=M-D

@NEXT
D;JLE
// ----- END CHECK IF ac_index < ac_last_num (15) ----- 

// ---- flip bit - change later -----
@IR         // IR
D=A
@ac_index
A=M
A=D+A       // IR[index]
M=1

// ---- incrememnt ac_index -----
@ac_index
M=M+1

// ----- loop again -----
@AC_2S_COMPLEMENT_LOOP
0;JMP
// ===== END CHECK IF CARRY =====

// ========== NEXT - REPLACE ==========
(NEXT)

// ----- replace when using -----
@NEXT
0;JMP