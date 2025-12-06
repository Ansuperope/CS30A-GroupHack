// km_output.asm
// Test: draw "->+" or "->-" depending on R15
// R15 = 0 -> "+"
///R15 = 1 -> "-"

// ====================================================
// Entry: jump to test main
// ====================================================
@km_test_main
0;JMP


// ====================================================
// ge_continue_output + font functions (0-9, space, -, >, +)
// (from ge_output_x.asm, tests removed)
// ====================================================

(ge_continue_output)
    // row offset = 32
    @32
    D=A
    @ge_rowOffset
    M=D

    // ge_currentRow = SCREEN + 3*rowOffset + ge_currentColumn
    @SCREEN
    D=A
    @ge_rowOffset
    D=D+M
    D=D+M
    D=D+M
    @ge_currentColumn
    D=D+M
    @ge_currentRow
    M=D

    // row 1
    @ge_fontRow1
    D=M
    @ge_currentRow
    A=M
    M=D

    // row 2
    @ge_rowOffset
    D=M
    @ge_currentRow
    M=D+M
    @ge_fontRow2
    D=M
    @ge_currentRow
    A=M
    M=D

    // row 3
    @ge_rowOffset
    D=M
    @ge_currentRow
    M=D+M
    @ge_fontRow3
    D=M
    @ge_currentRow
    A=M
    M=D

    // row 4
    @ge_rowOffset
    D=M
    @ge_currentRow
    M=D+M
    @ge_fontRow4
    D=M
    @ge_currentRow
    A=M
    M=D

    // row 5
    @ge_rowOffset
    D=M
    @ge_currentRow
    M=D+M
    @ge_fontRow5
    D=M
    @ge_currentRow
    A=M
    M=D

    // row 6
    @ge_rowOffset
    D=M
    @ge_currentRow
    M=D+M
    @ge_fontRow6
    D=M
    @ge_currentRow
    A=M
    M=D

    // row 7
    @ge_rowOffset
    D=M
    @ge_currentRow
    M=D+M
    @ge_fontRow7
    D=M
    @ge_currentRow
    A=M
    M=D

    // row 8
    @ge_rowOffset
    D=M
    @ge_currentRow
    M=D+M
    @ge_fontRow8
    D=M
    @ge_currentRow
    A=M
    M=D

    // row 9
    @ge_rowOffset
    D=M
    @ge_currentRow
    M=D+M
    @ge_fontRow9
    D=M
    @ge_currentRow
    A=M
    M=D

    // return from ge_output_X
    @ge_output_return
    A=M
    0;JMP


// ---------- ge_output_0 ----------
(ge_output_0)
    @12
    D=A
    @ge_fontRow1
    M=D

    @30
    D=A
    @ge_fontRow2
    M=D

    @51
    D=A
    @ge_fontRow3
    M=D

    @51
    D=A
    @ge_fontRow4
    M=D

    @51
    D=A
    @ge_fontRow5
    M=D

    @51
    D=A
    @ge_fontRow6
    M=D

    @51
    D=A
    @ge_fontRow7
    M=D

    @30
    D=A
    @ge_fontRow8
    M=D

    @12
    D=A
    @ge_fontRow9
    M=D

    @ge_continue_output
    0;JMP

// ---------- ge_output_1 ----------
(ge_output_1)
    @12
    D=A
    @ge_fontRow1
    M=D

    @14
    D=A
    @ge_fontRow2
    M=D

    @15
    D=A
    @ge_fontRow3
    M=D

    @12
    D=A
    @ge_fontRow4
    M=D

    @12
    D=A
    @ge_fontRow5
    M=D

    @12
    D=A
    @ge_fontRow6
    M=D

    @12
    D=A
    @ge_fontRow7
    M=D

    @12
    D=A
    @ge_fontRow8
    M=D

    @63
    D=A
    @ge_fontRow9
    M=D

    @ge_continue_output
    0;JMP

// ---------- ge_output_2 ----------
(ge_output_2)
    @30
    D=A
    @ge_fontRow1
    M=D

    @51
    D=A
    @ge_fontRow2
    M=D

    @48
    D=A
    @ge_fontRow3
    M=D

    @24
    D=A
    @ge_fontRow4
    M=D

    @12
    D=A
    @ge_fontRow5
    M=D

    @6
    D=A
    @ge_fontRow6
    M=D

    @3
    D=A
    @ge_fontRow7
    M=D

    @51
    D=A
    @ge_fontRow8
    M=D

    @63
    D=A
    @ge_fontRow9
    M=D

    @ge_continue_output
    0;JMP

// ---------- ge_output_3 ----------
(ge_output_3)
    @30
    D=A
    @ge_fontRow1
    M=D

    @51
    D=A
    @ge_fontRow2
    M=D

    @48
    D=A
    @ge_fontRow3
    M=D

    @48
    D=A
    @ge_fontRow4
    M=D

    @28
    D=A
    @ge_fontRow5
    M=D

    @48
    D=A
    @ge_fontRow6
    M=D

    @48
    D=A
    @ge_fontRow7
    M=D

    @51
    D=A
    @ge_fontRow8
    M=D

    @30
    D=A
    @ge_fontRow9
    M=D

    @ge_continue_output
    0;JMP

// ---------- ge_output_4 ----------
(ge_output_4)
    @16
    D=A
    @ge_fontRow1
    M=D

    @24
    D=A
    @ge_fontRow2
    M=D

    @28
    D=A
    @ge_fontRow3
    M=D

    @26
    D=A
    @ge_fontRow4
    M=D

    @25
    D=A
    @ge_fontRow5
    M=D

    @63
    D=A
    @ge_fontRow6
    M=D

    @24
    D=A
    @ge_fontRow7
    M=D

    @24
    D=A
    @ge_fontRow8
    M=D

    @60
    D=A
    @ge_fontRow9
    M=D

    @ge_continue_output
    0;JMP

// ---------- ge_output_5 ----------
(ge_output_5)
    @63
    D=A
    @ge_fontRow1
    M=D

    @3
    D=A
    @ge_fontRow2
    M=D

    @3
    D=A
    @ge_fontRow3
    M=D

    @31
    D=A
    @ge_fontRow4
    M=D

    @48
    D=A
    @ge_fontRow5
    M=D

    @48
    D=A
    @ge_fontRow6
    M=D

    @48
    D=A
    @ge_fontRow7
    M=D

    @51
    D=A
    @ge_fontRow8
    M=D

    @30
    D=A
    @ge_fontRow9
    M=D

    @ge_continue_output
    0;JMP

// ---------- ge_output_6 ----------
(ge_output_6)
    @28
    D=A
    @ge_fontRow1
    M=D

    @6
    D=A
    @ge_fontRow2
    M=D

    @3
    D=A
    @ge_fontRow3
    M=D

    @3
    D=A
    @ge_fontRow4
    M=D

    @31
    D=A
    @ge_fontRow5
    M=D

    @51
    D=A
    @ge_fontRow6
    M=D

    @51
    D=A
    @ge_fontRow7
    M=D

    @51
    D=A
    @ge_fontRow8
    M=D

    @30
    D=A
    @ge_fontRow9
    M=D

    @ge_continue_output
    0;JMP

// ---------- ge_output_7 ----------
(ge_output_7)
    @63
    D=A
    @ge_fontRow1
    M=D

    @49
    D=A
    @ge_fontRow2
    M=D

    @48
    D=A
    @ge_fontRow3
    M=D

    @48
    D=A
    @ge_fontRow4
    M=D

    @24
    D=A
    @ge_fontRow5
    M=D

    @12
    D=A
    @ge_fontRow6
    M=D

    @12
    D=A
    @ge_fontRow7
    M=D

    @12
    D=A
    @ge_fontRow8
    M=D

    @12
    D=A
    @ge_fontRow9
    M=D

    @ge_continue_output
    0;JMP

// ---------- ge_output_8 ----------
(ge_output_8)
    @30
    D=A
    @ge_fontRow1
    M=D

    @51
    D=A
    @ge_fontRow2
    M=D

    @51
    D=A
    @ge_fontRow3
    M=D

    @51
    D=A
    @ge_fontRow4
    M=D

    @30
    D=A
    @ge_fontRow5
    M=D

    @51
    D=A
    @ge_fontRow6
    M=D

    @51
    D=A
    @ge_fontRow7
    M=D

    @51
    D=A
    @ge_fontRow8
    M=D

    @30
    D=A
    @ge_fontRow9
    M=D

    @ge_continue_output
    0;JMP

// ---------- ge_output_9 ----------
(ge_output_9)
    @30
    D=A
    @ge_fontRow1
    M=D

    @51
    D=A
    @ge_fontRow2
    M=D

    @51
    D=A
    @ge_fontRow3
    M=D

    @51
    D=A
    @ge_fontRow4
    M=D

    @62
    D=A
    @ge_fontRow5
    M=D

    @48
    D=A
    @ge_fontRow6
    M=D

    @48
    D=A
    @ge_fontRow7
    M=D

    @24        // (your prof's file might have 24 or 25; doesn't matter here)
    D=A
    @ge_fontRow8
    M=D

    @14
    D=A
    @ge_fontRow9
    M=D

    @ge_continue_output
    0;JMP

// ---------- ge_output_s (space) ----------
(ge_output_s)
    @0
    D=A
    @ge_fontRow1
    M=D

    @0
    D=A
    @ge_fontRow2
    M=D

    @0
    D=A
    @ge_fontRow3
    M=D

    @0
    D=A
    @ge_fontRow4
    M=D

    @0
    D=A
    @ge_fontRow5
    M=D

    @0
    D=A
    @ge_fontRow6
    M=D

    @0
    D=A
    @ge_fontRow7
    M=D

    @0
    D=A
    @ge_fontRow8
    M=D

    @0
    D=A
    @ge_fontRow9
    M=D

    @ge_continue_output
    0;JMP

// ---------- ge_output_- ----------
(ge_output_-)
    @0
    D=A
    @ge_fontRow1
    M=D

    @0
    D=A
    @ge_fontRow2
    M=D

    @0
    D=A
    @ge_fontRow3
    M=D

    @0
    D=A
    @ge_fontRow4
    M=D

    @0
    D=A
    @ge_fontRow5
    M=D

    @63
    D=A
    @ge_fontRow6
    M=D

    @0
    D=A
    @ge_fontRow7
    M=D

    @0
    D=A
    @ge_fontRow8
    M=D

    @0
    D=A
    @ge_fontRow9
    M=D

    @ge_continue_output
    0;JMP

// ---------- ge_output_g (>) ----------
(ge_output_g)
    @0
    D=A
    @ge_fontRow1
    M=D

    @0
    D=A
    @ge_fontRow2
    M=D

    @3
    D=A
    @ge_fontRow3
    M=D

    @6
    D=A
    @ge_fontRow4
    M=D

    @12
    D=A
    @ge_fontRow5
    M=D

    @24
    D=A
    @ge_fontRow6
    M=D

    @12
    D=A
    @ge_fontRow7
    M=D

    @6
    D=A
    @ge_fontRow8
    M=D

    @3
    D=A
    @ge_fontRow9
    M=D

    @ge_continue_output
    0;JMP

// ---------- ge_output_+ ----------
(ge_output_+)
    @0
    D=A
    @ge_fontRow1
    M=D

    @0
    D=A
    @ge_fontRow2
    M=D

    @0
    D=A
    @ge_fontRow3
    M=D

    @12
    D=A
    @ge_fontRow4
    M=D

    @12
    D=A
    @ge_fontRow5
    M=D

    @63
    D=A
    @ge_fontRow6
    M=D

    @12
    D=A
    @ge_fontRow7
    M=D

    @12
    D=A
    @ge_fontRow8
    M=D

    @0
    D=A
    @ge_fontRow9
    M=D

    @ge_continue_output
    0;JMP


// ====================================================
// km_output_arrow
// ====================================================
//
// Caller must:
//   - set ge_currentColumn
//   - set km_arrow_return = address to continue after arrow
//
// Behavior:
//   prints "->" at ge_currentColumn, advances by 2,
//   then jumps to km_arrow_return.
//
(km_output_arrow)
    // print '-'
    @km_arrow_after_minus
    D=A
    @ge_output_return
    M=D
    @ge_output_-
    0;JMP

(km_arrow_after_minus)
    // move to next column
    @ge_currentColumn
    M=M+1

    // print '>'
    @km_arrow_after_gt
    D=A
    @ge_output_return
    M=D
    @ge_output_g
    0;JMP

(km_arrow_after_gt)
    // advance past '>'
    @ge_currentColumn
    M=M+1

    // return to caller
    @km_arrow_return
    A=M
    0;JMP


// ====================================================
// ac_process_get_sign
// ====================================================
//
// Input:
//   R15 = 0 -> positive, output '+'
//   R15 = 1 -> negative, output '-'
//
// Caller must:
//   - set ge_currentColumn
//   - set km_sign_return = address to continue after sign
//
// Behavior:
//   prints sign (+/-) at ge_currentColumn,
//   advances by 1,
//   then jumps to km_sign_return.
//
(ac_process_get_sign)
    @R15
    D=M
    @ac_sign_pos
    D;JEQ        // if R15==0 -> positive

// ---- negative ----
(ac_sign_neg)
    @ac_sign_after
    D=A
    @ge_output_return
    M=D
    @ge_output_-
    0;JMP

// ---- positive ----
(ac_sign_pos)
    @ac_sign_after
    D=A
    @ge_output_return
    M=D
    @ge_output_+
    0;JMP

(ac_sign_after)
    // advance column after sign
    @ge_currentColumn
    M=M+1

    // return to caller
    @km_sign_return
    A=M
    0;JMP


// ====================================================
// km_test_main
// Hard-coded demo:
//   - column 0
//   - R15 = 0 -> "->+"
//   - change to 1 for "->-"
// ====================================================
(km_test_main)
    // set starting column
    @0
    D=A
    @ge_currentColumn
    M=D

    // ----- SET SIGN HERE -----
    // R15 = 0 -> "+"
    // R15 = 1 -> "-"
    @1     // change this to @1 to test '-'
    D=A
    @R15
    M=D
    // --------------------------

    // call km_output_arrow
    @after_arrow
    D=A
    @km_arrow_return
    M=D
    @km_output_arrow
    0;JMP

(after_arrow)
    // call ac_process_get_sign
    @after_sign
    D=A
    @km_sign_return
    M=D
    @ac_process_get_sign
    0;JMP

(after_sign)
    // infinite loop so screen stays
    @after_sign
    0;JMP
