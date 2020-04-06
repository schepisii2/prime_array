.data
	arr: .space 100
.text
.globl main

main:
li $v0, 4 
la $a0, prompt1 # prompt user
syscall

li $v0, 5 
syscall

move $a1, $v0 # $a1 = max_value

jal prime_array
jal array_print
j exit

prime_array:
addi $t0, $0, 2 #loop counter
add $t3, $0, $0 #array offset
add $a2, $0, $0 #num of primes
loop:
beq $t0, $a1, done
addi $t1, $0, 2 #check counter
j check
next:
addi $t0, $t0, 1
j loop

check:
beq $t0, $t1, is_prime
div $t0, $t1
mfhi $t2
beq $t2, $0, next
addi $t1, $t1, 1
j check

is_prime:
sw $t0, arr($t3)
addi $t3, $t3, 4
addi $a2, $a2, 1
j next

array_print:
add $t0, $0, $0 #for counter
add $t1, $0, $0 #array offset
for:
beq $t0, $a2, done

li $v0, 1
move $a0, $t0
syscall
li $v0, 4
la $a0, colon
syscall

li $v0, 1
lw $a0, arr($t1)
syscall
li $v0, 4
la $a0, space
syscall

addi $t0, $t0, 1
addi $t1, $t1, 4
j for

done:
jr $ra

exit:
#exit
end: li $v0, 10 
syscall 
 
.data
prompt1:
 .asciiz "Enter a positive integer:  "
colon:
 .asciiz ":"
space:
 .asciiz "\n"