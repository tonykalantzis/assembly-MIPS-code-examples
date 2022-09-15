#################################################
#			 									#
#     	 	data segment						#
#												#
#################################################

	.data
endl: 					.asciiz 	"\n"
enter: .asciiz "Enter an integer:\n"
msg1: .asciiz "\nIs divided with 2.\n"
msg2: .asciiz "\nIs divided with 3.\n"
msg3: .asciiz "\nIs divided with 5.\n"
msg4: .asciiz "\nIs not divided with 2, 3 or 5.\n"
#################################################
#												#
#				text segment					#
#												#
#################################################

	.text
	.globl __start	
												#read first int and move it to a temp reg
__start:
	li $v0, 4
	la $a0, enter	# display "enter an integer:"
	syscall
    
read_int:			li	$v0, 5				# $v0 <--- integer
					syscall
					move $t0 , $v0
					j print_int_from_reg

print_int_from_reg:	move $a0, $t0			# ???  --> register with integer
					li $v0, 1
					syscall
                    j switch_case_no_break

switch_case_no_break:   li $t9 , 0
    					li $t8 , 0
						li $t2 , 2
						li $t3 , 3
						li $t5 , 5
		case01:			div $t0 , $t2 
						mfhi $t1 	
						bne $t1 , $zero ,case02
		if_case01:		li $v0, 4
						la $a0, msg1					
						syscall
                        li $t9, 1
						j Exit
						
		case02:         div $t0 , $t3 
						mfhi $t1 
						bne $t1 , $zero , case03
		if_case02:		li $v0, 4
						la $a0, msg2					
						syscall
                        li $t9, 1	
						j Exit					

		case03:         div $t0 , $t5 
						mfhi $t1 
						bne $t1 , $zero , Exit
		if_case03:		li $v0, 4
						la $a0, msg3					
						syscall
                        li $t9, 1
								
		else_case:		bne $t9 , $t8 , Exit 	
                        li $v0, 4
						la $a0, msg4					
						syscall
		
        j Exit	

Exit:				li 		$v0, 10
					syscall				#au revoir...



