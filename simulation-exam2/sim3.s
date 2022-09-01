#################################################
#			 									#
#     	 	data segment						#
#												#
#################################################

	.data
endl: 					.asciiz 	"\n"
msgA: .asciiz "FOUND-INTEGER= "
msgB: .asciiz "NOT-INTEGER= "
msg: .asciiz "0 is the exit bye :)\n"
#################################################
#												#
#				text segment					#
#												#
#################################################

	.text
	.globl __start	
												#read first int and move it to a temp reg
__start:
 
loop:               
            li	$v0, 6		#read float		# $f0 <--- float
			syscall
            mov.s $f1, $f0  

            c.eq.s $f1, $f5 #checking if 0
            bc1t Exit

            cvt.w.s $f2, $f1
            cvt.s.w $f2, $f2

            c.eq.s $f1, $f2 
            bc1t msg1
            bc1f msg2

            msg1:   li $v0, 4
				    la $a0, msgA				# ??? --> label with string
					syscall

                    mov.s   $f12, $f1			# ???  --> FP register with float
					li $v0, 2
					syscall

                    la		$a0,endl 			# system call to print
					li		$v0, 4 				# out a newline
					syscall
                    
            j loop

            msg2:   li $v0, 4
				    la $a0, msgB				# ??? --> label with string
					syscall

                    mov.s   $f12, $f1			# ???  --> FP register with float
					li $v0, 2
					syscall

                    la		$a0,endl 			# system call to print
					li		$v0, 4 				# out a newline
					syscall
            j loop


Exit:		li $v0, 4
			la $a0, msg				# ??? --> label with string
			syscall
            li 		$v0, 10
			syscall				#au revoir...
