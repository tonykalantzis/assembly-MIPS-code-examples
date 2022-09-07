#################################################
#			 									#
#     	 	data segment						#
#												#
#################################################

	.data
endl: 					.asciiz 	"\n"
msg0: .asciiz "Total number of 0 = "
msg1: .asciiz "Total number of 1 = "
#################################################
#												#
#				text segment					#
#												#
#################################################

	.text
	.globl __start	
												#read first int and move it to a temp reg
__start:
loop:  
        li	 $v0, 6				#read float 
	    syscall
        mov.s $f1, $f0

		mov.s	$f12, $f1 	#print float		
		li $v0, 2
		syscall
		jal print_endl

		c.eq.s $f1, $f7 #if n = 0 exit case
		bc1t Exit 

		mfc1 $s0, $f1  #move fro float register to int register
		li $t0, 0 #how many 0 
		li $t1, 0 #how many 1
		li $t2, 0 #counter 
		li $t5, 32
		loop2:  addi $t2, $t2, 1 #counter ++
				andi $t3, $s0, 1 #check if the last digit is 1 
				
				if: bne $t3, $zero, else
					addi $t0, $t0, 1
					j end_if
				else: 
					addi $t1, $t1, 1
				end_if: 
					
				srl $s0, $s0, 1 

				beq $t2, $t5, exit_loop2  #when 32 loops	
		j loop2
		exit_loop2: 
	
		li $v0, 4
		la $a0, msg0					
		syscall
		move $a0, $t0			# print how many 0
		li $v0, 1
		syscall
		jal print_endl

		li $v0, 4
		la $a0, msg1					
		syscall
		move $a0, $t1			# print how many 1
		li $v0, 1
		syscall
		jal print_endl

j loop 


Exit:				li 		$v0, 10
					syscall				#au revoir...


print_endl:		la		$a0,endl 			# system call to print
					li		$v0, 4 				# out a newline
					syscall
					jr $ra