/*
  This is my backspace function.
  If lw_bitIndex is 0, I do nothing.
  Otherwise I move lw_cursor left, lower lw_bitIndex,
  and clear the matching R0..R15 cell.
*/

// I handle backspace here.
// If bitIndex is 0, I do nothing.
// Otherwise I move cursor left and clear the last R register.

(lw_handleBackspace)
    @lw_bitIndex
    D=M
    @BACK_DONE
    D;JEQ      
    // nothing to delete

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
    // when I’m done, I just go back to the input loop
    @lw_getBinaryInput
    0;JMP