.section __TEXT, __text
#.text

.extern printf

.globl _sum

_sum:
    pushq %rbp
    movq %rsp, %rbp

    movq $0, %rax
    #addq %rbx, %rax
    #addq %rcx, %rax

    pushq $40
    addq $30, (%rsp)
    popq %rax

    leave
    ret
.end

.section __DATA, __data

