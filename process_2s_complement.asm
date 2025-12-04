// ==============================================
// ac_process_2s_complement
// flowchart: process_2s_complement
// ----------------------------------------------
// OVERVIEW
//  This function will preform the 2s complement:
//      1. it flips all the bits (done here)
//      2. adds 1 (done in process_add_binary)
// ----------------------------------------------
// DATA TABLE
//  Inputs (Receieve from input):
//      R0 ... R14      - binary values from input
//
//  Output (Send to process_add_binary):
//      NR0 ... NR14    - opposite binary values from input
// 
//  Variables:
//      N/A
// ==============================================
(ac_process_2s_complement)