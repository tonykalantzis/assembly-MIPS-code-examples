#################################################
#			 									#
#     	 		data segment					#
#												#
#################################################

			.data
endl:		.asciiz "\n"
pos_inf:	.word 0x7f800000
neg_inf:	.word 0xff800000
nan:		.word 0x7fffffff
prompt:		.asciiz "Give real number:\n"
output_msg: .asciiz "Number in scientific notation is:\n"
minus:      .asciiz "-"
plus:       .asciiz "+"
one_c:      .asciiz "1."
times:      .asciiz " x "
power:      .asciiz "2^"
bin_one:    .asciiz "1"
bin_zero:   .asciiz "0"

#################################################
#												#
#				text segment					#
#												#
#################################################

	.text
	.globl __start	

__start:

        while:
    		li $v0, 4
    		la $a0, prompt
    		syscall                 # prompt for input

    		li $v0, 6
    		syscall                 # get input

    		mov.s $f12, $f0
    		li $v0, 2
    		syscall                 # display input

    		la $a0, endl 			# system call to print
    		li $v0, 4 			    # out a newline
    		syscall

            li.s $f1, 0.0
            c.eq.s $f0, $f1       #if  $f0 == $f1 cc is true(1) else is false(0)
            bc1t Exit

            li $v0, 4
    		la $a0, output_msg
    		syscall                 # display output message

            mfc1 $t0, $f0
            srl $t1, $t0, 31

            beqz $t1, plus_sign
                la $a0, minus
                j continue0
            plus_sign:
                la $a0, plus
            continue0:

            li $v0, 4
            syscall                 # print sign

            la $a0, one_c
            syscall                 # print 1.

            li $t1, 0x7fffff
            and $t1, $t1, $t0       #masking

            li $t3, 0
            li $t4, 23
            sec_while:
                andi $t2, $t1, 1
                bnez $t2, exit_sec_while
                srl $t1, $t1, 1
                addi $t3, $t3, 1
                beq $t3, $t4, exit_sec_while
                j sec_while

            exit_sec_while:

            bne $t3, $t4, continue1
        		move $a0, $zero
        		li $v0, 1
                syscall
                j exponent
            continue1:

            sub $t4, $t4, $t3
            move $t5, $t4
            addi $t5, $t5, -1
            li $t6, 1
            sec_while1:
                beqz $t5, exit_sec_while1
                addi $t5, $t5, -1
                sll $t6, $t6, 1
                j sec_while1

            exit_sec_while1:

            sec_while2:
                beq $t4, $zero, exit_sec_while2
                and $t5, $t1, $t6
                bne $t5, $zero, one
                    la $a0, bin_zero
                    j printing
                one:
                    la $a0, bin_one
                printing:
            	li $v0, 4
            	syscall
                sll $t1, $t1, 1
                addi $t4, $t4, -1
                j sec_while2

            exit_sec_while2:

            exponent:

            li $v0, 4
    		la $a0, times
    		syscall 

            li $v0, 4
    		la $a0, power
    		syscall 
        
            li $t1, 0x7f800000
            and $t1, $t0, $t1
            srl $t1, $t1, 23
            addi $t1, $t1, -127

    		move $a0, $t1
    		li $v0, 1
    		syscall

            la $a0, endl 			# system call to print
    		li $v0, 4 			    # out a newline
    		syscall

            j while

Exit:				
		li $v0, 10
		syscall						# au revoir...

