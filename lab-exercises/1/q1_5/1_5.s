#################################################
#			 									#
#     	 	data segment						#
#												#
#################################################

	.data
endl: 					.asciiz 	"\n"
str: .space 21
#################################################
#												#
#				text segment					#
#												#
#################################################

	.text
	.globl __start	
												#read first int and move it to a temp reg
__start:
read_int:			li		$v0, 5				# $v0 <--- integer
					syscall
					addi $t0, $v0, 0

print_int_from_reg:	move $a0, $t0 			# ???  --> register with integer
					li $v0, 1
					syscall
		           
Exit:   			li $v0, 10
					syscall				#au revoir...


