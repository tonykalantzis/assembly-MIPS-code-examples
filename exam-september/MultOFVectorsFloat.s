#################################################
#			 									#
#     	 	data segment						#
#												#
#################################################

	.data
endl: .asciiz 	"\n"
bye:  .asciiz "\nbye:)"
parenthesi1: .asciiz "[ "
parenthesi2: .asciiz " ]"
space: .asciiz " "
epi: .asciiz " * "
ison: .asciiz " = "

#some different examples to try out
#just uncomment the one and comment the previous
vector1: .byte 1, 2, 3, 4, 0, 1, 2, 3, 4, 0
vector2: .byte 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 #result 20

#vector1: .byte 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
#vector2: .byte 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 #result 10

#vector1: .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
#vector2: .byte 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 #result 0

#vector1: .byte 1, 0, 0, 0, 6, 0, 2, 3, 0, 4
#vector2: .byte 1, 0, 1, 2, 7, 1, 1, 1, 1, 1 #result 52

#################################################
#											#
#				text segment					#
#												#
#################################################

	.text
	.globl __start	
												#read first int and move it to a temp reg
__start:
#-----------PRINT THE VECTOR1-----------------------------------
		li $v0, 4
		la $a0, parenthesi1					
		syscall		

		la $s0, vector1	
		li $t0, 0  #counter 
		li $t9, 10	#when to stop counter 

loop1:  lbu $t1, 0($s0) #load the ("%d", $t0) character
		move $a0, $t1			
		li $v0, 1
		syscall

		addi $s0, $s0, 1 #next number 
		addi $t0, $t0, 1 #increase counter 
		beq $t0, $t9, exit_loop1
		li $v0, 4
		la $a0, space					
		syscall	
j loop1
exit_loop1: li $v0, 4
			la $a0, parenthesi2					
			syscall	

#-----------PRINT THE *---------------------------------------
	li $v0, 4
	la $a0, epi 				
	syscall	
#-----------PRINT THE VECTOR2---------------------------------
		li $v0, 4
		la $a0, parenthesi1					
		syscall		

		la $s0, vector2	
		li $t0, 0 
		li $t9, 10

loop2:  lbu $t1, 0($s0) #load the ("%d", $t0) character
		move $a0, $t1			
		li $v0, 1
		syscall

		addi $s0, $s0, 1 #next number
		addi $t0, $t0, 1 #increase counter
		beq $t0, $t9, exit_loop2
		li $v0, 4
		la $a0, space					
		syscall	
j loop2
exit_loop2: li $v0, 4
			la $a0, parenthesi2					
			syscall	
#------------------PRINT ISON---------------------------------
	li $v0, 4
	la $a0, ison 				
	syscall	
#------------------CALCULATE SUM------------------------------
	la $s0, vector1
	la $s1, vector2
	li $t0, 0
	li $t9, 10
	li $s5, 0 # $s5 is the sum 
loop3: lbu $t1, 0($s0)
	   lbu $t2, 0($s1)
	   mult $t1, $t2
	   mflo $t3 #t3 the final result! 
	   add $t5, $t5, $t3 

	   addi $s0, $s0, 1
	   addi $s1, $s1, 1
       addi $t0, $t0, 1 
	   beq $t0, $t9, exit_loop3
j loop3
exit_loop3: 
#-----------------PRINT SUM-----------------------------------
	move $a0, $t5 			
	li $v0, 1
	syscall
	j Exit
Exit:				la $a0, bye
                    li $v0, 4
	                syscall
                    li 		$v0, 10
					syscall				#au revoir...
