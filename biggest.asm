.data

.text
main:
#set word number
li s0, 4
#functions
jal fill
jal biggest
#print biggest
li a7, 1
mv a0, a1
ecall
j end

fill:
#set array size
li a7, 5
ecall
mv s1, a0
#allocate array
mul a0, s0, s1
li a7, 9
ecall
mv s2, a0
#set to print and initiate iterator for the loop
li a7, 5
li t0, 0
j fill_loop

fill_loop:
beq t0, s1, return
#get distance
mul t1, t0, s0
add t1, t1, s2
#get and set number
ecall
sw a0, 0(t1)
#iterate
addi t0, t0, 1
j fill_loop

biggest:
#initialize iterator
li t1, 0
#set first as biggest (a1)
lw t2, 0(s2)
mv a1, t2
j biggest_loop

biggest_loop:
beq t1, s1, return
#get distance and store value
mul t3, t1, s0
add t3, t3, s2
lw t4, 0(t3)
#iterate
addi t1, t1, 1
#check
bge t4, a1, swap
j biggest_loop

swap:
mv a1, t4
j biggest_loop

return:
ret

end: