// CS 30A – Group HACK Project
// Members: Logan Walters, Aspen Cristobal, Kamin Mojtahedi, Ivan Dibrova
//
// Description:
// This program lets the user type a signed 16-bit binary number using the keyboard,
// then displays the bits and their decimal value in the format Ex:
//
//     1111111111111111 --> -1
//     0000000000000001 --> 1
//
// R0 is used as the sign bit (1 = negative). R1–R15 hold the remaining bits.
//
// How it works:
// 1 - MAIN runs once at startup and on clear. It resets all states, clears the screen,
//    and prepares the program to read a new 16-bit binary number.
// 2 - INPUT_LOOP waits for keyboard input:
//      - '0' and '1' are stored into R0..R15 and drawn on the screen in columns 0–15.
//      - Backspace erases the previous bit and moves the cursor left.
//      - Enter tells the program that input is complete and triggers processing.
//      - 'c' or 'C' clears the screen and state so the user can start over.
//      - 'q' or 'Q' quits the program.
// 3 - PROCESS builds a 16-bit value from R0..R15, interprets R0 as the sign bit,
//    converts the magnitude to decimal, and splits it into digits.
// 4 - DRAW_RESULT prints the arrow "-->" and the decimal value to the right of
//    the 16-bit binary input. Negative values show a '-' sign.
// 5 - After printing the result, control returns to the INPUT_LOOP so the user can
//    enter another 16-bit number.



// program entry
    @MAIN
    0;JMP

// MAIN
// Description:
//   Start or reset the program. Clears the first text line on the screen,
//   wipes out any old bits and decimal values, and then goes to INPUT_LOOP
//   so the user can type a new 16-bit number.
//
// Inputs:
//   - There might be old data in R0..R15 and in the lw_* and decimal variables.
//
// Outputs:
//   - R0..R15 = 0 (no bits stored).
//   - All lw_* flags, valRaw, val, SIGN_IS_NEG, and decD* = 0.
//   - First text row on the screen cleared.
//   - Jumps to INPUT_LOOP (ready for input).
// ***** Logan Walters *****

(MAIN)
    // reset input flags
    @0
    D=A
    @lw_bitIndex
    M=D
    @lw_doneInput
    M=D
    @lw_key
    M=D
    @lw_bitVal
    M=D

    // reset conversion state
    @valRaw
    M=D
    @val
    M=D
    @SIGN_IS_NEG
    M=D

    @decD0
    M=D
    @decD1
    M=D
    @decD2
    M=D
    @decD3
    M=D
    @decD4
    M=D

    @currentDigit
    M=D
    @print_idx
    M=D
    @print_started
    M=D

    // clear R0..R15 (stored bits)
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

    // clear first screen text line
    @SCREEN
    D=A
    @cl_addr
    M=D

    @32   // 32 words = one row
    D=A
    @cl_count
    M=D

// ***** Logan Walters *****
(CLEAR_LINE_LOOP)
    @cl_count
    D=M
    @CLEAR_LINE_DONE
    D;JLE

    @cl_addr
    A=M
    M=0

    @cl_addr
    M=M+1
    @cl_count
    M=M-1
    @CLEAR_LINE_LOOP
    0;JMP

// ***** Logan Walters *****
(CLEAR_LINE_DONE)
    @INPUT_LOOP
    0;JMP

// INPUT_LOOP / WAIT_KEY / WAIT_RELEASE
// Description:
//   Handles keyboard input.
//   - If we are still typing the 16 bits, wait for a key and send it to the
//     correct handler (0, 1, Enter, Backspace, Clear, Quit).
//   - If input is marked as "done", jumps to PROCESS instead.
//
// Inputs:
//   - lw_doneInput = 0 → still typing bits.
//   - lw_doneInput = 1 → typing is finished; we should process the number.
//
// Outputs:
//   - For '0' or '1': updates R0..R15, bitIndex, and draws the bit.
//   - For Enter: sets lw_doneInput = 1 (PROCESS will run).
//   - For 'c'/'C': calls CLEAR_ALL (everything reset and then back here).
//   - For 'q'/'Q': jumps to HALT (stops program).
//   - Other keys: ignored.
// ***** Logan Walters *****

(INPUT_LOOP)
    // if doneInput == 1, go process
    @lw_doneInput
    D=M
    @WAIT_KEY
    D;JEQ
    @PROCESS
    0;JMP

// ***** Logan Walters *****
(WAIT_KEY)
    @KBD
    D=M
    @WAIT_KEY
    D;JEQ

    @lw_key
    M=D

// ***** Logan Walters *****
(WAIT_RELEASE)
    @KBD
    D=M
    @WAIT_RELEASE
    D;JNE

    // dispatch
    @lw_key
    D=M

    // '0' (48)
    @48
    D=D-A
    @HANDLE_ZERO
    D;JEQ
    @lw_key
    D=M

    // '1' (49)
    @49
    D=D-A
    @HANDLE_ONE
    D;JEQ
    @lw_key
    D=M

    // Enter (128)
    @128
    D=D-A
    @HANDLE_ENTER
    D;JEQ
    @lw_key
    D=M

    // Backspace (129)
    @129
    D=D-A
    @HANDLE_BACKSPACE
    D;JEQ
    @lw_key
    D=M

    // 'c' (99) or 'C' (67) -> clear
    @99
    D=D-A
    @HANDLE_CLEAR
    D;JEQ
    @lw_key
    D=M
    @67
    D=D-A
    @HANDLE_CLEAR
    D;JEQ
    @lw_key
    D=M

    // 'q' (113) or 'Q' (81) -> quit
    @113
    D=D-A
    @HANDLE_QUIT
    D;JEQ
    @lw_key
    D=M
    @81
    D=D-A
    @HANDLE_QUIT
    D;JEQ

    // anything else: ignore
    @INPUT_LOOP
    0;JMP

// HANDLE_ZERO / HANDLE_ONE / BIT_HANDLER
// Description:
//   Handles typing '0' or '1'.
//   - Saves the bit into the next R[bitIndex].
//   - Draws the bit on the first row of the screen at that column.
//
// Inputs:
//   - lw_bitIndex = which bit position we’re at (0..16).
//   - lw_bitVal = 0 or 1 (set by HANDLE_ZERO / HANDLE_ONE).
//   - R0..R15 may hold older bits from this number.
//
// Outputs:
//   - If lw_bitIndex < 16:
//       R[lw_bitIndex] = lw_bitVal, bit is drawn, lw_bitIndex++.
//   - If lw_bitIndex >= 16:
//       Bit is ignored (we already have 16 bits).
// ***** Logan Walters *****

(HANDLE_ZERO)
    @0
    D=A
    @lw_bitVal
    M=D
    @BIT_HANDLER
    0;JMP

// ***** Logan Walters *****
(HANDLE_ONE)
    @1
    D=A
    @lw_bitVal
    M=D
    @BIT_HANDLER
    0;JMP

// store lw_bitVal (0 or 1) at R[bitIndex], draw it, advance bitIndex
// ***** Logan Walters *****

(BIT_HANDLER)
    // if bitIndex >= 16 ignore
    @lw_bitIndex
    D=M
    @16
    D=D-A
    @INPUT_LOOP
    D;JGE

    // R[bitIndex] = lw_bitVal
    @lw_bitIndex
    D=M
    @R0
    D=A+D
    @bh_addr
    M=D

    @lw_bitVal
    D=M
    @bh_addr
    A=M
    M=D

    // draw this bit at column=bitIndex
    @lw_bitIndex
    D=M
    @ge_currentColumn
    M=D

    @AFTER_DRAW_BIT
    D=A
    @ge_output_return
    M=D

    @lw_bitVal
    D=M
    @DRAW_ZERO
    D;JEQ
    @ge_output_1
    0;JMP

// ***** Logan Walters *****
(DRAW_ZERO)
    @ge_output_0
    0;JMP

// ***** Logan Walters *****
(AFTER_DRAW_BIT)
    // advance bitIndex
    @lw_bitIndex
    M=M+1
    @INPUT_LOOP
    0;JMP

// HANDLE_BACKSPACE
// Description:
//   Handles Backspace.
//   - If there is at least one bit, remove the last bit and erase it from the screen.
//   - If there are no bits yet, do nothing.
//
// Inputs:
//   - lw_bitIndex = where the next bit would go.
//
// Outputs:
//   - If lw_bitIndex > 0:
//       lw_bitIndex--,
//       R[lw_bitIndex] = 0,
//       that column on screen is cleared.
//   - If lw_bitIndex == 0:
//       nothing changes.
// ***** Logan Walters *****

(HANDLE_BACKSPACE)
    // if bitIndex == 0, nothing to delete
    @lw_bitIndex
    D=M
    @INPUT_LOOP
    D;JEQ

    // bitIndex--
    @lw_bitIndex
    M=M-1

    // set R[bitIndex] = 0
    @lw_bitIndex
    D=M
    @R0
    D=A+D
    @bh_addr
    M=D

    @bh_addr
    A=M
    M=0

    // draw space (blank) at that column
    @lw_bitIndex
    D=M
    @ge_currentColumn
    M=D

    @AFTER_BACKSPACE_DRAW
    D=A
    @ge_output_return
    M=D
    @ge_output_s
    0;JMP

// ***** Logan Walters *****
(AFTER_BACKSPACE_DRAW)
    @INPUT_LOOP
    0;JMP

// HANDLE_CLEAR / CLEAR_ALL
// Description:
//   Handles 'c' / 'C' (clear).
//   - Erases the bits and result from the first row on the screen.
//   - Clears all stored bits and internal variables.
//   - Sends control back to INPUT_LOOP like a fresh start.
//
// Inputs:
//   - User pressed 'c' or 'C'.
//   - Old data may be in R0..R15 and the lw_* / decimal variables.
//
// Outputs:
//   - First text line cleared.
//   - R0..R15 = 0, lw_* and conversion state reset.
//   - Jumps to INPUT_LOOP (ready for new input).
// ***** Logan Walters *****

(HANDLE_CLEAR)
    @CLEAR_ALL
    0;JMP

// ***** Logan Walters *****
(CLEAR_ALL)
    // clear just the first text line (where bits and result live)
    @SCREEN
    D=A
    @ca_addr
    M=D

    @384   // clear all
    D=A
    @ca_count
    M=D

// ***** Logan Walters *****
(CA_LOOP)
    @ca_count
    D=M
    @CA_DONE
    D;JLE

    @ca_addr
    A=M
    M=0

    @ca_addr
    M=M+1
    @ca_count
    M=M-1
    @CA_LOOP
    0;JMP

// ***** Logan Walters *****
(CA_DONE)
    // clear R0..R15 (stored bits)
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

    // reset input flags
    @0
    D=A
    @lw_bitIndex
    M=D
    @lw_doneInput
    M=D
    @lw_key
    M=D
    @lw_bitVal
    M=D

    // reset conversion state
    @valRaw
    M=D
    @val
    M=D
    @SIGN_IS_NEG
    M=D

    @decD0
    M=D
    @decD1
    M=D
    @decD2
    M=D
    @decD3
    M=D
    @decD4
    M=D

    @currentDigit
    M=D
    @print_idx
    M=D
    @print_started
    M=D

    @INPUT_LOOP
    0;JMP

// HANDLE_QUIT / HALT
// Description:
//   Handles 'q' / 'Q' (quit).
//   - Sends the program into an infinite loop, so it effectively stops.
//
// Inputs:
//   - User pressed 'q' or 'Q'.
//
// Outputs:
//   - Program stays at HALT forever.
// ***** Logan Walters *****

(HANDLE_QUIT)
    // halt the program (infinite loop)
    @HALT
    0;JMP

// ***** Logan Walters *****
(HALT)
    @HALT
    0;JMP


// HANDLE_ENTER
// Description:
//   Handles Enter.
//   - Marks that the 16 bits are done and tells INPUT_LOOP to move on to PROCESS.
//
// Inputs:
//   - User pressed Enter (128).
//   - R0..R15 hold whatever bits the user has typed so far.
//
// Outputs:
//   - lw_doneInput = 1.
//   - Next time INPUT_LOOP runs, it jumps to PROCESS.
// ***** Logan Walters *****

(HANDLE_ENTER)
    @1
    D=A
    @lw_doneInput
    M=D
    @INPUT_LOOP
    0;JMP


// PROCESS
// Description:
//   Turns the 16 stored bits into a signed decimal value.
//   - Rebuilds the 16-bit number into valRaw.
//   - Checks R0 (sign bit) to see if the number is negative.
//   - Stores the absolute value in val and remembers if it was negative.
//   - Calls SPLIT_DECIMAL to break the value into decimal digits.
//
// Inputs:
//   - R0..R15 contain the final bits for this number.
//   - R0 is the sign bit (1 = negative, 0 = non-negative).
//   - lw_doneInput == 1.
//
// Outputs:
//   - valRaw = full 16-bit signed value from the bits.
//   - val = non-negative magnitude of that value.
//   - SIGN_IS_NEG = 1 if negative, 0 if not.
//   - Then we jump into SPLIT_DECIMAL (which later calls DRAW_RESULT).
// ***** Aspen Cristobal *****

(PROCESS)
    // build raw 16-bit value from R[0..15] into valRaw
    @0
    D=A
    @valRaw
    M=D

    @0
    D=A
    @b2d_i
    M=D         // b2d_i = 0

// BUILD_LOOP
// Description:
//   Builds up valRaw bit by bit.
//   - valRaw = valRaw * 2
//   - If the current bit R[i] is 1, add 1 to valRaw.
//
// Inputs:
//   - b2d_i = which bit we’re on (0..16).
//   - R0..R15 = bit pattern (R0 is sign bit).
//
// Outputs:
//   - After i reaches 16, valRaw holds the full 16-bit value.
//   - b2d_i ends at 16.
// ***** Kamin Mojtahedi *****

(BUILD_LOOP)
    @b2d_i
    D=M
    @16
    D=D-A
    @BUILD_DONE
    D;JGE       // if i >= 16, done

    // valRaw = valRaw * 2
    @valRaw
    D=M
    M=D+M

    // if R[i] == 1 then valRaw++
    @R0
    D=A
    @b2d_i
    A=M
    D=D+A       // address of R[i]
    A=D
    D=M
    @BUILD_SKIP_ADD
    D;JEQ
    @valRaw
    M=M+1

// ***** Kamin Mojtahedi *****
(BUILD_SKIP_ADD)
    @b2d_i
    M=M+1
    @BUILD_LOOP
    0;JMP

// ***** Kamin Mojtahedi *****
(BUILD_DONE)
    // decide sign and magnitude
    @R0
    D=M
    @NEG_NUM
    D;JNE       // if sign bit 1 -> negative

// positive: magnitude = valRaw, no sign printed
// ***** Aspen Cristobal *****
(POS_NUM)
    @valRaw
    D=M
    @val
    M=D
    @SIGN_IS_NEG
    M=0
    @SPLIT_DECIMAL
    0;JMP

// negative: magnitude = -valRaw, and we record that it's negative
// ***** Aspen Cristobal *****
(NEG_NUM)
    @valRaw
    D=M
    D=-D
    @val
    M=D
    @SIGN_IS_NEG
    M=1
    @SPLIT_DECIMAL
    0;JMP

// SPLIT_DECIMAL
// Description:
//   Converts the magnitude in val into 5 separate decimal digits.
//   It does this by repeatedly subtracting 10000, 1000, 100, and 10.
//
// Inputs:
//   - val = non-negative magnitude of the number.
//   - SIGN_IS_NEG already set (not changed here).
//
// Outputs:
//   - decD4..decD0 hold the decimal digits of val.
//   - Calls DRAW_RESULT to actually show the arrow, sign, and digits.
// ***** Aspen Cristobal *****

(SPLIT_DECIMAL)
    // clear digits
    @0
    D=A
    @decD0
    M=D
    @decD1
    M=D
    @decD2
    M=D
    @decD3
    M=D
    @decD4
    M=D

// ***** Aspen Cristobal *****
(D4_LOOP)
    @val
    D=M
    @10000
    D=D-A
    @D4_DONE
    D;JLT
    @val
    M=D
    @decD4
    M=M+1
    @D4_LOOP
    0;JMP

// ***** Aspen Cristobal *****
(D4_DONE)
// d3 = val / 1000
(D3_LOOP)
    @val
    D=M
    @1000
    D=D-A
    @D3_DONE
    D;JLT
    @val
    M=D
    @decD3
    M=M+1
    @D3_LOOP
    0;JMP

// ***** Aspen Cristobal *****
(D3_DONE)
// d2 = val / 100
(D2_LOOP)
    @val
    D=M
    @100
    D=D-A
    @D2_DONE
    D;JLT
    @val
    M=D
    @decD2
    M=M+1
    @D2_LOOP
    0;JMP

// ***** Aspen Cristobal *****
(D2_DONE)
// d1 = val / 10
(D1_LOOP)
    @val
    D=M
    @10
    D=D-A
    @D1_DONE
    D;JLT
    @val
    M=D
    @decD1
    M=M+1
    @D1_LOOP
    0;JMP

// ***** Aspen Cristobal *****
(D1_DONE)
    @val
    D=M
    @decD0
    M=D

    @DRAW_RESULT
    0;JMP

// DRAW_RESULT
// Description:
//   Draws the final output on the first row:
//   - "-->" arrow
//   - '-' sign if the number is negative
//   - the decimal digits decD4..decD0 (skipping leading zeros, but
//     always showing at least one digit).
// Inputs:
//   - decD4..decD0 contain the digits to print.
//   - SIGN_IS_NEG is 1 if the value is negative, 0 otherwise.
// Outputs:
//   - Arrow, sign (if needed), and digits appear to the right of the bits.
//   - lw_doneInput is reset to 0 so the user can type another number.
// ***** Aspen Cristobal *****

(DRAW_RESULT)
    // arrow start at col 16 (one space after bits)
    @16
    D=A
    @ge_currentColumn
    M=D

    // first '-' of arrow
    @AFTER_ARROW_MINUS1
    D=A
    @ge_output_return
    M=D
    @ge_output_-
    0;JMP

// ***** Aspen Cristobal *****
(AFTER_ARROW_MINUS1)
    @ge_currentColumn
    M=M+1

    // second '-' of arrow
    @AFTER_ARROW_MINUS2
    D=A
    @ge_output_return
    M=D
    @ge_output_-
    0;JMP

// ***** Aspen Cristobal *****
(AFTER_ARROW_MINUS2)
    @ge_currentColumn
    M=M+1

    // '>' using ge_output_g
    @AFTER_ARROW_GT
    D=A
    @ge_output_return
    M=D
    @ge_output_g
    0;JMP

// ***** Aspen Cristobal *****
(AFTER_ARROW_GT)
    @ge_currentColumn
    M=M+1

    // one space after arrow
    @AFTER_ARROW_SPACE
    D=A
    @ge_output_return
    M=D
    @ge_output_s
    0;JMP

// ***** Aspen Cristobal *****
(AFTER_ARROW_SPACE)
    // position for sign or first digit
    @ge_currentColumn
    M=M+1

    // if SIGN_IS_NEG == 0, skip printing sign
    @SIGN_IS_NEG
    D=M
    @NO_SIGN
    D;JEQ

    // negative: print '-'
    @AFTER_SIGN
    D=A
    @ge_output_return
    M=D
    @ge_output_-
    0;JMP

// ***** Aspen Cristobal *****
(NO_SIGN)
    // no sign printed, go straight to digits
    @PRINT_DIGITS_START
    0;JMP

// ***** Aspen Cristobal *****
(AFTER_SIGN)
    // we printed '-', move to next column for digits
    @ge_currentColumn
    M=M+1

// ***** Aspen Cristobal *****
(PRINT_DIGITS_START)
    // print digits decD4..decD0, skipping leading zeros
    @4
    D=A
    @print_idx
    M=D
    @0
    D=A
    @print_started
    M=D

// PRINT_DIGITS_LOOP
// Description:
//   Prints the digits decD4..decD0 from left to right.
//   - Skips leading zeros until a non-zero digit or the last digit.
//   - Uses ge_output_0..9 to draw each digit glyph.
// Inputs:
//   - decD4..decD0 contain the digits.
// Outputs:
//   - Decimal digits are drawn on screen after the sign.
// ***** Aspen Cristobal *****

(PRINT_DIGITS_LOOP)
    @print_idx
    D=M
    @DONE_DIGITS
    D;JLT

    // pick current digit into currentDigit
    @print_idx
    D=M
    @4
    D=D-A
    @PD4
    D;JEQ
    @print_idx
    D=M
    @3
    D=D-A
    @PD3
    D;JEQ
    @print_idx
    D=M
    @2
    D=D-A
    @PD2
    D;JEQ
    @print_idx
    D=M
    @1
    D=D-A
    @PD1
    D;JEQ
    @decD0
    D=M
    @PD_HAVE
    0;JMP

// ***** Aspen Cristobal *****
(PD4)
    @decD4
    D=M
    @PD_HAVE
    0;JMP

// ***** Aspen Cristobal *****
(PD3)
    @decD3
    D=M
    @PD_HAVE
    0;JMP

// ***** Aspen Cristobal *****
(PD2)
    @decD2
    D=M
    @PD_HAVE
    0;JMP

// ***** Aspen Cristobal *****
(PD1)
    @decD1
    D=M

// ***** Aspen Cristobal *****
(PD_HAVE)
    @currentDigit
    M=D

    // skip leading zeros
    @print_started
    D=M
    @PD_CHECK_SKIP
    D;JEQ
    @PD_PRINT
    0;JMP

// ***** Aspen Cristobal *****
(PD_CHECK_SKIP)
    @currentDigit
    D=M
    @PD_MAYBE_LAST
    D;JNE

    // digit == 0 and not started; if idx != 0, skip
    @print_idx
    D=M
    @0
    D=D-A
    @PD_PRINT
    D;JEQ

    // skip
    @print_idx
    M=M-1
    @PRINT_DIGITS_LOOP
    0;JMP

// ***** Aspen Cristobal *****
(PD_MAYBE_LAST)
    @1
    D=A
    @print_started
    M=D

// ***** Aspen Cristobal *****
(PD_PRINT)
    // map 0..9 -> ge_output_0..9
    @currentDigit
    D=M
    @P0
    D;JEQ
    @currentDigit
    D=M
    @1
    D=D-A
    @P1
    D;JEQ
    @currentDigit
    D=M
    @2
    D=D-A
    @P2
    D;JEQ
    @currentDigit
    D=M
    @3
    D=D-A
    @P3
    D;JEQ
    @currentDigit
    D=M
    @4
    D=D-A
    @P4_
    D;JEQ
    @currentDigit
    D=M
    @5
    D=D-A
    @P5
    D;JEQ
    @currentDigit
    D=M
    @6
    D=D-A
    @P6
    D;JEQ
    @currentDigit
    D=M
    @7
    D=D-A
    @P7
    D;JEQ
    @currentDigit
    D=M
    @8
    D=D-A
    @P8
    D;JEQ
    @P9
    0;JMP

// ***** Aspen Cristobal *****
(P0)
    @AFTER_PRINT_DIGIT
    D=A
    @ge_output_return
    M=D
    @ge_output_0
    0;JMP

// ***** Aspen Cristobal *****
(P1)
    @AFTER_PRINT_DIGIT
    D=A
    @ge_output_return
    M=D
    @ge_output_1
    0;JMP

// ***** Aspen Cristobal *****
(P2)
    @AFTER_PRINT_DIGIT
    D=A
    @ge_output_return
    M=D
    @ge_output_2
    0;JMP

// ***** Aspen Cristobal *****
(P3)
    @AFTER_PRINT_DIGIT
    D=A
    @ge_output_return
    M=D
    @ge_output_3
    0;JMP

// ***** Aspen Cristobal *****
(P4_)
    @AFTER_PRINT_DIGIT
    D=A
    @ge_output_return
    M=D
    @ge_output_4
    0;JMP

// ***** Aspen Cristobal *****
(P5)
    @AFTER_PRINT_DIGIT
    D=A
    @ge_output_return
    M=D
    @ge_output_5
    0;JMP

// ***** Aspen Cristobal *****
(P6)
    @AFTER_PRINT_DIGIT
    D=A
    @ge_output_return
    M=D
    @ge_output_6
    0;JMP

// ***** Aspen Cristobal *****
(P7)
    @AFTER_PRINT_DIGIT
    D=A
    @ge_output_return
    M=D
    @ge_output_7
    0;JMP

// ***** Aspen Cristobal *****
(P8)
    @AFTER_PRINT_DIGIT
    D=A
    @ge_output_return
    M=D
    @ge_output_8
    0;JMP

// ***** Aspen Cristobal *****
(P9)
    @AFTER_PRINT_DIGIT
    D=A
    @ge_output_return
    M=D
    @ge_output_9
    0;JMP

// ***** Aspen Cristobal *****
(AFTER_PRINT_DIGIT)
    @ge_currentColumn
    M=M+1
    @print_idx
    M=M-1
    @PRINT_DIGITS_LOOP
    0;JMP

// ***** Aspen Cristobal *****
(DONE_DIGITS)
    // after showing result, allow new input again
    @0
    D=A
    @lw_doneInput
    M=D
    @INPUT_LOOP
    0;JMP


// FONT ROUTINES
// Description:
//   These routines draw characters (digits, '-', '>', blank, '+') on the screen.
//   - ge_output_0..9, ge_output_s, ge_output_-, ge_output_g, ge_output_+
//     each load a small 9-row pattern into ge_fontRow1..9.
//   - ge_continue_output uses that pattern and ge_currentColumn to draw it.
// Inputs:
//   - ge_currentColumn = which column to draw in.
//   - ge_output_return = where to jump back after drawing.
// Outputs:
//   - The chosen character appears on the first text row at ge_currentColumn.
//   - Control returns to ge_output_return.
// ***** Ivan Dibrova & Professor Eaton *****

(ge_continue_output)
    @32
    D=A
    @ge_rowOffset
    M=D
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
    @ge_fontRow1
    D=M
    @ge_currentRow
    A=M
    M=D
    @ge_rowOffset
    D=M
    @ge_currentRow
    M=D+M
    @ge_fontRow2
    D=M
    @ge_currentRow
    A=M
    M=D
    @ge_rowOffset
    D=M
    @ge_currentRow
    M=D+M
    @ge_fontRow3
    D=M
    @ge_currentRow
    A=M
    M=D
    @ge_rowOffset
    D=M
    @ge_currentRow
    M=D+M
    @ge_fontRow4
    D=M
    @ge_currentRow
    A=M
    M=D
    @ge_rowOffset
    D=M
    @ge_currentRow
    M=D+M
    @ge_fontRow5
    D=M
    @ge_currentRow
    A=M
    M=D
    @ge_rowOffset
    D=M
    @ge_currentRow
    M=D+M
    @ge_fontRow6
    D=M
    @ge_currentRow
    A=M
    M=D
    @ge_rowOffset
    D=M
    @ge_currentRow
    M=D+M
    @ge_fontRow7
    D=M
    @ge_currentRow
    A=M
    M=D
    @ge_rowOffset
    D=M
    @ge_currentRow
    M=D+M
    @ge_fontRow8
    D=M
    @ge_currentRow
    A=M
    M=D
    @ge_rowOffset
    D=M
    @ge_currentRow
    M=D+M
    @ge_fontRow9
    D=M
    @ge_currentRow
    A=M
    M=D
    @ge_output_return
    A=M
    0;JMP

// ***** Ivan Dibrova & Professor Eaton *****
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

// ***** Ivan Dibrova & Professor Eaton *****
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

// ***** Ivan Dibrova & Professor Eaton *****
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

// ***** Ivan Dibrova & Professor Eaton *****
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

// ***** Ivan Dibrova & Professor Eaton *****
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

// ***** Ivan Dibrova & Professor Eaton *****
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

// ***** Ivan Dibrova & Professor Eaton *****
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

// ***** Ivan Dibrova & Professor Eaton *****
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

// ***** Ivan Dibrova & Professor Eaton *****
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

// ***** Ivan Dibrova & Professor Eaton *****
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
    @25
    D=A
    @ge_fontRow8
    M=D
    @14
    D=A
    @ge_fontRow9
    M=D
    @ge_continue_output
    0;JMP

// ***** Ivan Dibrova & Professor Eaton *****
(ge_output_s)     // blank
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

// ***** Ivan Dibrova & Professor Eaton *****
(ge_output_-)     // minus sign
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

// ***** Ivan Dibrova & Professor Eaton *****
(ge_output_g)     // used as ">" for arrow
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

// ***** Ivan Dibrova & Professor Eaton *****
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
