#################################################
#			 									#
#     	 	data segment						#
#												#
#################################################

	.data
endl: 					.asciiz 	"\n"
m: .asciiz "0123456789"
n: .asciiz "abcdefghij"
#################################################
#												#
#				text segment					#
#												#
#################################################

	.text
	.globl __start	
												#read first int and move it to a temp reg
__start:

    la $s0, m
    la $s1, n

    li $t0, 0
    li $t1, 10

loop:   lbu $t2, 0($s0) #get 1st,2nd, ... character of m
        li $v0, 11
	    move $a0, $t2			
	    syscall
        addi $s0, $s0, 1 

        lbu $t3, 0($s1) #get 1st,2nd, ... character of n
        li $v0, 11
	    move $a0, $t3			
	    syscall
        addi $s1, $s1, 1

        addi $t0, $t0, 1

        beq $t0, $t1, Exit

j loop


Exit:				li 		$v0, 10
					syscall				#au revoir...