#################################################
#			 									#
#     	 	data segment						#
#												#
#################################################

	.data
endl: 					.asciiz 	"\n"
bye: .asciiz "bye:)"
#################################################
#												#
#				text segment					#
#												#
#################################################

	.text
	.globl __start	
												#read first int and move it to a temp reg
__start:


Exit:				la $a0, bye
                    li $v0, 4
	                syscall
                    li 		$v0, 10
					syscall				#au revoir...
