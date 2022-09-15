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
#s0->byte0,s1->byte 1,s2->byte2, s3->byte3
	#apotelesma ->s4
	li $a0, 0x12345678

	srl $s0, $a0,24

	sll $s3, $a0, 24

	#1st case with shift
	#2nd case with mask
	andi $s2,$a0, 0xff00
	sll $s2,$s2, 8

	li $t0,0xff0000
	and $s1,$a0,$t0
	sll $s1,$s1,8

	or $s4, $s0, $s1
	or $s4, $s4, $s2
	or $s4,$s4,$s3
	
	li $v0, 0xa   # 10
	syscall 		# au revoir...
	

Exit:   		li 	$v0, 10
				syscall				#au revoir...
#-------------end of main program--------------#

#-------------start of procedures--------------#
print_endl:			la	$a0,endl 			 
					li	$v0, 4 	#system call to print
					syscall
					jr $ra

#-------------end of procedures---------------#
