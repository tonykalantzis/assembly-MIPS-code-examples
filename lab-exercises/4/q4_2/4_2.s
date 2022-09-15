#################################################
#			 									#
#     	 	data segment						#
#												#
#################################################
	.data
prompt: .asciiz "Enter integer number: "
endl: .asciiz "\n"
#################################################
#												#
#				text segment					#
#												#
#################################################

	.text
	.globl __start									
__start:
# start of main program
 la $a0,prompt
 li $v0,4
 syscall # display "Enter integer number :"
 li $v0,5
 syscall # read integer
 move $t0,$v0  # $t0 -> integer
 la $a0,endl
 li $v0,4
 syscall # display end of line
 move $a0,$t0   #a0 -> integer

 jal rec
 
 li $v0,10
 syscall # exit
# end of main program
# start of procedure
rec:
	addi $sp, -4
	sw $ra, 0($sp)
	
	li $v0, 1	# print the integer
	syscall
	
	move $t1, $a0
	la $a0, endl	#new line
	li $v0, 4
	syscall
	
	move $a0, $t1
	
	beq $a0, $zero, end
	
	l1:
		addi $a0, -1
		jal rec
	
	end:
		lw $ra, 0($sp)
		addi $sp, 4
		jr $ra
		
# end of procedure

print_endl:	la	$a0,endl 			# system call to print
				li	$v0, 4 				# out a newline
				syscall
				jr $ra

printInt:	li $v0, 1
			syscall
			jr $ra