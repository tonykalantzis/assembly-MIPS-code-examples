#################################################
#			 									#
#     	 	data segment						#
#												#
#################################################

	.data
endl: .asciiz 	"\n"
msg1: .asciiz "Give first number to add: "
msg2: .asciiz "Give second number to add: "
msg3: .asciiz "Sum of the two numbers is: "
msg4: .asciiz "Diff of the two numbers is: "
#################################################
#												#
#				text segment					#
#												#
#################################################

	.text
	.globl __start	
												#read first int and move it to a temp reg
__start:
        		li $v0, 4   #printf msg1
				la $a0, msg1				
				syscall
			
                li		$v0, 5 #read int
                syscall
                move	$t0, $v0

                move    $a0, $t0 #print int 
                li $v0 , 1
                syscall

                la		$a0, endl #print \n
                li		$v0, 4
                syscall
####################################################################			    
                li $v0, 4   #printf msg2
				la $a0, msg2				
				syscall
			
                li		$v0, 5 #read int
                syscall
                move	$t1, $v0

                move    $a0, $t1 #print int 
                li $v0 , 1
                syscall

                la		$a0, endl #print \n
                li		$v0, 4
                syscall
####################################################################
                li $v0, 4   #printf msg3
				la $a0, msg3				
				syscall

                add $t2, $t0, $t1 # a + b = $t2
                
                move $a0, $t2 #print int 
                li $v0 , 1
                syscall

                la		$a0, endl #print \n
                li		$v0, 4
                syscall
###################################################################
                li $v0, 4   #printf msg4
			    la $a0, msg4				
				syscall
               
                sub $t3, $t0, $t1 # a - b = $t3

                move $a0, $t3 #print int 
                li $v0 , 1
                syscall

                la		$a0, endl #print \n
                li		$v0, 4
                syscall
               
                j Exit


Exit:				li 		$v0, 10
					syscall				#au revoir...
