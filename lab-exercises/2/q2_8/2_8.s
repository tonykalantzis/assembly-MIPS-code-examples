#################################################
#			 									#
#     	 	data segment						#
#												#
#################################################

	.data
dividend: .asciiz "Enter dividend: "
divisor: .asciiz "Enter divisor: "
endl: 					.asciiz 	"\n"
quotient: .asciiz "quotient is: "
remainder: .asciiz "remainder is: "

#################################################
#												#
#				text segment					#
#												#
#################################################

	.text
	.globl __start	
												#read first int and move it to a temp reg
__start:
# Input
    la $a0,dividend
    li $v0,4
    syscall # prompt for dividend
    li $v0,5
    syscall # read dividend
    move $t0,$v0 # dividend in $t0

    move    $a0, $t0 #print int 
    li $v0 , 1
    syscall

    la		$a0,endl 			# system call to print
	li		$v0, 4 				# out a newline
	syscall

    la $a0,divisor
    li $v0,4
    syscall # prompt for divisor
    li $v0,5
    syscall # read divisor
    move $t1,$v0 # divisor in $t1

    move    $a0, $t1 #print int 
    li $v0 , 1
    syscall

    la		$a0,endl 			# system call to print
	li		$v0, 4 				# out a newline
	syscall

#Calculations
    div  $t4, $t0, $t1 #quotient in t4
    mfhi $t5 #remainder in $t5
#Output
    la $a0,quotient
    li $v0,4
    syscall # display "quotient is :"
    move $a0,$t4
    li $v0,1
    syscall # display quotient
    la $a0,endl
    li $v0,4
    syscall # newline
    la $a0,remainder


    li $v0,4
    syscall # display "remainder is :"
    move $a0,$t5
    li $v0,1
    syscall # display remainder
    la $a0,endl
    li $v0,4
    syscall # newline

Exit:				li 		$v0, 10
					syscall				#au revoir...