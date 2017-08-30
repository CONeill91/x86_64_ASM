; Not actually alot to do w/ the stack except the usage of the push instruction
; and the use of stackpointer offset

global _start

section .text

_start:
    mov rax, 1
    mov rdx, 2
    push rax
    push rdx

    mov rax, [rsp + 8]
    
    jmp exit

exit:
    mov rax, 60
    mov rdi, 7
    syscall
