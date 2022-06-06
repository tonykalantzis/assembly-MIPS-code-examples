#################################################
#			 									#
#     	 	data segment						#
#												#
#################################################

	.data
endl: 					.asciiz 	"\n"
word1: .word 0x11001011
word2: .word 0x11010010 
#################################################
#												#
#				text segment					#
#												#
#################################################

	.text
	.globl __start	
												#read first int and move it to a temp reg
__start:
li $s0, 0 #distance calculator
li $s1, 1 #counter 
li $s2, 32
sw $t8, word1
sw $t9, word2
la $t0, word1
la $t1, word2

loop:
    lb $t2, word1 
    lb $t3, word2
    xor $t4, $t2, $t3
    add $s0, $s0, $t4
    srl $t8, $t8, 1
    srl $t9, $t9, 1
    addi $s1, 1
    ble $s1, $s2, loop

Exit:				li 		$v0, 10
					syscall				#au revoir...



