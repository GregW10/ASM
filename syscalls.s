#.text
.section __TEXT,__text

.globl _main

_main:
    pushq %rbp
    movq %rsp, %rbp

    subq $32, %rsp

    movq $0x20000004, %rax
    movq $1, %rdi
    leaq syscall_str(%rip), %rsi
    movq $25, %rdx
    syscall

    xorq %rax, %rax

    leave
    ret

.data
syscall_str:
    .asciz "Printed with a syscall.\n"
