#################################################
#			 									#
#     	 	data segment						#
#												#
#################################################

	.data
endl: 					.asciiz 	"\n"
msg1: .asciiz "POWERS-SUM="
epi: .asciiz "*10^"
sin: .asciiz " + "
#################################################
#												#
#				text segment					#
#												#
#################################################

	.text
	.globl __start	
												#read first int and move it to a temp reg
__start:


read_int:			li $t9, 0 #n of digits
                    li $t8, 10 # t8 divisor 
                    li $k0, 10
                    li $k1, 1
                    li $s1, -1

                    li		$v0, 5				# $v0 <--- integer
					syscall
                    move $t0 , $v0
                    beq $t0, $zero, exit

                    li $v0, 4 #print msg
					la $a0, msg1					# ??? --> label with string
					syscall                    

    loop_count_digits:  addi $t9, 1 #HEREE
                        mult $t8, $k0 
                        mflo $t8
                        blt $t8, $t0 , loop_count_digits

                        div $t8, $k0 
                        mflo $t8 # 1 digit
                        move $t4, $t0 # remainder
                    
             loop2:     div $t4, $t8 
                        mflo $t3
                        mfhi $t4
                        jal print_digit     
                        div $t8, $k0 # /10
                        mflo $t8 
                        sub $t9 , $t9 , $k1 # -1 digit
                        bgt $t9, $s1, loop2

                        la		$a0,endl 			# system call to print
					    li		$v0, 4 				# out a newline
					    syscall

                        j read_int

                          

            exit:   li 		$v0, 10
					syscall				#au revoir...



print_digit: 	move $a0, $t3			# ???  --> register with integer
				li $v0, 1
				syscall
			
                li $v0, 4 #print msg
				la $a0, epi					# ??? --> label with string
				syscall  

                move $a0, $t9			# ???  --> register with integer
				li $v0, 1
				syscall

                blt		$t9, $k1, target	# if $t0 == $t1 then target
                        li $v0, 4 #print msg
				        la $a0, sin					# ??? --> label with string
				        syscall  
                target:

                jr $ra
                    
