isolation of bit:
						li $t2,31   #like pointer
						li $t3, 0x80000000			#1000 0000 0000 0000 0000 0000 0000 0000
						li $t5, -1
						
					loop:   and $s1,$s0,$t3			
							srl $s1,$s1,$t2
							beqz $s1, add_zero
								if_is_1:    addi $t1,$t1,1
											j fix
							add_zero:   addi $t0,$t0,1
							fix:    addi $t2,$t2,-1
									beq $t2, $t5, print_results
									srl $t3,$t3,1
									j loop 