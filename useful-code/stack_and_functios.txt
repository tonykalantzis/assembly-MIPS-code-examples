-------------------------- STACK AND FUNCTIONS-----------------------
We call functions with command jal (jump and link). This command saves in $ra the address that must return to, after the calling of the function.

leaf_proc_not_using_stack: 	 	
							##     commands    ##
							jr $ra
					
leaf_proc_using_stack:      				  
							addi $sp, $sp, -16  #3 words or 3 registers (xx, xy, zz & ra) --> 4*n=4*4=16
							
							sw $ra, 12 ($sp)
							sw $xx, 8 ($sp)
							sw $yy, 4 ($sp)
							sw $zz, 0 ($sp)

							##     commands    ##

							lw $zz, 0 ($sp)
							lw $yy, 4 ($sp)
							lw $xx, 8 ($sp)
							lw $ra, 12 ($sp)
							
							addi $sp, $sp, 16
							
							jr $ra
						
node_proc_using_stack:  
							addi $sp, $sp, -16  #3 words or 3 registers (xx, xy, zz & ra) --> 4*n=4*4=16

							sw $ra, 12 ($sp)
							sw $xx, 8 ($sp)
							sw $yy, 4 ($sp)
							sw $zz, 0 ($sp)
						
							jal any_procedure  #leaf_proc_non_using_stack or leaf_proc_using_stack or node_proc_using_stack
							
							lw $zz, 0 ($sp)
							lw $yy, 4 ($sp)
							lw $xx, 8 ($sp)
							lw $ra, 12 ($sp)

							addi $sp, $sp, 16
							jr $ra