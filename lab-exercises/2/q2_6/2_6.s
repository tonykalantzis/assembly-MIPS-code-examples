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
    
    # A: $t1 & $t0
    lw $t0, nums + 0
    lw $t1, nums + 4
    # B: $t3 & $t2
    lw $t2, nums + 8
    lw $t3, nums + 12

    # s0 --> Slo
    addu $s0, $t0, $t2
    
    # t4 --> C32
    not $t4, $s0
    and $t5, $t4, $t0
    and $t6, $t4, $t2
    and $t4, $t0, $t2

    or $t4, $t4, $t5
    or $t4, $t4, $t6

    srl $t4, $t4, 31

    # s1 --> Shi
    addu $s1, $t4, $t1

    # t4 --> first upper carry
    # Ci+1 = Si'Ai + Si'Bi + AiBi, for Bi = 0
    not $t4, $s1
    and $t4, $t4, $t1

    srl $t4, $t4, 31

    move $t5, $s1   # save current value
    addu $s1, $s1, $t3

    # t5 --> second upper carry
    not $t6, $s1
    and $t7, $t6, $t5
    and $t8, $t6, $t3
    and $t6, $t3, $t5

    or $t5, $t6, $t7
    or $t5, $t5, $t8

    srl $t5, $t5, 31

    # t4 --> C64
    add $t4, $t4, $t5

    sw $s0, sum + 0
    sw $s1, sum + 4
	
	j Exit

Exit:				li 		$v0, 10
					syscall				#au revoir...
