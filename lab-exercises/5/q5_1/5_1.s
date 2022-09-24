#################################################
#			 									#
#     	 	    data segment					#
#												#
#################################################

	.data
endl: 					.asciiz 	"\n"

#################################################
#												#
#				text segment					#
#												#
#################################################

	.text
	.globl __start	
												#read first int and move it to a temp reg
__start:
read_float:		li	$v0, 6				# $f0 <--- float
				syscall
                j print_float_from_reg

print_float_from_reg:	mov.s	$f12, $f0			# ???  --> FP register with float
					    li $v0, 2
					    syscall
					j Exit

Exit:				li 		$v0, 10
					syscall				#au revoir...

#################################################
#                                               #
#               End of program                  #
#                                               #
#################################################