// === id_moveCursorRight =======================================================
// Author: Ivan Dibrova
// 
// Moves cursor right with boundary checking
// Ensures cursor never goes > 15 during input
// Used when user enters a valid bit (0 or 1) to advance to next position
// ===========================================================================

// C++ PSEUDOCODE IMPLEMENTATION

// void id_moveCursorRight() {
//     if (cursorColumn < 15) {
//         cursorColumn++;
//         ge_currentColumn = cursorColumn;
//     }
// }

//id_moveCursorRight
(id_moveCursorRight)
    // Check if cursor is already at rightmost position (15)
    @cursorColumn
    D=M
    @15
    D=D-A                   // D = cursorColumn - 15
    @id_moveCursorRight_END
    D;JGE                   // If cursorColumn >= 15, can't move right

    // Move cursor right
    @cursorColumn
    M=M+1                   // cursorColumn++

    // Update ge_currentColumn for output functions
    @cursorColumn
    D=M
    @ge_currentColumn
    M=D

(id_moveCursorRight_END)
    @return                 // Return to caller
    A=M
    0;JMP
