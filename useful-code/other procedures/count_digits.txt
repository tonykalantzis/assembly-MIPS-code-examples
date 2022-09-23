count_digits:	move $t4, $t0
                    li $t5,0            #number of digits
                    li $t2, 10 
                    la $a0, powersum
                    jal print_string
                    digits:     div $t4,$t2
                                mflo $t4
                                addi $t5,$t5, 1     #increase the number
                                beqz $t4, internal_loop
                                j digits