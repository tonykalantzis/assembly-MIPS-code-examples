#################################################
#			 									#
#     	 	data segment						#
#												#
#################################################

	.data
prompt:     .asciiz "Enter integer number: "
memused:    .asciiz "Stack bytes used: "
endl:       .asciiz "\n"
#################################################
#												#
#				text segment					#
#												#
#################################################

	.text
	.globl __start	
												#read first int and move it to a temp reg
__start:
# start of main program

    la $a0, prompt
    li $v0, 4
    syscall         # display "Enter integer number: "

    li $v0, 5
    syscall         # read integer

    move $t0, $v0
    move $a0, $t0    #$a0 has the integer to be print

    li $v0, 1
    syscall         # display integer

    la $a0, endl
    li $v0,4
    syscall         # display end of line

    move $a0, $t0

    move $v0, $sp
    move $s0, $sp
    jal rec_countdown

    sub $s0, $s0, $v0 
    la $a0, memused
    li $v0, 4
    syscall         # display "Stack bytes used: "
    move $a0, $s0
    li $v0, 1
    syscall         # display memory used
    la $a0, endl
    li $v0,4
    syscall         # display end of line

    li $v0, 10
    syscall         # exit

# end of main program

# start of procedure
    rec_countdown:
            addi $sp, $sp, -4
            sw $ra, 0($sp)
            ble $a0, $zero, return                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
                addi $a0, $a0, -1
                jal rec_countdown
            return:
                move $t0, $v0
                li $v0, 1
                syscall         # display argument
                move $t1, $a0
                la $a0, endl
                li $v0,4
                syscall         # display end of line
                move $v0, $t0
                move $a0, $t1
                bge $sp, $v0, nothing
                    move $v0, $sp
            nothing: 
                addi $a0, $a0, 1
                lw $ra, 0($sp)
                addi $sp, $sp, 4
                jr $ra

# end of procedur

Exit:				li 		$v0, 10
					syscall				#au revoir...
