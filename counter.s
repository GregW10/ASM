.text

.globl _main
.extern _printf
.extern _sleep
.extern _putchar

_main:
    pushq %rbp
    movq %rsp, %rbp

    subq $40, %rsp

    movq $67, %rdi
    #callq _putchar

    addq $40, %rsp

    #subq $8, %rsp
    #addq $8, %rsp



    movq $10, (%rsp)

while:
    leaq counter_str(%rip), %rdi
    movq (%rsp), %rsi
    xorq %rax, %rax
    subq $40, %rsp
    callq _printf
    addq $40, %rsp
    movq $1, %rdi
    subq $40, %rsp
    callq _sleep
    addq $40, %rsp

    decq 0(%rsp)
    jnz while

    #addq $8, %rsp

    leaq done_str(%rip), %rdi
    subq $40, %rsp
    callq _printf
    subq $40, %rsp

    movq $0, %rax

    leave
    retq

counter_str:
    .asciz "Counter value: %zu\n"

done_str:
    .asciz "Done!\n"
