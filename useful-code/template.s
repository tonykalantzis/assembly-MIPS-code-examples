#################################################
#			 									#
#     	 	      data segment				    #
#												#
#################################################

	.data
endl: 	.asciiz 	"\n"
#################################################
#												#
#				  text segment					#
#												#
#################################################
	.text
	.globl __start	
__start:
#-------------start of main program-------------#


Exit:   		li 	$v0, 10
				syscall				#au revoir...
#-------------end of main program--------------#

#-------------start of procedures--------------#
print_endl:			la	$a0,endl 			 
					li	$v0, 4 	#system call to print
					syscall
					jr $ra

#-------------end of procedures---------------#

