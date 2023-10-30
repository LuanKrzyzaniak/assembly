.data
vetor: .word 3,9,2,7,-5,3, 8
tamanho: .word 7
n: .ascii "\n"

.text
j main

end:
ret

bubble_sort:
#iterate j and j+1, then checks
addi s1, s1, 4
addi s2, s2, 4
bge s2, s0, iterate_i
lw t0, 0(s1)
lw t1, 0(s2)
bgt t0, t1, swap
j bubble_sort

iterate_i:
#iterate i
addi s0, s0, -4
addi s1, a0, -4
mv s2, a0
beq s0, a0 ,end
j bubble_sort

swap:
#load word into temp, and save temp into adress
sw t0, 0(s2)
sw t1, 0(s1)
j bubble_sort

print_setup:
#load array adress(t0), \n (t1), array size (a1), and initialize i (a2)
mv t0, a0
la t1, n
la t2, tamanho
li t3, 4
lw a1, 0(t2)
li a2, 0
j print

print:
addi a2, a2, 1
blt a2, a1, printing
j end

printing:
mul t3, a1, t3

li a7, 4
mv a0, t1
ecall
li a7, 1
add t0, t0, t3
lw a0, 0(t0)
ecall

j print


main:
#initialize vector and size
la a0, vetor
la t0, tamanho
lw a1, 0(t0)

#initialize i, j and temp(j+1) for bubble sort
li t0, 4
mul t1, a1, t0
add s0, a0, t1
addi s1, a0, -4
mv s2, a0

#call bubble sort
jal bubble_sort

#call print
jal print_setup