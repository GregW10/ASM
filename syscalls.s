#.text
.section __TEXT,__text

.globl _main

_main:
    pushq %rbp
    movq %rsp, %rbp

    subq $32, %rsp

    movq $0x02000004, %rax
    movq $1, %rdi
    leaq syscall_str(%rip), %rsi
    movq $25, %rdx
    syscall

    jc error

    xorq %rax, %rax

    leave
    ret

error:
    movq $1, %rax
    leave
    ret

#.data
.section __DATA,__data
syscall_str:
    .asciz "Printed with a syscall.\n"
