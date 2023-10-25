.data
big: .word 0
small: .word 0
average: .word 0
ammount: .word 0
bigmes: .asciz "\nBigger: "
smallmes: .asciz "\nSmaller: "
averagemes: .asciz "\nAverage: "

.text
la t0, big
lw s0, 0(t0)
la t0, small
lw s1, 0(t0)
la t0, average
lw s2, 0(t0)
la t0, ammount
lw s3, 0(t0)

start:
li a7, 5
ecall
bgt zero, a0, end
add s0, zero, a0
add s1, zero, a0
j checks

loop:
ecall
j checks

checks:
bgt zero, a0, end
bgt a0, s0, bigger
blt a0, s1, smaller
addi s3, s3, 1
add s2, s2, a0
j loop

bigger:
add s0, zero, a0
j checks

smaller:
add s1, zero, a0
j checks

end:
li a7, 4
la a0, bigmes
ecall

li a7, 1
add a0, zero, s0
ecall

li a7, 4
la a0, smallmes
ecall

li a7, 1
add a0, zero, s1
ecall

li a7, 4
la a0, averagemes
ecall

li a7, 1
div s2, s2, s3
add a0, zero, s2
ecall
