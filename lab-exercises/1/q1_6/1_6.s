#################################################
#			 									#
#     	 	data segment						#
#												#
#################################################

	.data
endl: .asciiz 	"\n"
msg1: .asciiz "Give first number to add: "
msg2: .asciiz "Give second number to add: "
msg3: .asciiz "Sum of the two numbers is: "
msg4: .asciiz "Diff of the two numbers is: "
#################################################
#												#
#				text segment					#
#												#
#################################################

	.text
	.globl __start	
												#read first int and move it to a temp reg
__start:
        		li $v0, 4   #printf msg1
				la $a0, msg1				
				syscall
			
                li		$v0, 5 #read int
                syscall
                move	$t0, $v0

                move    $a0, $t0 #print int 
                li $v0 , 1
                syscall

                la		$a0, endl #print \n
                li		$v0, 4
                syscall
####################################################################			    
                li $v0, 4   #printf msg2
				la $a0, msg2				
				syscall
			
                li		$v0, 5 #read int
                syscall
                move	$t1, $v0

                move    $a0, $t1 #print int 
                li $v0 , 1
                syscall

                la		$a0, endl #print \n
                li		$v0, 4
                syscall
####################################################################
                li $v0, 4   #printf msg3
				la $a0, msg3				
				syscall

                add $t2, $t0, $t1 # a + b = $t2
                
                move $a0, $t2 #print int 
                li $v0 , 1
                syscall

                la		$a0, endl #print \n
                li		$v0, 4
                syscall
###################################################################
                li $v0, 4   #printf msg4
			    la $a0, msg4				
				syscall
               
                sub $t3, $t0, $t1 # a - b = $t3

                move $a0, $t3 #print int 
                li $v0 , 1
                syscall

                la		$a0, endl #print \n
                li		$v0, 4
                syscall
               
                j Exit


Exit:				li 		$v0, 10
					syscall				#au revoir...


#################################################
#			 									#
#     	 	Useful code						#
#												#
#################################################

#print_endl:		la		$a0,endl 			# system call to print
#					li		$v0, 4 				# out a newline
#					syscall
#					jr $ra

#read_str:			li $v0, 8					# code to read a string
#					la $a0, ???					# ??? --> label with string
#					li $a1, ?n?					# n chars --> $a1=n+1 eg: (20+1)--> li $a1, 21
#					syscall
#					jr $ra

#print_str:			li $v0, 4
#					la $a0, ???					# ??? --> label with string
#					syscall
#					jr $ra

#read_int:			li		$v0, 5				# $v0 <--- integer
#					syscall
#					jr $ra

#print_int_from_reg:	move	$a0, ???			# ???  --> register with integer
#					li $v0, 1
#					syscall
#					jr $ra

#print_immidiate:	li $v0, 1
#					li $a0, ???					# ???  --> immediate
#					syscall
#					jr $ra

#read_float:		li		$v0, 6				# $f0 <--- float
#					syscall
#					jr $ra

#print_float_from_reg:	mov.s	$f12, ???			# ???  --> FP register with float
#					li $v0, 2
#					syscall
#					jr $ra

#print_float_immidiate:	li $v0, 2
#					li.s $f12, ???					# ???  --> immediate, e.g -1.2345678
#					syscall
#					jr $ra

#read_double:		li		$v0, 7				# $f0 <--- double
#					syscall
#					jr $ra

#print_double_from_reg:	mov.d	$f12, ???			# ???  --> FP register with float
#					li $v0, 3
#					syscall
#					jr $ra

#print_double_immidiate:	li $v0, 3
#					li.d $f12, ???					# ???  --> immediate, e.g -1.2345678
#					syscall
#					jr $ra

#leaf_proc_not_using_stack: ........... 	
#							...........
#							jr $ra
					
leaf_proc_using_stack:  #.....              // NOT $ra
			     		#addi $sp, $sp, -16 # 4 words or 4 registers (xx, xy, yy & yz) --> 4*n=4*4=16
						#...........
						#sw $xx, 0 ($sp)
						#...........
						#sw $xy, 4 ($sp)
						#...........
						#sw $yy, 8 ($sp)
						#...........
						#sw $yz, 12 ($sp)
						
						#...........
						#...........
						
						#lw $xx, 0 ($sp)
						#...........
						#lw $xy, 4 ($sp)
						#...........
						#lw $yy, 8 ($sp)
						#...........
						#lw $yz, 12 ($sp)
						#...........
						addi $sp, $sp, 16
						#...........
						jr $ra
						
node_proc_using_stack:  #...........
			     		#addi $sp, $sp, -16 # 3 words or 3 registers (xx, xy, zz & ra) --> 4*n=4*4=16
						#...........
						#sw $ra, 12 ($sp)
						#...........
						#sw $xx, 8 ($sp)
						#...........
						#sw $yy, 4 ($sp)
						#...........
						#sw $zz, 0 ($sp)
						
						#...........
						#...........
						
						#jal any_procedure # leaf_proc_non_using_stack or leaf_proc_using_stack or node_proc_using_stack
						
						#...........
						#...........
						
						#lw $zz, 0 ($sp)
						#...........
						#lw $yy, 4 ($sp)
						#...........
						#lw $xx, 8 ($sp)
						#...........
						#lw $ra, 12 ($sp)
						#...........
						#addi $sp, $sp, 16
						#...........
						#jr $ra
						
switch_case_no_break:   #...........
						#move $XY, $zero     	# initialize flag register $XY
		case01:			#bXX $YY,$ZZ, case02 	# this condition/case is not valid, check next case 	
		if_case01:		#...........
						#addi $XY, $XY, 1
						
		case02:			#bXX $YY,$ZZ, case?? 	# this condition/case is not valid, check next case 	
		if_case02:		#...........
						#addi $XY, $XY, 1						

						#...........
						
		case0n:			#bXX $YY,$ZZ, case03 	# this condition/case is not valid, check next case 	
		if_case0n:		#...........
						#addi $XY, $XY, 1
						
		else_case:		#bne $XY,$zero, Exit	# non of previous conditions/cases exit, exit 	
		if_non_case:	#...........
						
switch_case_with_break: #...........
		case001:		#bXX $YY,$ZZ, case02 	# this condition/case is not valid, check next case 	
		if_case001:		#...........
						#j Exit_switch_case
						
		case002:		#bXX $YY,$ZZ, case?? 	# this condition/case is not valid, check next case 	
		if_case002:		#...........
						#j Exit_switch_case						

						#...........
						
		case00n:		#bXX $YY,$ZZ, else_case 	# this condition/case is not valid, check next case 	
		if_case00n:		#...........
						#j Exit_switch_case
						
		else_case_:		#...........	 		# non of previous conditions/cases exit 	
		if_non_case_:	#...........
		
while_do_1_condition:   #...........
						#bXX $YY,$ZZ, exit_while

						#...........
						#addi #counter, #counter, 1  #possible approach
						
						j while_do_1_condition
		
while_do_a_AND_b:   	#...........				# when !a OR !b, exit while
						#bXX $RR,$ZZ, exit_while    # if a is not valid exit while
						#bYY $WW,$TT, exit_while    # if b is not valid exit while

						#...........
						#addi #counter, #counter, 1  #possible approach
						
						j while_do_a_AND_b
		
while_do_a_OR_b_1:   	#...........				# when !a AND !b, exit while
						#bXX $RR,$ZZ, exit_while    # if !a is not valid exit while
						#bYY $WW,$TT, exit_while    # if !b is not valid exit while

						#...........
						#addi #counter, #counter, 1  #possible approach
						
						j while_do_a_AND_b
		
while_do_a_OR_b_2:   	#...........				# when !a AND !b exit wile
			check_a:	#bXX $RR,$ZZ, check_b    	# if a is not valid check b
						
			do:			#...........
						#addi #counter, #counter, 1  #possible approach
						#j while_do_a_OR_b_2
			
			check_b:	#bYY $WW,$TT, exit_while    # if b is not valid exit while
						
						j do
