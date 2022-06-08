#################################################
#			 									#
#     	 	data segment						#
#												#
#################################################

	.data
endl: 					.asciiz 	"\n"
msg1: .asciiz "FOUND-INTEGER=" 
msg2: .asciiz "NOT-INTEGER="
#################################################
#												#
#				text segment					#
#												#
#################################################

	.text
	.globl __start	
												#read first int and move it to a temp reg
__start:

start:             
                    

    read_float:		li	$v0, 6				# $f0 <--- float
                    syscall
                    mov.s $f1, $f0 
                    
                    c.eq.s $f1, $f5
                    bc1t Exit
                    
                    cvt.w.s $f2, $f1
                    cvt.s.w $f2, $f2

                    c.eq.s $f1, $f2
                    bc1t print_msg1
                    bc1f print_msg2

        print_msg1: li $v0, 4
					la $a0, msg1					# ??? --> label with string
					syscall          

                    mov.s $f12, $f2			# ???  --> FP register with float
					li $v0, 2
					syscall

                    la		$a0,endl 			# system call to print
					li		$v0, 4 				# out a newline
					syscall

                    j start

        print_msg2: li $v0, 4
					la $a0, msg2					# ??? --> label with string
					syscall 
                    
                    mov.s $f12, $f1			# ???  --> FP register with float
					li $v0, 2
					syscall

                    la		$a0,endl 			# system call to print
					li		$v0, 4 				# out a newline
					syscall
                    
                    j start



Exit:				li 		$v0, 10
					syscall				#au revoir...
