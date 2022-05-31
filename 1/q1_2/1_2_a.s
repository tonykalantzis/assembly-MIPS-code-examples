#################################################
#			 									#
#     	 	data segment						#
#												#
#################################################

	.data
endl: 					.asciiz 	"\n"
byte1:   .byte 0x04, 0x03, 0x02, 0x01
byte2:   .byte 0x84, 0x83, 0x82, 0x81
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
    lb $t0, byte1 + 3
    lb $t1, byte1 + 2
    lb $t2, byte1 + 1
    lb $t3, byte1
    sb $t0, 0x10010000
    sb $t1, 0x10010001
    sb $t2, 0x10010002
    sb $t3, 0x10010003

    lb $t0, byte2 + 3
    lb $t1, byte2 + 2
    lb $t2, byte2 + 1
    lb $t3, byte2
    sb $t0, 0x10010004
    sb $t1, 0x10010005
    sb $t2, 0x10010006
    sb $t3, 0x10010007

    lw $t0, word1
    sw $t0, 0x10010008

    lw $t0, word2
    sw $t0, 0x1001000c
    j Exit
    
Exit:				li 		$v0, 10
					syscall				#au revoir...