#################################################
#			 									#
#     	 	data segment						#
#												#
#################################################

	.data
endl: 					.asciiz 	"\n"
msga: .asciiz "Give number a: "
msgb: .asciiz "Give number b: "
msgc: .asciiz "Give number c: "
error: .asciiz "Den iparxei pragmatiki riza\n"
msg1: .asciiz "x1= "
msg2: .asciiz "x2= "
#################################################
#												#
#				text segment					#
#												#
#################################################

	.text
	.globl __start	
												#read first int and move it to a temp reg
__start:

			li $v0, 4
			la $a0, msga					# ??? --> label with string
			syscall
			
			li	$v0, 6				# $f0 <--- float
			syscall
			mov.s $f1, $f0
			
			mov.s	$f12, $f1			# ???  --> FP register with float
			li $v0, 2
			syscall
			
			la		$a0,endl 			# system call to print
			li		$v0, 4 				# out a newline
			syscall
#-------------------------------------------------------------------

			li $v0, 4
			la $a0, msgb					# ??? --> label with string
			syscall

			li	$v0, 6				# $f0 <--- float
			syscall
			mov.s $f2, $f0
			
			mov.s	$f12, $f2			# ???  --> FP register with float
			li $v0, 2
			syscall

			la		$a0,endl 			# system call to print
			li		$v0, 4 				# out a newline
			syscall
#------------------------------------------------------------------

			li $v0, 4
			la $a0, msgc					# ??? --> label with string
			syscall

			li	$v0, 6				# $f0 <--- float
			syscall
			mov.s $f3, $f0
			
			mov.s	$f12, $f3			# ???  --> FP register with float
			li $v0, 2
			syscall

			la		$a0,endl 			# system call to print
			li		$v0, 4 				# out a newline
			syscall
#-----------------------------------------------------------------
		li.s $f10, 4.0
		#cvt.s.w $f10, $t0
		
		mul.s $f4, $f2, $f2 #b square
		mul.s $f5, $f1, $f3
		mul.s $f5, $f5, $f10 #*

		sub.s $f6, $f4, $f5

#----------------------------------------------------------------------		

		switch_case_with_break: li.s $f8, -1.0
								li.s $f9, 2.0
		case001:		c.eq.s  $f6, $f11	# this condition/case is not valid, check next case
						bc1f if_case002	
		if_case001:		mul.s $f2, $f2, $f8
						mul.s $f1,$f1, $f9
						div.s $f0, $f2, $f1
						
						la		$a0, msg1  			# system call to print
						li		$v0, 4 				# out a newline
						syscall
						
						mov.s	$f12, $f0			# ???  --> FP register with float
						li $v0, 2
						syscall
						j Exit
						#j Exit_switch_case
						
		case002:		c.lt.s $f6, $f11
						bc1f else_case
		if_case002:		li $v0, 4
						la $a0, error					# ??? --> label with string
						syscall
						j Exit						
			
		else_case:		sqrt.s $f6, $f6
						mul.s $f2, $f2, $f8 
						mul.s $f1,$f1, $f9
						add.s $f2, $f2, $f6
						div.s $f0, $f2, $f1
						
						la		$a0, msg1  			# system call to print
						li		$v0, 4 				# out a newline
						syscall

						mov.s	$f12, $f0			# ???  --> FP register with float
						li $v0, 2
						syscall

						mul.s $f6, $f6, $f8
						add.s $f2, $f2, $f6
						div.s $f0, $f2, $f1

						la		$a0, msg2  			# system call to print
						li		$v0, 4 				# out a newline
						syscall

						mov.s	$f12, $f0			# ???  --> FP register with float
						li $v0, 2
						syscall
						j Exit
						


						



							 		# non of previous conditions/cases exit 	
		if_non_case_:	#...........




Exit:				li 		$v0, 10
					syscall				#au revoir...
