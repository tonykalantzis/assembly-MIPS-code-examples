#################################################
#		        			#
#               text segment			#
#	        				#
#################################################
#doesnt work
	.text
	.globl __start	
__start:
#-------------start of main program-------------#
        li $v0,4            #display "enter the integer"
        la $a0,prompt 
        syscall

        li $v0,5            #read int
        syscall

        move $a0,$v0        #$a0 ->integer

        li $v0, 1           #print int
        syscall

        jal print_endl

        jal fibonacci       #calculate f(n), where n is $a0

        la $a0,fib          #print the message for fibonacci terms
        li $v0,4
        syscall

        move $a0,$v1
        li $v0,1
        syscall             #print Fibonacci(n)

        jal print_endl

Exit:   li 	$v0, 10
		syscall				#au revoir...
#-------------end of main program--------------#

#-------------start of procedure--------------#
print_endl:     la $a0,endl
                li $v0, 4
                syscall
                jr $ra

fibonacci:  
            addi $sp,$sp,-16
            sw $ra,0($sp)
            sw $a0,4($sp)
            sw $s0,8($sp)
            sw $s1,12($sp)

            #Base cases 0 and 1

            beqz $a0,case_0
            li $t0, 1
            seq $t1,$t0,$a0
            bnez $t1, case_1

            #default case:a>1

            addi $a0,$a0,-1
            jal fibonacci
            move $s0,$v1

            jal fib_aux
            move $s1,$v0

            add $v1,$s0,$s1
            j exit_fib

case_0:     li $v1,0
            j exit_fib

case_1:     li $v1,1
            j exit_fib

exit_fib:   lw $ra,0($sp)
            lw $a0,4($sp)
            lw $s0,8($sp)
            lw $s1,12($sp)
            addi $sp, $sp,16
            jr $ra              #jump to the caller function

#Auxiliary function to make fib linerally recursive
fib_aux:    addi $sp,$sp,-8
            sw $ra,0($sp)
            sw $a0,4($sp)

            #Base cases a0=0 a0=1
            li $t0,1
            slt $t1,$t0,$a0
            beqz $t1,case_0_or_1     #if ($a0<= 1),go to case_0_or_1

            #Default case $a0>1

            addi $a0,$a0,-1
            jal fibonacci        #Call fibonacci recursively for the new value of $a0

            move $v0,$v1
            j exit_aux

case_0_or_1:    li $v0,1
                j exit_aux

exit_aux:       lw $ra,0($sp)
                lw $a0,4($sp)
                addi $sp,$sp,8
                jr $ra          #jump to the caller function


#-------------end of procedure---------------#

#################################################
#			 									#
#     	 	      data segment				    #
#												#
#################################################

	.data
endl: 	.asciiz 	"\n"
prompt: .asciiz "Enter an integer"
fib: .asciiz "Fibonacci terms corresponding to that integer"