// === id_moveCursorLeft ========================================================
// Author: Ivan Dibrova
// 
// Moves cursor left with boundary checking
// Ensures cursor never goes < 0 during input
// Used when user presses backspace to delete previous bit
// ===========================================================================

// C++ PSEUDOCODE IMPLEMENTATION

// void id_moveCursorLeft() {
//     ** Move cursor left with boundary check **
//     if (cursorColumn > 0) {
//         cursorColumn--;
//         ge_currentColumn = cursorColumn;  // Update for ge_output
//     }
// }

//id_moveCursorLeft
(id_moveCursorLeft)
    // Check if cursor is already at leftmost position (0)
    @cursorColumn
    D=M
    @id_moveCursorLeft_END
    D;JLE                   // If cursorColumn <= 0, can't move left

    // Move cursor left
    @cursorColumn
    M=M-1                   // cursorColumn--

    // Update ge_currentColumn for output functions
    @cursorColumn
    D=M
    @ge_currentColumn
    M=D

(id_moveCursorLeft_END)
    @return                 // Return to caller
    A=M
    0;JMP
