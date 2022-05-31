#################################################
#			 									#
#     	 	data segment						#
#												#
#################################################

	.data
    .align 0
endl: 					.asciiz 	"\n"
byte1:   .byte 0x6677, 0x05, 0x04, 0x03, 0x02, 0x01
byte2:   .byte 0x84, 0x83, 0x82, 0x81
byte3:   .byte 0x05
half:    .half 0x6677
word1:   .word 0x12345678
word2:   .word 0x87654321

#################################################
#												#
#				text segment					#
#												#
#################################################

	.text
	.globl __start	
												#read first int and move it to a temp reg
__start:
    
    ulw $t0, word1


    j Exit 
Exit:				li 		$v0, 10
					syscall				#au revoir...
