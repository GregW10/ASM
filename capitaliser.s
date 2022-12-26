.section __TEXT,__text

.globl _main
.globl _strlen_c
.globl _has_ext
.extern _malloc # I'm not quite ready to write my own malloc yet :P
.extern _free

# size_t strlen_c(const char *);
_strlen_c:
    pushq %rbp
    movq %rsp, %rbp

    cmpq $0, %rdi
    jnz rest

    movq $0x02000001, %rax
    movq $255, %rdi
    syscall

rest:
    xorq %rax, %rax

loop:
    cmpb $0, (%rdi, %rax)
    jz bye

    inc %rax
    jmp loop

bye:
    leave
    ret
########################
# int has_ext(const char *);
_has_ext:
    pushq %rbp
    movq %rsp, %rbp

    cmpq $0, %rdi
    jnz rest2

    movq $0x02000001, %rax
    movq $255, %rdi
    syscall

rest2:
    callq _strlen_c # string address is already in rdi

    cmp $0, %rax
    jz none # would be same as je here

    cmp $1, %rax
    jz none

    cmp $46, (%rdi)
    jnz continue
    incq %rdi # increment rdi if first char. is dot

continue:

    jmp bye2
none:
    xorl %eax, %eax
bye2:
    leave
    ret
########################
_main:
    pushq %rbp
    movq %rsp, %rbp

    subq $32, %rsp

    cmpq $2, %rdi
    jne argc_err

    movq $0x02000005, %rax
    movq 8(%rsi), %rdi
    movq O_RDONLY(%rip), %rsi
    syscall
    jc file_err

    cmp $0, %rax
    je file_err

    movq 8(%rsi), %rdi
    callq _strlen_c

    movq %rax, 8(%rbp)
    addq $7, 8(%rbp)
    movq 8(%rbp), %rdi
    callq _malloc

    movq %rax, 16(%rbp)

    movq $0x02000005, %rax
    movq 8(%rsi), %rdi
    movq O_WRONLY(%rip), %rsi
    orq O_TRUNC(%rip), %rsi
    orq O_CREAT(%rip), %rsi
    movq S_IRWXU(%rip), %rdx
    syscall
    jc file_err

    movq 16(%rbp), %rdi
    callq _free

    cmp $0, %rax
    je file_err



    xorq %rax, %rax
    jmp end
argc_err:
    movq $0x02000004, %rax
    movq $2, %rdi
    leaq argc_str(%rip), %rsi
    movq $20, %rdx
    syscall
    movq $1, %rax
    jmp end

file_err:
    movq $0x02000004, %rax
    movq $1, %rdi
    leaq file_str(%rip), %rsi
    movq $21, %rdx
    syscall

end:
    leave
    ret

.section __DATA,__data

argc_str:
    .asciz "File not provided.\n"

file_str:
    .asciz "Error opening file.\n"

O_CREAT:
    .quad 512

O_WRONLY:
    .quad 1

O_TRUNC:
    .quad 1024

S_IRWXU:
    .quad 448
