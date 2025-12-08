/*
  This function handles 'c' and 'q'.
  If lw_key == 'c', I clear all input registers and reset my state.
  Otherwise I treat it as 'q' and clear everything and park in an infinite loop.
*/

// I handle c (clear) and q (quit) here.
// lw_key already holds the character.
(lw_handleClearOrQuit)
    // check if it was 'c' (ASCII 99)
    @lw_key
    D=M
    @99
    D=D-A
    @DO_CLEAR
    D;JEQ

    // if not 'c', I treat it as 'q'
    @DO_QUIT
    0;JMP

// c, clear registers and reset state
(DO_CLEAR)
    @R0
    M=0
    @R1
    M=0
    @R2
    M=0
    @R3
    M=0
    @R4
    M=0
    @R5
    M=0
    @R6
    M=0
    @R7
    M=0
    @R8
    M=0
    @R9
    M=0
    @R10
    M=0
    @R11
    M=0
    @R12
    M=0
    @R13
    M=0
    @R14
    M=0
    @R15
    M=0

    @0
    D=A
    @lw_cursor
    M=D
    @lw_bitIndex
    M=D
    @lw_doneInput
    M=0

    // back to input loop
    @lw_getBinaryInput
    0;JMP

// q, clear and then park in an infinite loop
(DO_QUIT)
    @R0
    M=0
    @R1
    M=0
    @R2
    M=0
    @R3
    M=0
    @R4
    M=0
    @R5
    M=0
    @R6
    M=0
    @R7
    M=0
    @R8
    M=0
    @R9
    M=0
    @R10
    M=0
    @R11
    M=0
    @R12
    M=0
    @R13
    M=0
    @R14
    M=0
    @R15
    M=0

(QUIT_LOOP)
    @QUIT_LOOP
    0;JMP