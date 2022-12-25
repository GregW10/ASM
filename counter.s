#.text
.section __TEXT, __text

.globl _main
.extern _printf
.extern _sleep
.extern _putchar

_main:
    pushq %rbp
    movq %rsp, %rbp

    subq $32, %rsp # allocating shadow store

    movq $67, %rdi
    callq _putchar

    movq $10, %rdi
    callq _putchar

    movq $10, 32(%rsp)

while:
    leaq counter_str(%rip), %rdi
    movq 32(%rsp), %rsi
    xorb %al, %al
    callq _printf
    movq $1, %rdi
    callq _sleep
    decq 32(%rsp)
    jnz while

    leaq done_str(%rip), %rdi
    xorb %al, %al
    callq _printf

    xorq %rax, %rax

    movq %rbp, %rsp
    popq %rbp
    #leave
    retq

.data
counter_str:
    .asciz "Counter value: %zu\n"

done_str:
    .asciz "Done\n"

dec_str:
    .asciz "%zu\n"
