#################################################
#			 									#
#     	 	      data segment				    #
#												#
#################################################

	.data
    .align 0
bytes:  .byte 0x01,0x02,0x03,0x04,0x05,0x81,0x082,0x83,0x84
half:   .half 0x6677
words:  .word 0x12345678 , 0x87654321
#################################################
#												#
#				  text segment					#
#												#
#################################################
	.text
	.globl __start	
__start:
#-------------start of main program-------------#
    #la $s0, bytes
    #lw $t0, 12($s0)
    
    #la $s0, half
    #lh $t1, 0($s0)

    la $s0, bytes 
    ulh $t1, 9($s0)
    ulw $t2, 13($s0)
exit:   li 	$v0, 10
		syscall				#au revoir...
#-------------end of main program--------------#

#-------------start of procedures--------------#


#-------------end of procedures---------------#

