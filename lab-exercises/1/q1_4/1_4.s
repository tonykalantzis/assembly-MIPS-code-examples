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

			
			li $v0, 8					# code to read a string
			li $a1, 21					# n chars --> $a1=n+1 eg: (20+1)--> li $a1, 21
			la $a0, str					# ??? --> label with string			
			syscall
            
			li $v0, 4
			syscall

			la	$a0,endl 			# system call to print
			li	$v0, 4 				# out a newline
			syscall

			la $a0, str
            sb $zero, str + 5
            syscall
            
            
					li 		$v0, 10
					syscall				#au revoir...
