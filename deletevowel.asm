.data
full: .space 32
empty: .space 32
vowels: .asciz "aeiou"

.text
main:
jal fill
jal getsize
jal vowel

mv a0, s5
li a7, 4
ecall

j end

fill:
#max lenght to 32 char
li a1, 32
la a0, full
li a7, 8
ecall
#adress to s2
mv s2, a0
j return

getsize:
#initiate iterator and size
li s1, 0
#get \0 for comparison
li s0, '\n'
j getsize_loop

getsize_loop:
add t2, s2, s1
lb t3, 0(t2)
beq t3, s0, return
addi s1, s1, 1
j getsize_loop

vowel:
#initialize iterators
li t2, 0
li t3, 0
li t1, 0
#load vowels adress and size
la s3, vowels
li s4, 5
la s5, empty
j vowel_loop

vowel_loop:
#get chars
add t4, s2, t2
lb a2, 0(t4)
add t5, s3, t3
lb a3, 0(t5)
#if vowels are finished
beq t3, s4, insert
#checks
beq a2, a3, iterate_i
#iterates
addi t3, t3, 1
j vowel_loop

iterate_i:
addi t2, t2, 1
beq t2, s1, return
j vowel_loop

insert:
add t6, s5, t1
sb a2, 0(t6)
addi t1, t1, 1
j iterate_i

return:
ret

end:
