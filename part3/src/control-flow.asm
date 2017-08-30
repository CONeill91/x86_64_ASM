; Simple control flow illustration

global _start

section .text

_start:
        mov rax, 0 
        call incRax
        cmp rax, 2
        jne exit
        mov rax, 60 ; 60 = exit
        mov rdi, 1 ; exit code 0
        syscall ; execute the system call specified in rax

incRax:
        inc rax
        ret

exit:
        mov rax, 60 ; 60 = exit
        mov rdi, 0 ; exit code 0
        syscall ; execute the system call specified in rax
