.text

.globl _main
.globl _print_argv
.globl _here
.extern _printf
.extern _fprintf
.extern _putchar
.extern _sleep

_main:
    pushq %rbp
    movq %rsp, %rbp

    pushq %rdi
    pushq %rsi

    xorb %al, %al

    movq 8(%rsp), %rsi
    lea string(%rip), %rdi
    movq $20, %rdx
    movq $30, %rcx
    movq $40, %r8
    movq $50, %r9
    subq $40, %rsp
    pushq $60
    callq _printf
    addq $48, %rsp

    xorb %al, %al

    leaq argv_msg(%rip), %rdi
    callq _printf

    popq %rsi
    popq %rdi

    callq _print_argv

    leave
    retq

_print_argv:
    pushq %rbp
    movq %rsp, %rbp

    subq $8, %rsp

    xorb %al, %al

    xorq $0, %rdi
    jz error

    xorq $0, %rsi
    jz error

    xorq %rcx, %rcx

    movq $0xa, %rcx
    callq _here
    movq $10, 8(%rsp)
while:
    # movq (%rsi), %rdi
    #callq _printf
    #addq $8, %rsi
    #movq $10, %rdi
    #callq _here
    #callq _putchar
    leaq num_str(%rip), %rdi
    movq 8(%rsp), %rsi
    callq _printf
    movq $1, %rdi
    callq _sleep
    decq 8(%rsp)
    jnz while

    addq $8, %rsp

    jmp bye
error:
    movq $2, %rdi
    leaq error_str(%rip), %rsi
    callq _fprintf
    int $1
bye:
    leave
    retq

_here:
    pushq %rbp
    movq %rsp, %rbp

    #pushq %rdi

    xorb %al, %al

    leaq here_str(%rip), %rdi
    callq _printf

    #popq %rdi

    leave
    retq

.data

string:
    .asciz "argc: %d, nums: %d %d %d %d %d\n"

error_str:
    .asciz "argc value cannot be zero and argv must not be NULL.\n"

argv_msg:
    .asciz "All command-line arguments:\n"

here_str:
    .asciz "Here?????\n"

num_str:
    .asciz "Number: %ld\n"