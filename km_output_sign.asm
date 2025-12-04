// km_output_sign
// Uses km_sign_flag to output the sign at ge_currentColumn.
// km_sign_flag = 0 : '+'
// km_sign_flag = 1 : '-'
// Advances ge_currentColumn by 1.
(km_output_sign)
    // Save caller's ge_output_return
    @ge_output_return
    D=M
    @km_saved_ge_return_sign
    M=D

    // Load km_sign_flag
    @km_sign_flag
    D=M
    @km_output_sign_positive
    D;JEQ          // if 0 -> positive

    // -------- negative sign path: output '-' --------
    @km_output_sign_after_char
    D=A
    @ge_output_return
    M=D
    @ge_output_-
    0;JMP

// -------- positive sign path: output '+' --------
(km_output_sign_positive)
    @km_output_sign_after_char
    D=A
    @ge_output_return
    M=D
    @ge_output_+
    0;JMP

(km_output_sign_after_char)
    // advance column after sign
    @ge_currentColumn
    M=M+1

    // restore caller's ge_output_return
    @km_saved_ge_return_sign
    D=M
    @ge_output_return
    M=D

    // return to caller
    @ge_output_return
    A=M
    0;JMP

// km_sign_flag: 0 = positive, 1 = negative
(km_sign_flag)
    @0
    D=A          // optional init

// km_saved_ge_return_sign: backup of caller return for km_output_sign
(km_saved_ge_return_sign)
    @0
    D=A          // optional init
