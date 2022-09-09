#################################################
#			 									#
#     	 	data segment						#
#												#
#################################################

	.data
endl: 					.asciiz 	"\n"
msg: .asciiz "POWER-SUM="
epi: .asciiz "*10^"
plus: .asciiz " + "
#################################################
#												#
#				text segment					#
#												#
#################################################

	.text
	.globl __start	
												#read first int and move it to a temp reg
__start:

start:
    li $t0, 1 
    li $t1, 0 #count of digits
    li $t2, 10
    li$v0, 5				# $v0 <--- integer
    li $k0, 0
	syscall
    move $t7, $v0
    beq $t7, $zero, Exit
                count_of_digits: 
                mult $t0, $t2
                mflo $t0
                addi $t1, 1
                blt $t0, $t7, count_of_digits 


    li $v0, 4
	la $a0, msg				# ??? --> label with string
	syscall


    loop:
        div $t0, $t0, $t2
        div $t5, $t7, $t0
        mfhi $t7
        
        move $a0, $t5			# ???  --> register with integer
		li $v0, 1
		syscall

        li $v0, 4
		la $a0, epi				# ??? --> label with string
		syscall

        addi $t1, $t1, -1
        move $a0, $t4			# ???  --> register with integer
		li $v0, 1
		syscall

        if: beq $t1, $k0, target 
            li $v0, 4
		    la $a0, plus			# ??? --> label with string
		    syscall
        target:
        
        bgtz $t1, loop

        la		$a0,endl 			# system call to print
	    li		$v0, 4 				# out a newline
		syscall

    j start
        
    
    

Exit:				li 		$v0, 10
					syscall				#au revoir...
