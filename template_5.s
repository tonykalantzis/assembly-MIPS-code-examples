#################################################
#			 									#
#     	 	data segment						#
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
#put immidiate in $t0 a binary number 
		


Exit:				li 		$v0, 10
					syscall				#au revoir...



