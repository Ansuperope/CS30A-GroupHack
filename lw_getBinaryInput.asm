/*
  This is my main input loop.
  I read keys from KBD, only accept: 0, 1, Enter(128), Backspace(129), c, q.
  I store bits into R0..R15 and track lw_cursor and lw_bitIndex.
  When I’m done, I set lw_doneInput and jump to Aspen’s code.
*/

// VARIABLES I USE:
//
// lw_cursor    – current column position for input
// lw_bitIndex  – which bit (0–15) I’m on
// lw_key       – last key I read from KBD
// lw_doneInput – flag: 0 = still inputting, 1 = ready to process
// lw_bitVal    – temp for current bit (0 or 1)

(lw_getBinaryInput)
lw_inputLoop
    // if I’m done with input, hand control to Aspen
    @lw_doneInput
    D=M
    @lw_inputContinue
    D;JEQ          
    // if 0, keep inputting

    // doneInput != 0, so jump to convert phase
    @ac_buildWordFromBits
    0;JMP

lw_inputContinue
    // wait for a key press
lw_waitPress
    @KBD
    D=M
    @lw_waitPress
    D;JEQ          
    // stay here while no key is pressed

    // store the key
    @lw_key
    M=D

    // wait for key release (so I don’t repeat while held)
lw_waitRelease
    @KBD
    D=M
    @lw_waitRelease
    D;JNE

    // now I decide what key it was

    // check '0' (ASCII 48)
    @lw_key
    D=M
    @48
    D=D-A
    @HANDLE_ZERO
    D;JEQ

    // check '1' (ASCII 49)
    @lw_key
    D=M
    @49
    D=D-A
    @HANDLE_ONE
    D;JEQ

    // check Enter (ASCII 128)
    @lw_key
    D=M
    @128
    D=D-A
    @HANDLE_ENTER
    D;JEQ

    // check Backspace (ASCII 129)
    @lw_key
    D=M
    @129
    D=D-A
    @HANDLE_BS
    D;JEQ

    // check 'c' (ASCII 99)
    @lw_key
    D=M
    @99
    D=D-A
    @HANDLE_C
    D;JEQ

    // check 'q' (ASCII 113)
    @lw_key
    D=M
    @113
    D=D-A
    @HANDLE_Q
    D;JEQ

    // anything else, ignore and go back
    @lw_getBinaryInput
    0;JMP


// digit 0
(HANDLE_ZERO)
    @lw_bitVal
    M=0
    @lw_handleDigit
    0;JMP

// digit 1
(HANDLE_ONE)
    @lw_bitVal
    M=1
    @lw_handleDigit
    0;JMP

// Enter, I just mark done and loop, the top will jump to Aspen
(HANDLE_ENTER)
    @lw_doneInput
    M=1
    @lw_getBinaryInput
    0;JMP

// Backspace, I call my backspace function
(HANDLE_BS)
    @lw_handleBackspace
    0;JMP

// c or q, I let lw_handleClearOrQuit decide
(HANDLE_C)
    // lw_key already has 'c'
    @lw_handleClearOrQuit
    0;JMP

(HANDLE_Q)
    // lw_key already has 'q'
    @lw_handleClearOrQuit
    0;JMP


// I handle a digit (0 or 1) here.
// I only allow up to 16 bits (0..15).
(lw_handleDigit)
    // if bitIndex >= 16, ignore extra digits
    @lw_bitIndex
    D=M
    @16
    D=D-A
    @lw_getBinaryInput
    D;JGE

    // decide which R register to write based on bitIndex

    @lw_bitIndex
    D=M
    @BIT0
    D;JEQ

    @lw_bitIndex
    D=M
    @1
    D=D-A
    @BIT1
    D;JEQ

    @lw_bitIndex
    D=M
    @2
    D=D-A
    @BIT2
    D;JEQ

    @lw_bitIndex
    D=M
    @3
    D=D-A
    @BIT3
    D;JEQ

    @lw_bitIndex
    D=M
    @4
    D=D-A
    @BIT4
    D;JEQ

    @lw_bitIndex
    D=M
    @5
    D=D-A
    @BIT5
    D;JEQ

    @lw_bitIndex
    D=M
    @6
    D=D-A
    @BIT6
    D;JEQ

    @lw_bitIndex
    D=M
    @7
    D=D-A
    @BIT7
    D;JEQ

    @lw_bitIndex
    D=M
    @8
    D=D-A
    @BIT8
    D;JEQ

    @lw_bitIndex
    D=M
    @9
    D=D-A
    @BIT9
    D;JEQ

    @lw_bitIndex
    D=M
    @10
    D=D-A
    @BIT10
    D;JEQ

    @lw_bitIndex
    D=M
    @11
    D=D-A
    @BIT11
    D;JEQ

    @lw_bitIndex
    D=M
    @12
    D=D-A
    @BIT12
    D;JEQ

    @lw_bitIndex
    D=M
    @13
    D=D-A
    @BIT13
    D;JEQ

    @lw_bitIndex
    D=M
    @14
    D=D-A
    @BIT14
    D;JEQ

    @lw_bitIndex
    D=M
    @15
    D=D-A
    @BIT15
    D;JEQ

    // safety, should not get here
    @lw_getBinaryInput
    0;JMP



// For each bit index, I write lw_bitVal into R0..R15,
// then bump cursor and bitIndex, then go back to input loop.

(BIT0)
    @lw_bitVal
    D=M
    @R0
    M=D
    @lw_cursor
    M=M+1
    @lw_bitIndex
    M=M+1
    @lw_getBinaryInput
    0;JMP

(BIT1)
    @lw_bitVal
    D=M
    @R1
    M=D
    @lw_cursor
    M=M+1
    @lw_bitIndex
    M=M+1
    @lw_getBinaryInput
    0;JMP

(BIT2)
    @lw_bitVal
    D=M
    @R2
    M=D
    @lw_cursor
    M=M+1
    @lw_bitIndex
    M=M+1
    @lw_getBinaryInput
    0;JMP

(BIT3)
    @lw_bitVal
    D=M
    @R3
    M=D
    @lw_cursor
    M=M+1
    @lw_bitIndex
    M=M+1
    @lw_getBinaryInput
    0;JMP

(BIT4)
    @lw_bitVal
    D=M
    @R4
    M=D
    @lw_cursor
    M=M+1
    @lw_bitIndex
    M=M+1
    @lw_getBinaryInput
    0;JMP

(BIT5)
    @lw_bitVal
    D=M
    @R5
    M=D
    @lw_cursor
    M=M+1
    @lw_bitIndex
    M=M+1
    @lw_getBinaryInput
    0;JMP

(BIT6)
    @lw_bitVal
    D=M
    @R6
    M=D
    @lw_cursor
    M=M+1
    @lw_bitIndex
    M=M+1
    @lw_getBinaryInput
    0;JMP

(BIT7)
    @lw_bitVal
    D=M
    @R7
    M=D
    @lw_cursor
    M=M+1
    @lw_bitIndex
    M=M+1
    @lw_getBinaryInput
    0;JMP

(BIT8)
    @lw_bitVal
    D=M
    @R8
    M=D
    @lw_cursor
    M=M+1
    @lw_bitIndex
    M=M+1
    @lw_getBinaryInput
    0;JMP

(BIT9)
    @lw_bitVal
    D=M
    @R9
    M=D
    @lw_cursor
    M=M+1
    @lw_bitIndex
    M=M+1
    @lw_getBinaryInput
    0;JMP

(BIT10)
    @lw_bitVal
    D=M
    @R10
    M=D
    @lw_cursor
    M=M+1
    @lw_bitIndex
    M=M+1
    @lw_getBinaryInput
    0;JMP

(BIT11)
    @lw_bitVal
    D=M
    @R11
    M=D
    @lw_cursor
    M=M+1
    @lw_bitIndex
    M=M+1
    @lw_getBinaryInput
    0;JMP

(BIT12)
    @lw_bitVal
    D=M
    @R12
    M=D
    @lw_cursor
    M=M+1
    @lw_bitIndex
    M=M+1
    @lw_getBinaryInput
    0;JMP

(BIT13)
    @lw_bitVal
    D=M
    @R13
    M=D
    @lw_cursor
    M=M+1
    @lw_bitIndex
    M=M+1
    @lw_getBinaryInput
    0;JMP

(BIT14)
    @lw_bitVal
    D=M
    @R14
    M=D
    @lw_cursor
    M=M+1
    @lw_bitIndex
    M=M+1
    @lw_getBinaryInput
    0;JMP

(BIT15)
    @lw_bitVal
    D=M
    @R15
    M=D
    @lw_cursor
    M=M+1
    @lw_bitIndex
    M=M+1
    @lw_getBinaryInput
    0;JMP
