.text

.globl _main
.extern _printf
.extern _sleep
.extern _putchar

_main:
    pushq %rbp
    movq %rsp, %rbp

    movq $67, %rdi
        callq _putchar

    subq $8, %rsp
    #addq $8, %rsp



    movq $10, (%rsp)

while:
    leaq counter_str(%rip), %rdi
    movq (%rsp), %rsi
    xorq %rax, %rax
    callq _printf
    movq $1, %rdi
    callq _sleep

    decq 0(%rsp)
    jnz while

    addq $8, %rsp

    leaq done_str(%rip), %rdi
    callq _printf

    movq $0, %rax

    leave
    retq

counter_str:
    .asciz "Counter value: %zu\n"

done_str:
    .asciz "Done!\n"
