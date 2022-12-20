.text

.globl _main
.globl _strlen_c
.extern _printf

_main:
    pushq %rbp
    movq %rsp, %rbp

    xorb %al, %al # %al is used to store number of f.p. args passed to _printf
    #movabsq $message, %rdi
    xorq %rcx, %rcx
    lea message(%rip), %rdi
    lea 0(%rip), %rsi
    call _printf

    lea message(%rip), %rdi
    call _strlen_c

    lea length(%rip), %rdi
    movq %rax, %rsi
    call _printf

    movq $0, %rax

    leave
    ret

_strlen_c:
    pushq %rbp
    movq %rsp, %rbp

    subq $8, %rsp

    xorq %rax, %rax

    cmp $0, %rdi
    je end

    xorq %rcx, %rcx

repeat:
    cmpb $0, (%rdi, %rcx)
    je end
    addq $1, %rax
    addq $1, %rcx
    jmp repeat
end:
    addq $8, %rsp
    leave
    ret

.data

message:
    .string "Hello, world! %p\n"

length:
    .string "String length: %zu\n"

.end
