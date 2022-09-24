power_of_a_number:		#s0->base 
						#s1-> power
						li $t0,1
						li $s3,1
						pow:    mul $s3,$s3,$s0
								addi $t0,$t0,1
								bgt $t0,$s1, print_results
								j pow
