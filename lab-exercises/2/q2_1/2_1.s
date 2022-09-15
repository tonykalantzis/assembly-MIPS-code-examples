#################################################
#			 									#
#     	 	      data segment				    #
#												#
#################################################

	.data
endl: 	.asciiz 	"\n"
bits:   .word 0x01
#################################################
#												#
#				  text segment					#
#												#
#################################################
	.text
	.globl __start	
__start:
#-------------start of main program-------------#
   la $s0, bits
   li $s1,8
gray:       lbu $t1,0($s0)
            lbu $t2,1($s0)
            xor $t3,$t1,$t2
            sb $t3, 0($s0)
            addi $s0,$s0,1
            bne $s0,$s1, gray

exit:   li 	$v0, 10
		syscall				#au revoir...
#-------------end of main program--------------#

#-------------start of procedures--------------#


#-------------end of procedures---------------#

