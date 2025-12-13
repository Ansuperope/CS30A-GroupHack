// === id_storeBitInR0toR15 =====================================================
// Author: Ivan Dibrova
// 
// Stores a binary digit (0 or 1) into registers R0-R15 based on cursor position
// ===========================================================================

// C++ PSEUDOCODE IMPLEMENTATION

// void id_storeBitInR0toR15(int bit, int cursorPosition) {
//     if (cursorPosition < 0 || cursorPosition > 15) {
//         return; // Invalid position, do nothing
//     }
//     
//     // R0 corresponds to position 0, R15 to position 15
//     registers[cursorPosition] = bit;
// }


//id_storeBitInR0toR15
(id_storeBitInR0toR15)
    // Validate cursor position (must be 0-15)
    @cursorColumn
    D=M
    
    // Check if position < 0
    @id_storeBit_END
    D;JLT                   // If negative, invalid - exit
    
    // Check if position > 15
    @16
    D=D-A                   // D = cursorColumn - 16
    @id_storeBit_END
    D;JGE                   // If >= 0 (position >= 16), invalid - exit

    // Calculate target register address (R0 + cursorColumn)
    @R0
    D=A                     // D = address of R0
    @cursorColumn
    D=D+M                   // D = R0 + cursorColumn
    
    @id_storeBit_targetAddr
    M=D                     // Store target address

    // Get the bit value to store
    @id_storeBit_bit
    D=M                     // D = bit value (0 or 1)

    // Store bit in target register
    @id_storeBit_targetAddr
    A=M                     // Go to target register address
    M=D                     // Store bit value

(id_storeBit_END)
    @return                 // Return to caller
    A=M
    0;JMP
