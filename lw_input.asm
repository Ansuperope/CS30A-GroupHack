/*
  lw_input.asm
  These are the input functions I am writing for our group project.
  I'm keeping the comments simple so I can understand everything later.
  My job is the whole input part: reading keys, storing bits, handling backspace,
  and clearing or quitting.
*/

// VARIABLES I USE:
//
// lw_cursor    – current column position for input
// lw_bitIndex  – which bit (0–15) I’m on
// lw_key       – last key I read from KBD
// lw_doneInput – flag: 0 = still inputting, 1 = ready to process
// lw_bitVal    – temp for current bit (0 or 1)

(MAIN)
    @0
    D=A
    @lw_cursor
    M=D
    @lw_bitIndex
    M=D
    @lw_doneInput
    M=0

    @lw_getBinaryInput
    0;JMP



// LOGAN – my input part

// I sit here and read keys.
// I only care about: 0, 1, Enter(128), Backspace(129), c, q.
// I store bits into R0..R15 and track cursor and bitIndex.
(lw_getBinaryInput)
lw_inputLoop
    // if I’m done with input, hand control to Aspen
    @lw_doneInput
    D=M
    @lw_inputContinue
    D;JEQ

    // doneInput != 0, so jump to convert phase
    @ac_buildWordFromBits
    0;JMP

lw_inputContinue
    // wait for a key press
lw_waitPress
    @KBD
    D=M
    @lw_waitPress
    D;JEQ     // stay here while no key is pressed

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

    // anything else: ignore and go back
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

// Enter: I just mark done and loop, the top will jump to Aspen
(HANDLE_ENTER)
    @lw_doneInput
    M=1
    @lw_getBinaryInput
    0;JMP

// Backspace
(HANDLE_BS)
    @lw_handleBackspace
    0;JMP

// c or q: I let lw_handleClearOrQuit decide
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



// I handle backspace here.
// If bitIndex is 0, I do nothing.
// Otherwise I move cursor left and clear the last R register.
(lw_handleBackspace)
    @lw_bitIndex
    D=M
    @BACK_DONE
    D;JEQ      // nothing to delete

    // bitIndex-- (now points to last filled bit)
    @lw_bitIndex
    M=M-1

    // move cursor left too
    @lw_cursor
    M=M-1

    // clear the right R register based on new bitIndex

    @lw_bitIndex
    D=M
    @BACK0
    D;JEQ

    @lw_bitIndex
    D=M
    @1
    D=D-A
    @BACK1
    D;JEQ

    @lw_bitIndex
    D=M
    @2
    D=D-A
    @BACK2
    D;JEQ

    @lw_bitIndex
    D=M
    @3
    D=D-A
    @BACK3
    D;JEQ

    @lw_bitIndex
    D=M
    @4
    D=D-A
    @BACK4
    D;JEQ

    @lw_bitIndex
    D=M
    @5
    D=D-A
    @BACK5
    D;JEQ

    @lw_bitIndex
    D=M
    @6
    D=D-A
    @BACK6
    D;JEQ

    @lw_bitIndex
    D=M
    @7
    D=D-A
    @BACK7
    D;JEQ

    @lw_bitIndex
    D=M
    @8
    D=D-A
    @BACK8
    D;JEQ

    @lw_bitIndex
    D=M
    @9
    D=D-A
    @BACK9
    D;JEQ

    @lw_bitIndex
    D=M
    @10
    D=D-A
    @BACK10
    D;JEQ

    @lw_bitIndex
    D=M
    @11
    D=D-A
    @BACK11
    D;JEQ

    @lw_bitIndex
    D=M
    @12
    D=D-A
    @BACK12
    D;JEQ

    @lw_bitIndex
    D=M
    @13
    D=D-A
    @BACK13
    D;JEQ

    @lw_bitIndex
    D=M
    @14
    D=D-A
    @BACK14
    D;JEQ

    @lw_bitIndex
    D=M
    @15
    D=D-A
    @BACK15
    D;JEQ

    @BACK_DONE
    0;JMP

(BACK0)
    @R0
    M=0
    @BACK_DONE
    0;JMP

(BACK1)
    @R1
    M=0
    @BACK_DONE
    0;JMP

(BACK2)
    @R2
    M=0
    @BACK_DONE
    0;JMP

(BACK3)
    @R3
    M=0
    @BACK_DONE
    0;JMP

(BACK4)
    @R4
    M=0
    @BACK_DONE
    0;JMP

(BACK5)
    @R5
    M=0
    @BACK_DONE
    0;JMP

(BACK6)
    @R6
    M=0
    @BACK_DONE
    0;JMP

(BACK7)
    @R7
    M=0
    @BACK_DONE
    0;JMP

(BACK8)
    @R8
    M=0
    @BACK_DONE
    0;JMP

(BACK9)
    @R9
    M=0
    @BACK_DONE
    0;JMP

(BACK10)
    @R10
    M=0
    @BACK_DONE
    0;JMP

(BACK11)
    @R11
    M=0
    @BACK_DONE
    0;JMP

(BACK12)
    @R12
    M=0
    @BACK_DONE
    0;JMP

(BACK13)
    @R13
    M=0
    @BACK_DONE
    0;JMP

(BACK14)
    @R14
    M=0
    @BACK_DONE
    0;JMP

(BACK15)
    @R15
    M=0
    @BACK_DONE
    0;JMP

(BACK_DONE)
    @lw_getBinaryInput
    0;JMP



// I handle c (clear) and q (quit) here.
// lw_key already holds the character.
(lw_handleClearOrQuit)
    // check if it was 'c'
    @lw_key
    D=M
    @99
    D=D-A
    @DO_CLEAR
    D;JEQ

    // if not 'c', I treat it as 'q'
    @DO_QUIT
    0;JMP

// c: clear registers and reset state
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

    @lw_getBinaryInput
    0;JMP

// q: clear and then stays in an infinite loop
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