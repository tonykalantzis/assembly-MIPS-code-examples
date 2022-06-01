#################################################
#			 									#
#     	 	data segment						#
#												#
#################################################

	.data
endl: 					.asciiz 	"\n"
test: .word 0x12345678

#################################################
#												#
#				text segment					#
#												#
#################################################

	.text
	.globl __start	
												#read first int and move it to a temp reg
__start:
		
		li $s5, 0x11223344
		
		srl $t0, $s5, 24   #isolation of byte 0 

		sll $t1, $s5, 8    #isolation of byte 1
		srl $t1, $t1, 24
		sll $t1, $t1, 8

		sll $t2, $s5, 16   #isolation of byte 2
		srl $t2, $t2, 24
		sll $t2, $t2, 16

		sll $t3, $s5, 24   #isolation of byte 3

		or $s0, $t0, $t1
		or $s1, $t2, $t3
		or $s2, $s1, $s0  #result is in $s2
	
		j Exit
Exit:				li 		$v0, 10
					syscall				#au revoir...

