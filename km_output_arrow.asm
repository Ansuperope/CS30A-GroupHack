// km_output_arrow
// Outputs "->" starting at ge_currentColumn,
// and advances ge_currentColumn by 2 columns.
(km_output_arrow)
    // Save caller's ge_output_return
    @ge_output_return
    D=M
    @km_saved_ge_return_arrow
    M=D

    // ----- output '-' at current column -----
    @km_output_arrow_after_minus
    D=A
    @ge_output_return
    M=D
    @ge_output_-
    0;JMP

(km_output_arrow_after_minus)
    // advance column after '-'
    @ge_currentColumn
    M=M+1

    // ----- output '>' at new column -----
    @km_output_arrow_after_arrow
    D=A
    @ge_output_return
    M=D
    @ge_output_g
    0;JMP

(km_output_arrow_after_arrow)
    // advance column after '>'
    @ge_currentColumn
    M=M+1

    // restore caller's ge_output_return
    @km_saved_ge_return_arrow
    D=M
    @ge_output_return
    M=D

    // return to caller
    @ge_output_return
    A=M
    0;JMP

// km_saved_ge_return_arrow: backups caller return for km_output_arrow
(km_saved_ge_return_arrow)
    @0
    D=A        // optional init (assembler will allocate this symbol)
