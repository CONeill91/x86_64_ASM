section .data
            SYS_WRITE   equ 1 ; system call number
            STD_OUT     equ 1 ; standard out FD number
            SYS_EXIT    equ 60 ; system call number
            EXIT_CODE   equ 0 ; exit code

            NEW_LINE    db 0xa
            INPUT       db "Hello World!" ; string to reverse

section .bss
            ;; Where we will place the result of the reversal
            OUTPUT resb 12

section .text
            global _start

_start:
            ;; move address of INPUT into rsi
            mov rsi, INPUT
            ;; zero out rcx
            xor rcx, rcx
            ;; Reset df flag to zero // todo lookup df
            cld
            ;; //  $
            mov rdi, $ + 15
            call calculateStrLength
            xor rax, rax
            xor rdi, rdi
            jmp reverseStr

;; Length of string will be in rcx when function finishes
calculateStrLength:
            ;; check for null byte (end of string) at the address pointed to by rsi;
            cmp byte [rsi], 0
            ;; if yes exit from fn()
            je exitFromRoutine
            ;; load byte from rsi & inc rsi
            lodsb
            ;; push symbol onto stack
            push rax
            ;; inc rax
            inc rcx
            ;; loop
            jmp calculateStrLength

exitFromRoutine:
            push rdi
            ret ;; resume execution in _start;

reverseStr:
            cmp rcx, 0
            je printResult
            pop rax
            mov [OUTPUT + rdi], rax
            dec rcx
            inc rdi
            jmp reverseStr

printResult:
            mov rdx, rdi
            mov rax, 1 ;; sys_write
            mov rdi, 1 ;; fd std out
            mov rsi, OUTPUT
            syscall
            jmp printNL

printNL:
            mov rax, SYS_WRITE
            mov rdi, STD_OUT
            mov rsi, NEW_LINE
            mov rdx, 1
            syscall
            jmp exit

exit:
            mov rax, SYS_EXIT
            mov rdi, EXIT_CODE
            syscall
