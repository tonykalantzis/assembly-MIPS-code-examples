#################################################
#												#
#				  text segment					#
#												#
#################################################
	.text
	.globl __start	
__start:
#-------------start of main program-------------#
    jal read_int      #base
    move $s0, $v0

    move $a0, $s0       
    jal print_int

    jal print_endl

    jal read_int        #power
    move $s1, $v0

    move $a0,$s1   
    jal print_int
    
    li $t0,1
    li $s3,1
pow:    mul $s3,$s3,$s0
        addi $t0,$t0,1
        bgt $t0,$s1, print_results
        j pow

print_results:  jal print_endl
                move $a0,$s3
                jal print_int

exit:   li 	$v0, 10
		syscall				#au revoir...
#-------------end of main program--------------#

#-------------start of procedures--------------#
print_endl:			la	$a0,endl 			 
					li	$v0, 4 				#system call to print
					syscall
					jr $ra

read_int:			li	$v0, 5				 #$v0 <--- integer
					syscall
					jr $ra

print_int:			#move $a0, ???			 #???  --> register with integer
					li $v0, 1
					syscall
					jr $ra
#-------------end of procedures---------------#

#################################################
#			 									#
#     	 	      data segment				    #
#												#
#################################################

	.data
endl: 	.asciiz 	"\n"