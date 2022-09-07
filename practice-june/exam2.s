#################################################
#			 									#
#     	 	data segment						#
#												#
#################################################

	.data
endl: 					.asciiz 	"\n"
numbers: .asciiz "012345678"
input: .asciiz "1234"
zero: .asciiz "000"
one: .asciiz "001"
two: .asciiz "010"
three: .asciiz "011"
four: .asciiz "100"
five: .asciiz "101"
six: .asciiz "110"
seven: .asciiz "111"
check: .asciiz "0000"
error: .asciiz "Wrong input\n"
bye: .asciiz "bye :)\n"


#################################################
#												#
#				text segment					#
#												#
#################################################

	.text
	.globl __start	
												#read first int and move it to a temp reg
__start:
li $k0, 48 #ascii for 0
li $s4, 4
start:              
                    li $k1, 0 #counter of 0

                    li $v0, 8					# code to read a string
					la $a0, input					# ??? --> label with string
					li $a1, 5					# n chars --> $a1=n+1 eg: (20+1)--> li $a1, 21
					syscall
                
                    la $s0, input
                    lbu $t0, 0($s0)
                    lbu $t1, 1($s0)
                    lbu $t2, 2($s0)
                    lbu $t3, 3($s0)

                    move $a0, $t0
                    jal switch_case_with_break

                    
                    move $a0, $t1
                    jal switch_case_with_break

                    
                    move $a0, $t2
                    jal switch_case_with_break

                    
                    move $a0, $t3
                    jal switch_case_with_break
                    
                    la		$a0,endl 			# system call to print
					li		$v0, 4 				# out a newline
					syscall

                    beq $k1, $s4, Exit

                    j start 


Exit:				li $v0, 4
					la $a0,bye					# ??? --> label with string
					syscall
                    li 		$v0, 10
					syscall				#au revoir...



switch_case_with_break: move $t0, $a0
        case001:        li $t8, 48
        		        bne $t0, $t8 , case002	
		if_case001:		li $v0, 4
					    la $a0, zero					# ??? --> label with string
					    syscall
                        addi $k1, 1 #counter of zeros
					    jr $ra
						
		case002:		li $t8, 49
        		        bne $t0, $t8 , case003	
		if_case002:		li $v0, 4
					    la $a0, one					# ??? --> label with string
					    syscall
					    jr $ra
						
		case003:		li $t8, 50
        		        bne $t0, $t8 , case004	
		if_case003:		li $v0, 4
					    la $a0, two					# ??? --> label with string
					    syscall
					    jr $ra

        case004:		li $t8, 51
        		        bne $t0, $t8 , case005	
		if_case004:		li $v0, 4
					    la $a0,three					# ??? --> label with string
					    syscall
					    jr $ra

        case005:		li $t8, 52
        		        bne $t0, $t8 , case006	
		if_case005:		li $v0, 4
					    la $a0,four					# ??? --> label with string
					    syscall
					    jr $ra

        case006:		li $t8, 53
        		        bne $t0, $t8 , case007	
		if_case006:		li $v0, 4
					    la $a0,five					# ??? --> label with string
					    syscall
					    jr $ra

        case007:		li $t8, 54
        		        bne $t0, $t8 , case008	
		if_case007:		li $v0, 4
					    la $a0,six					# ??? --> label with string
					    syscall
					    jr $ra

        case008:		li $t8, 55
                        bne $t0, $t8, else_case
		if_case008:		li $v0, 4
					    la $a0, seven					# ??? --> label with string
					    syscall
					    jr $ra

		else_case:		li $t8, 0
        		        bne $t0, $t8 , if_non_case	
			            li $v0, 4
					    la $a0, endl					# ??? --> label with string
					    syscall
					    jr $ra


		if_non_case:	li $v0, 4
					    la $a0, error					# ??? --> label with string
					    syscall	
                        j start