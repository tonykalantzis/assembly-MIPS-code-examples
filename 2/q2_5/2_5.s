#################################################
#			 									#
#     	 	data segment						#
#												#
#################################################

	.data
endl: 					.asciiz 	"\n"
nums: .word 0xffffffff, 0xffffffff
#################################################
#												#
#				text segment					#
#												#
#################################################

	.text
	.globl __start	
												#read first int and move it to a temp reg
__start:
    
    lw $t0, nums + 0
    lw $t1, nums + 4

    addu $t2, $t0, $t1

    # Ci+1 = Si'Ai + Si'Bi + AiBi
    xori $t3, $t2, 1
    and $t4, $t3, $t0
    and $t5, $t3, $t1
    and $t6, $t0, $t1

    # $t3 is C32
    or $t3, $t4, $t5
    or $t3, $t3, $t6

    srl $t3, $t3, 31
	
	j Exit

Exit:				li 		$v0, 10
					syscall				#au revoir...
