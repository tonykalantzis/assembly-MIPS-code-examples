#Print the entered string as a pyramid
#################################################
#												#
#				  text segment					#
#												#
#################################################
	.text
	.globl __start	
__start:
#-------------start of main program-------------#
print_string :  la $a0, message
                li $v0 , 4
                syscall 

read_string :   li $v0,8
                la $a0 , string
                li $a1, 26
                syscall

                li $s0, 6
                la $s1, string

print_string_before:    la $a0,string
                        li $v0,4
                        syscall

pyramid:    
            addi $s0, $s0,-1
            move $t0,$s0            #t0->number of spaces 

            li $t3, 2
            mul $t4, $t0,$t3
            li $t5, 11
            sub $t3, $t5, $t4       #t3->number of char in the line
        
            jal print_endl    
         
            check:  li $s3, 3                      #last line case/only print chars
                    beq $t0, $zero,loop_char

                    li $s3, 0      #flag
                    loop_space : 
                        print_space:    la $a0, space
                                        li $v0, 4
                                        syscall

                        addi $t0,$t0,-1
                        bne $t0, $zero, loop_space
                        addi $s3, $s3, 1     #flag
                        li $t6 , 3
                        beq $s3,$t6, pyramid

                    loop_char:
                        print_char:     lbu $a0, 0($s1)
                                        addi $s1, $s1, 1
                                        li $v0 , 11
                                        syscall
                                        
                        addi $t3,$t3,-1 
                        bne $t3, $zero, loop_char

                        li $t6, 3
                        beq $s3, $t6, exit
                        addi $s3, $s3, 1        #flag
                        li $t6, 2
                        beq $s3, $t2, loop_space


                    beq $t0,$zero, pyramid      
            
                        
exit:   li 	$v0, 10
		syscall				#au revoir...
#-------------end of main program--------------#

#-------------start of procedures--------------#
print_endl:			la	$a0,endl 			 
					li	$v0, 4 				#system call to print
					syscall
					jr $ra

#-------------end of procedures---------------#

#################################################
#			 									#
#     	 	      data segment				    #
#												#
#################################################

	.data
message: .asciiz "Give a string of 25 chars: "
endl: 	.asciiz 	"\n"
string : .space 26
space : .asciiz " "