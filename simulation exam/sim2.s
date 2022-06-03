#################################################
#			 									#
#     	 	data segment						#
#												#
#################################################

	.data
endl: 					.asciiz 	"\n"
str: .space 5
#################################################
#												#
#				text segment					#
#												#
#################################################

	.text
	.globl __start	
												#read first int and move it to a temp reg
__start:
read_str:		li $v0, 8					# code to read a string
				la $a0, str					# ??? --> label with string
				li $a1, 5					# n chars --> $a1=n+1 eg: (20+1)--> li $a1, 21
				syscall
				

print_str:		li $v0, 4
				la $a0, str					# ??? --> label with string
				syscall
				

Exit:				li 		$v0, 10
					syscall				#au revoir...