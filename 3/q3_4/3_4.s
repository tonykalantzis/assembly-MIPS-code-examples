#################################################
#			 									#
#     	 	data segment						#
#												#
#################################################

	.data
endl: 					.asciiz 	"\n"
str: .space 50
msg: .asciiz "Give a string or 0 to finish.\n"
#################################################
#												#
#				text segment					#
#												#
#################################################

	.text
	.globl __start	
												#read first int and move it to a temp reg
__start:
addi $t0, 1 # t0 is the counter 
addi $t1, 10


loop:   li $v0, 4
		la $a0, msg					# ??? --> label with string
		syscall 

        li $v0, 8					# code to read a string
		la $a0, str					# ??? --> label with string
		li $a1, 51					# n chars --> $a1=n+1 eg: (20+1)--> li $a1, 21
		syscall
        
        la $s0, str 
        #addi $t1, 0 # t1 is the inside counter
        loop2:  lbu $t2, 0($s0)
                beq $t2, $t1, exit #if zero exit
                li $t9, 122
                bgt	$t2, $t9, step 	# if $t2 > 122  next
                li $t9, 97
                blt $t2, $t9, step  # if less than 97 next
                li $t9, 32         # then its capital 
                sub $t2, $t2, $t9  #and convert
                sb $t2,0($s0)  
            step:addi $s0,$s0, 1
                j loop2
       exit: 
                
        li $v0, 4
		la $a0, str					# ??? --> label with string
		syscall
        

Exit:				li 		$v0, 10
					syscall				#au revoir...
