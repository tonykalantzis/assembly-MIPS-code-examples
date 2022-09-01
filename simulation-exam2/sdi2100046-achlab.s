#################################################
#			 									#
#     	 	data segment						#
#												#
#################################################

	.data
endl: 					.asciiz 	"\n"
msg1: .asciiz "Give me the number a:\n"
msg2: .asciiz "Give me the number b:\n"
msg3: .asciiz "Give me the number c:\n"
msgNULL: .asciiz "Root negative, no solutions\n" 
minusfour: .float -4.0

#################################################
#												#
#				text segment					#
#												#
#################################################

	.text
	.globl __start	
												#read first int and move it to a temp reg
__start:
    li		$v0, 6				# $f0 <--- float
	syscall
	mov.s $f1, $f0

   
    li		$v0, 6				# $f0 <--- float
	syscall
	mov.s $f2, $f0

    li		$v0, 6				# $f0 <--- float
	syscall
	mov.s $f3, $f0
#---------------------------------------------------------------------------------------------
    mul.s $f7, $f2, $f2 #b^2

    li.s $f5 , -4.0
    mul.s $f6, $f5, $f1 #-4a
    mul.s $f6, $f6, $f3 #-4ac

    add.s $f4, $f7, $f6 #f4=Δ , b^2-4av

#/---------------------------------------------------------------------------------------------

    switch_case_with_break: li.s $f8, 0.0
                            li.s $f9, -1.0
		case001:		c.eq.s $f4, $f8 	# this condition/case is not valid, check next case 
                        bc1f case002	
		if_case001:							
						mul.s $f10, $f2, $f9 #-b
                        add.s $f11, $f1, $f1 #2a
                        div.s $f10, $f10, $f11

                        mov.s	$f12, $f10			# ???  --> FP register with float
					    li $v0, 2
					    syscall

                        j Exit
		case002:		c.lt.s $f4, $f8	# this condition/case is not valid, check next case 
                        bc1f case00n	
		if_case002:		
                        li $v0, 4
					    la $a0, msgNULL					# ??? --> label with string
					    syscall
                        
						j Exit						

						#...........
						
		case00n:		sqrt.s $f4, $f4 #sqr(Δ)
                        mul.s $f10, $f2, $f9 #-b
                        add.s $f11, $f1, $f1 #2a

                        add.s $f12, $f4, $f10
                        div.s $f12, $f12, $f11               
					    li $v0, 2
					    syscall  

                        la		$a0,endl 			# system call to print
					    li		$v0, 4 				# out a newline
					    syscall

                        sub.s $f12, $f10, $f4
                        div.s $f12, $f12, $f11
                        li $v0, 2
					    syscall

						j Exit
						
	


Exit:				li 		$v0, 10
					syscall				#au revoir...
