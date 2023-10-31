.data
n: .ascii "\n"

.text
j main

vector_fill:
#load vector size to a1 and starting vector to a3
li a7, 5
ecall
#save vector size to s1
add s1, a0, zero
#alocate memory dinamically to s2
mul t1, s1, s0
add a0, t1, zero 
li a7, 9
ecall
add s2, a0, zero
#initialize iterator
li t1, 0
j vector_loop

vector_loop:
blt t1, s1, fill
j end

fill:
li a7, 5
ecall
#fill t2 with distance from vector to number
mul t2, t1, s0
#new adress - a3
add a3, t2, s2
#save number to a3
sw a0, 0(a3)
#iterate t1
addi t1, t1, 1
j vector_loop 

bubble_sort:
#iterate j and j+1, then checks
addi a2, a2, 4
addi a3, a3, 4
bge a3, a1, iterate_i
lw t0, 0(a2)
lw t1, 0(a3)
bgt t0, t1, swap
j bubble_sort

iterate_i:
#iterate i
addi a1, a1, -4
addi a2, s2, -4
mv a3, s2
beq a1, s2 ,end
j bubble_sort

swap:
#load word into temp, and save temp into adress
sw t0, 0(a3)
sw t1, 0(a2)
j bubble_sort


end:
#return
ret

print_setup:
#load array adress(t0), \n (t1), array size (t2), and initialize i (a2)
mv t0,s2
la t1, n
mv t2,s1
li t3, 0
j print

print:
blt t3, t2, printing
j end

printing:
#calc distance (t4) from initial adress to the next number
mul t4, s0, t3
add t4, t4, s2

#print \n
li a7, 4
mv a0, t1
ecall

#print number
li a7, 1
lw a0, 0(t4)
ecall

addi t3, t3, 1

j print

main:
#initialize word size (t0) 
li s0, 4

#fill vector
jal vector_fill

#initialize i, j and temp(j+1) for bubble sort
mul t1, s1, s0
add a1, s2, t1
addi a2, s2, -4
mv a3, s2

#call bubble sort
jal bubble_sort

#call print
jal print_setup
