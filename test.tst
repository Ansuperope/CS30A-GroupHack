// template to make test file
load LOREM.asm
output-file LOREM.out,
compare-to LOREM.cmp,

// Set inputs
set RAM[0] 1
set RAM[1] 1
set RAM[2] 1
set RAM[3] 1
set RAM[4] 1
set RAM[5] 1
set RAM[6] 1
set RAM[7] 1
set RAM[8] 1
set RAM[9] 1
set RAM[10] 1
set RAM[11] 1
set RAM[12] 1
set RAM[13] 1
set RAM[14] 1

// how long program should run  - change if needed
repeat 100 {
  ticktock;
}

output;
