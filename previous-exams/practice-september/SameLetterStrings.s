#################################################
#			 									#
#     	 	data segment						#
#												#
#################################################

	.data
endl: 					.asciiz 	"\n"
str1: .space 50
str2: .space 50
message: .asciiz "Same letters:\n"
space: .asciiz " in postition " 
#################################################
#												#
#				text segment					#
#												#
#################################################

	.text
	.globl __start	
												#read first int and move it to a temp reg
__start:

    li $v0, 8					# code to read a string
	la $a0, str1			# ??? --> label with string
	li $a1, 50					# n chars --> $a1=n+1 eg: (20+1)--> li $a1, 21
	syscall
    li $v0, 4
	la $a0, str1					# ??? --> label with string
	syscall
    
    li $v0, 8					# code to read a string
	la $a0, str2			# ??? --> label with string
	li $a1, 50					# n chars --> $a1=n+1 eg: (20+1)--> li $a1, 21
	syscall
    li $v0, 4
	la $a0, str2					# ??? --> label with string
	syscall
   
    li $v0, 4
	la $a0, message					# ??? --> label with string
	syscall
#-----------------------------------------------------------------------------------------
    la $t0, str1
    la $t1, str2
    li $t8, 10
    li $t9, 1
loop: lbu $t2, 0($t0)
      lbu $t3, 0($t1)
      bne $t2, $t3, different_letter 
        beq $t2, $t8, Exit
        move $a0, $t2
        jal print_char 
        li $v0, 4
		la $a0, space				# ??? --> label with string
		syscall

        move $a0, $t9			# ???  --> register with integer
		li $v0, 1
		syscall
        la		$a0,endl 			# system call to print
		li		$v0, 4 				# out a newline
		syscall

    different_letter:
        addi $t9, $t9, 1
        addi $t0, $t0, 1
        addi $t1, $t1, 1
        lbu $t4, 0($t0)
        lbu $t5, 0($t1)
        beq $t4, $zero, Exit
        beq $t5, $zero, Exit 
        j loop



Exit:				li 		$v0, 10
					syscall				#au revoir...



print_char:			li $v0, 11				
					syscall
                    jr $ra