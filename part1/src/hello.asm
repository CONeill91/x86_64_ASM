; Instructions in the form [label:] instruction 

; refer to https://github.com/torvalds/linux/blob/master/arch/x86/entry/syscalls/syscall_64.tbl for sys call numbers

section .data ; .data section is used for declaring constants
    msg db      "hello, world!" ; constant

section .text ; .text section used for instructions
    global _start ; Specify where execution begins
_start
    mov rax, 1 ; 1 = sys_write
    mov rdi, 1 ; Standard out (fd)
    mov rsi, msg ; pointer to msg (*buf)
    mov rdx, 13 ; number of bytes to be written
    syscall ; execute the system call specified in rax 
    mov rax, 60 ; 60 = exit
    mov rdi, 0 ; exit code 0
    syscall ; execute the system call specified in rax 
        
    ; sys_write system call function prototype:
    ; size_t sys_write(unsigned int fd, const char *buf, size_t count);


; file descriptors(0 - Standard in, 1 - Standard out, 2 - Standard error)
; 
; * Register uses above *
; rax - temporary register; when we call a syscall, rax must contain syscall number
; rdi - used to pass 1st argument to functions
; rsi - pointer used to pass 2nd argument to functions
; rdx - used to pass 3rd argument to functions



