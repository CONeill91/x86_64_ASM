https://0xax.github.io/asm_3/

Getting return code of a process:
    echo $?

Compilation command
    nasm -f elf64 -o <filename.o> <filename.asm>
    ld -o <executable-name> <filename.o>

#################
## Terminology ##
#################


#######################
## Assembly Sections ##
#######################
.data section
    - declaring initialised data / constants
.bss section
    - declaring uninitialised data / constant
.text section
    - for instructions
###############
## Registers ##
###############

16 GPRs - rax, rbx, rcx, rdx, rbp, rsp, rsi, rdi, r8, r9, r10, r11, r12, r13, r14, r15

################
## Data Types ##
################

byte - 8 bits
word - 2 bytes
doubleword - 4 bytes
quadword - 8 bytes
doubleword - 16 bytes

#####################################
## Passing parameters to functions ##
#####################################
Registers used:
    rdi - 1st arg
    rsi - 2nd arg
    rdx - 3rd arg
    rcx - 4th arg
    r8  - 5th arg
    r9  - 6th arg



Data
