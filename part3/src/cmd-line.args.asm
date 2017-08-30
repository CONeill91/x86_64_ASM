section .data
            SYS_WRITE   equ 1
            STD_IN      equ 1
            SYS_EXIT    equ 60
            EXIT_CODE   equ 0

            NEW_LINE    db 0xa
            WRONG_ARGC  db "Must be two command line argument", 0xa

section .text
    global _start

_start:
    ; rcx = argc
    pop rcx
    ; check argc = 3
    cmp rcx, 3 ; programName, argv[0], argv[1]

    jne argcError

    add rsp, 8
    ;; get argv[1]
    pop rsi
    ;; convert argv[1] to an int
    call str_to_int
    ;; put first num in r10
    mov r10, rax
    ;; get argv[2]
    pop rsi
    ;; convert argv[2] to an int
    call str_to_int
    ;; put second num in r11
    mov r11, rax
    ;; add the two numbers
    add r10, r11
    ;; put result in rax
    mov rax, r10

    xor r12, r12 ; zero out
    ;; convert it back to a string
    jmp int_to_str

argcError:
    ;; sys_write syscall
    mov rax, 1
    ;; STD OUT ;; Define const for this
    mov rdi, 1

    mov rsi, WRONG_ARGC ;; * to error msg
    mov rdx, 34 ;; length of msg
    syscall
    jmp exit
    

str_to_int:
    xor rax, rax ;; zero out
    mov rcx, 10

next:
    cmp [rsi], byte 0
    je return_str
    mov bl, [rsi]
    sub bl, 48
    mul rcx
    add rax, rbx
    inc rsi
    jmp next

return_str:
    ret

int_to_str:
    mov rdx, 0
    mov rbx, 10
    div rbx
    add rdx, 48
    add rdx, 0x0
    push rdx
    inc r12
    cmp rax, 0x0
    jne int_to_str
    jmp print

print:
    mov rax, 1
    mul r12
    mov r12, 8
    mul r12
    mov rdx, rax

    ;;; print sum
    mov rax, SYS_WRITE
    mov rdi, 1 ;; STD Out
    mov rsi, rsp
    ;; call sys_write
    syscall

    jmp printNL

printNL:
    mov rax, SYS_WRITE
    mov rdi, 1
    mov rsi, NEW_LINE
    mov rdx, 1
    syscall
    jmp exit

exit:
    mov rax, SYS_EXIT
    ;; exit code zero
    mov rdi, EXIT_CODE
    syscall


