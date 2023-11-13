.data
four: .word 4

.text
j main

return:
ret

allocate:
# fill vectors size
li a7, 5
ecall
add s3, a0, zero

# allocate memory for both vectors
mul a0, s3, s4
li a7, 9
ecall
add s0, a0, zero
mul a0, s3, s4
li a7, 9
ecall
add s1, a0, zero
mul a0, s3, s4
li a7, 9
ecall
add s2, a0, zero
ret

fill:
bge t1, s3, return

mul t2, t1, s4
add t3, t0, t2
li a7, 5
ecall
sw a0, 0(t3)

addi t1, t1, 1
j fill

compare:
bge t2, s3, return

lw t0, 0(s0)
lw t1, 0(s1)

addi t2, t2, 1
add s0, s0, s4
add s1, s1, s4

bgt t0, t1, bigger
beq t0, t1, equal
j smaller

bigger:
li t4, 1
sw t4, 0(s2)
add s2, s2, s4
j compare

equal:
li t4, 0
sw t4, 0(s2)
add s2, s2, s4
j compare

smaller:
li t4, -1
sw t4, 0(s2)
add s2, s2, s4
j compare

printing:
beq t2, s3, return

lw a0, 0(s2)
ecall

addi t2, t2, 1
add s2, s2, s4
j printing

main:
#store four
la t0, four
lw, s4, 0(t0)

#allocate dinamically
jal allocate
add a1, s0, zero

#fill it
li t1, 0
mv t0, s0
jal fill
li t1, 0
mv t0, s1
jal fill

#comparing
li t2, 0
jal compare

#printing
mul t4, s4, s3
sub s2, s2, t4
li t2, 0

li a7, 1
jal printing