#################################################
#			 									#
#     	 	data segment						#
#												#
#################################################

	.data
endl: 					.asciiz 	"\n"
str: .space 5
numbers: .asciiz "01234567"
zero: .asciiz "000"
one: .asciiz "001"
two: .asciiz "010"
three: .asciiz "011"
four: .asciiz "100"
five: .asciiz "101"
six: .asciiz "110"
seven: .asciiz "111"
error: .asciiz "Wrong input only octadecimal\n"
bye: .asciiz "\nbye:)\n"
#################################################
#												#
#				text segment					#
#												#
#################################################

	.text
	.globl __start	
												#read first int and move it to a temp reg
__start:
li $s4, 4
loop:

        li $v0, 8					# code to read a string
		la $a0, str					# ??? --> label with string
	    li $a1, 5					# n chars --> $a1=n+1 eg: (20+1)--> li $a1, 21
		syscall

		li $k0, 0 
		

        la $s0, str
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

		beq $k0, $s4, Exit

		li $v0, 4
		la $a0, endl			# ??? --> label with string
		syscall

		j loop



Exit:				li $v0, 4
					la $a0, bye			# ??? --> label with string
					syscall
					li 		$v0, 10
					syscall				#au revoir...


switch_case_with_break: move $t8, $a0
		case001:		li $t9, 48
		    			bne $a0, $t9 , case002 	# this condition/case is not valid, check next case 	
		if_case001:		li $v0, 4
						la $a0, zero				# ??? --> label with string
						syscall
						addi $k0, 1
						jr $ra
						
		case002:    	li $t9, 49
						bne $a0, $t9 , case003 	# this condition/case is not valid, check next case 	
		if_case002:		li $v0, 4
						la $a0, one				# ??? --> label with string
						syscall
						jr $ra

		case003:    	li $t9, 50
						bne $a0, $t9 , case004 	# this condition/case is not valid, check next case 	
		if_case003:		li $v0, 4
						la $a0, two				# ??? --> label with string
						syscall
						jr $ra

		case004:    	li $t9, 51
						bne $a0, $t9 , case005 	# this condition/case is not valid, check next case 	
		if_case004:		li $v0, 4
						la $a0, three			# ??? --> label with string
						syscall
						jr $ra

		case005:    	li $t9, 52
						bne $a0, $t9 , case006 	# this condition/case is not valid, check next case 	
		if_case005:		li $v0, 4
						la $a0, four			# ??? --> label with string
						syscall
						jr $ra				
		
		case006:    	li $t9, 53
						bne $a0, $t9 , case007 	# this condition/case is not valid, check next case 	
		if_case006:		li $v0, 4
						la $a0, five			# ??? --> label with string
						syscall
						jr $ra

		case007:    	li $t9, 54
						bne $a0, $t9 , case008 	# this condition/case is not valid, check next case 	
		if_case007:		li $v0, 4
						la $a0, six			# ??? --> label with string
						syscall
						jr $ra

		case008:    	li $t9, 55
						bne $a0, $t9 , else_case_ 	# this condition/case is not valid, check next case 	
		if_case008:		li $v0, 4
						la $a0, seven			# ??? --> label with string
						syscall
						jr $ra	

		else_case_:		li $t9, 0
						bne $a0, $t9 , if_non_case
						li $v0, 4
						la $a0, endl			# ??? --> label with string
						syscall
						jr $ra				

		if_non_case:  	li $v0, 4
						la $a0, error					# ??? --> label with string
						syscall	 		# non of previous conditions/cases exit 	
						j loop
		