#################################################
#			 									#
#     	 	data segment						#
#												#
#################################################

	.data
endl: 					.asciiz 	"\n"
number1: .word 1073741823
#################################################
#												#
#				text segment					#
#												#
#################################################

	.text
	.globl __start	
												#read first int and move it to a temp reg
__start:
    li $t0, 0xffffffff #q1-> 0x3fffffff q2->0x7fffffff q3->0xffffffff
	li $t1, 0x1        #q1-> 0x3fffffff q2->0x7fffffff q3->0x1

	addu $t4, $t0, $t1
    add $t3, $t0, $t1 #exception here
		


Exit:				li 		$v0, 10
					syscall				#au revoir...



