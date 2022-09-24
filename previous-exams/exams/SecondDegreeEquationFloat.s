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
error: .asciiz "It has no solutions :/\n"
msg0: .asciiz "x = "
msg1: .asciiz "x1 = "
msg2: .asciiz "x2 = "
#################################################
#												#
#				text segment					#
#												#
#################################################

	.text
	.globl __start	
												#read first int and move it to a temp reg
__start:
#----------------------------A--------------------------------------
			li $v0, 4                   #print string
			la $a0, msga	 
			syscall
			
			li	$v0, 6				    #read float 
			syscall
			mov.s $f1, $f0  			#$f1 = a
			
			mov.s	$f12, $f1			#print float from reg
			li $v0, 2
			syscall
			
			la		$a0,endl 			# print end of line 
			li		$v0, 4 				
			syscall
#----------------------------B--------------------------------------

			li $v0, 4 					#print string
			la $a0, msgb					
			syscall
 
			li	$v0, 6				    #read float
			syscall
			mov.s $f2, $f0  			# $f2 = b
			
			mov.s	$f12, $f2			#print float from reg
			li $v0, 2
			syscall

			la		$a0,endl 			# print end of line
			li		$v0, 4 				
			syscall
#----------------------------C-------------------------------------

			li $v0, 4					#print string
			la $a0, msgc					
			syscall

			li	$v0, 6					#read float
			syscall
			mov.s $f3, $f0				#$f3 = c
			
			mov.s	$f12, $f3			#print float from reg
			li $v0, 2
			syscall

			la		$a0,endl 			# print end of line
			li		$v0, 4 				
			syscall
#-----------------------------------------------------------------
		li.s $f10, 4.0
		
		mul.s $f4, $f2, $f2   #b^2
		mul.s $f5, $f1, $f3  #a*c 
		mul.s $f5, $f5, $f10 #4*a*c 

		sub.s $f6, $f4, $f5  #$f6 = Δ = b^2 - 4ac

#----------------------------------------------------------------------		

		switch_case_with_break: li.s $f8, 0.0 
								li.s $f9, -1.0
								li.s $f10, 2.0
		case001:		c.eq.s  $f6, $f8   			#if Δ = 0 	
						bc1f case002				#false then jump to case002
						mul.s $f2, $f2, $f9			#-b
						mul.s $f1, $f1, $f10		#2a
						div.s $f0, $f2, $f1         #-b/2a
						
						la		$a0, msg0  			
						li		$v0, 4 				
						syscall
						
						mov.s	$f12, $f0			
						li $v0, 2
						syscall
						j Exit
						
		case002:		c.lt.s $f6, $f8             #if Δ < 0 
						bc1f else_case
						li $v0, 4
						la $a0, error					
						syscall
						j Exit						
			
		else_case:		sqrt.s $f7, $f6           	# sqrt(Δ)  
						
						mul.s $f2, $f2, $f9 	   	# -b                       	#
						mul.s $f1, $f1, $f10       	# 2a						#
						add.s $f2, $f2, $f7        	#-b + sqrt(Δ)				#solution 1 
						div.s $f0, $f2, $f1		   	# ( -b + sqrt(Δ) )/ 2a	    #
						
						la		$a0, msg1  		   	#print str
						li		$v0, 4 				
						syscall

						mov.s	$f12, $f0			#print float 
						li $v0, 2
						syscall

						sub.s $f2, $f2, $f7 		# -b - sqrt(Δ) 				#
						div.s $f0, $f2, $f1        	# ( -b - sqrt(Δ) )/ 2a		#solution 2 

						la		$a0,endl 			# print end of line
						li		$v0, 4 				
						syscall
						
						la		$a0, msg2  			#print str 
						li		$v0, 4 				
						syscall

						mov.s	$f12, $f0		 	#print float	
						li $v0, 2
						syscall
						j Exit
						


						



							 		# non of previous conditions/cases exit 	
		if_non_case_:	#...........




Exit:				li 		$v0, 10
					syscall				#au revoir...
