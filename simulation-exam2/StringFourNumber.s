#################################################
#			 									#
#     	 	data segment						#
#												#
#################################################

	.data
endl: 					.asciiz 	"\n"
str: .space 21
msg1: .asciiz "\nk = "
msg2: .asciiz "\nm = "
startmsg: .asciiz "Give me the string:"
bye: .asciiz "bye:)"
#################################################
#												#
#				text segment					#
#												#
#################################################

	.text
	.globl __start	
												#read first int and move it to a temp reg
__start:

loop: 
        la $a0, startmsg
        li $v0, 4
	    syscall
        li $v0, 8
		la $a0, str
        li $a1, 21				# ??? --> label with string
		syscall
        move $t0, $a0  #t0 is the string
        la $a0, str
        li $v0, 4
	    syscall


        li $v0, 4
		la $a0, msg1					# ??? --> label with string
		syscall
        li		$v0, 5				# $v0 <--- integer
		syscall
        move $t1, $v0 #t1 = n
        move	$a0, $t1			# ???  --> register with integer
		li $v0, 1
		syscall
        


        li $v0, 4
		la $a0, msg2					# ??? --> label with string
		syscall
        li		$v0, 5				# $v0 <--- integer
		syscall
        move $t2, $v0 #t2 = m
        move	$a0, $t2			# ???  --> register with integer
		li $v0, 1
		syscall
        la		$a0,endl 			# system call to print
		li		$v0, 4 				# out a newline
		syscall        

        add $k1, $t1, $t2
        beq $k1, $zero, Exit

        addi $t1, $t1, -1
        li $t9, 4
        mult $t1, $t9 
        mflo $t3
        
        addi $t2, $t2, -1
        li $t9, 4
        mult $t2, $t9 
        mflo $t4 
#------------------------------------------------------------------------------------

        la $s0, str
        
        li $s2, 0
        li $s5, 20
        loop2:  beq $s2, $t3, changeN
                beq $s2, $t4, changeM
             c1:
                lbu $s3, 0($s0)           
                li $v0, 11
	            move $a0, $s3			
	            syscall
                addi $s0, $s0, 1
                addi $s2, $s2, 1     
                bge $s2, $s5, exit1
                j loop2
    exit1:
    la		$a0,endl 			# system call to print
	li		$v0, 4 				# out a newline
	syscall
j loop
Exit:				la $a0, bye
                    li $v0, 4
	                syscall 
                    li 		$v0, 10
					syscall				#au revoir...


changeN: la $s1, str
         add $s1, $s1, $t4
         lbu $s3, 0($s1)
         li $v0, 11
	     move $a0, $s3			
	     syscall
         addi $s1, $s1, 1
         lbu $s3, 0($s1)
         li $v0, 11
	     move $a0, $s3			
	     syscall
         addi $s1, $s1, 1
         lbu $s3, 0($s1)
         li $v0, 11
	     move $a0, $s3			
	     syscall
         addi $s1, $s1, 1
         lbu $s3, 0($s1)
         li $v0, 11
	     move $a0, $s3			
	     syscall
         addi $s0, $s0, 4
         addi $s2, $s2, 4
         j c1
         
changeM: la $s1, str
         add $s1, $s1, $t3
         lbu $s3, 0($s1)
         li $v0, 11
	     move $a0, $s3			
	     syscall
         addi $s1, $s1, 1
         lbu $s3, 0($s1)
         li $v0, 11
	     move $a0, $s3			
	     syscall
         addi $s1, $s1, 1
         lbu $s3, 0($s1)
         li $v0, 11
	     move $a0, $s3			
	     syscall
         addi $s1, $s1, 1
         lbu $s3, 0($s1)
         li $v0, 11
	     move $a0, $s3			
	     syscall
         addi $s0, $s0, 4
         addi $s2, $s2, 4
         j c1

           
