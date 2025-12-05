// === id_clearline =============================================================
// Author: Ivan Dibrova
// 
// Clears a single line on the display and resets cursor position to 0
// ===========================================================================

// C++ PSEUDOCODE

// void id_clearline() {
//     ** Clear the display line (16 pixels wide) **
//     int screenStart = SCREEN_BASE_ADDRESS;
//     int wordsPerLine = 32;  // 512 pixels / 16 bits per word
//     
//     ** Clear each word in the line **
//     for (int i = 0; i < wordsPerLine; i++) {
//         screen[screenStart + i] = 0;
//     }
//     
//     ** Reset cursor to beginning **
//     cursorColumn = 0;
// }

//Id_clearline
(id_clearline)
    // Initialize screen address to start of screen
    @SCREEN
    D=A
    @id_clearline_screenAddr
    M=D                     // screenAddr = SCREEN base address

    // Initialize counter for 32 words (one line)
    @32
    D=A
    @id_clearline_counter
    M=D                     // counter = 32

    // Loop to clear each word in the line
    (id_clearline_LOOP)
        // Check if counter reached 0
        @id_clearline_counter
        D=M
        @id_clearline_RESET_CURSOR
        D;JLE               // If counter <= 0, done clearing

        // Clear current screen word
        @id_clearline_screenAddr
        A=M                 // Go to screen address
        M=0                 // Clear the word (set to 0)

        // Move to next screen word
        @id_clearline_screenAddr
        M=M+1               // Increment screen address

        // Decrement counter
        @id_clearline_counter
        M=M-1

        // Continue loop
        @id_clearline_LOOP
        0;JMP

    (id_clearline_RESET_CURSOR)
        // Reset cursor column to 0
        @cursorColumn
        M=0

        @numDigits
        M=0

(id_clearline_END)
    @return                 // Return to caller
    A=M
    0;JMP
