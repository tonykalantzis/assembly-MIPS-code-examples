#################################################
#			 									#
#     	 	data segment						#
#												#
#################################################

	.data
endl: 					.asciiz 	"\n"
str: .space 5
eight: .word 0x0000008
nine: .word 0x00000008
error: .asciiz "Wrong Input, we put binary numbers."
msg1: .asciiz "Please a octadecimal number one by one and after each press enter. "
#################################################
#												#
#				text segment					#
#												#
#################################################

	.text
	.globl __start	
												#read first int and move it to a temp reg
__start:
lw $t8, eight
lw $t9, nine

print_msg1:			li $v0, 4
					la $a0, msg1					# ??? --> label with string
					syscall
                    la		$a0,endl 			# system call to print
					li		$v0, 4 				# out a newline
					syscall
					


read_ints:			li		$v0, 5				# $v0 <--- integer ###### read octadecimal ints
					syscall
					move $t3, $v0
                    bge $t3, $t9 , error_message1 

        			li		$v0, 5				# $v0 <--- integer
					syscall
					move $t2, $v0
                    bge $t2, $t9 , error_message1

                    li		$v0, 5				# $v0 <--- integer
					syscall
					move $t1, $v0
                    bge $t1, $t9 , error_message1

                    li		$v0, 5				# $v0 <--- integer
					syscall
					move $t0, $v0
                    bge $t0, $t9 , error_message1 ######################### end of reading

                    #######################conversion##########################
                    #$t0 is the first 
                    # push return address onto the stack
	                addi	$sp, $sp, -8
	                sw	$ra, 4($sp)
                    
                    move $a0, $t0
                    jal print_binary

                    ##########################################################
                    j Exit



error_message1: 	li $v0, 4
					la $a0, error					# ??? --> label with string
					syscall
					la		$a0,endl 			# system call to print
					li		$v0, 4 				# out a newline
					syscall

#################function to print in binary ##############################################
print_binary:
	addi	$sp, $sp, -8
	sw	$ra, 4($sp)

	move	$s0, $a0
	addi	$s1, $zero, 31	# constant shift amount
	addi	$s2, $zero, 0	# variable shift amount
	addi	$s3, $zero, 4	# exit condition
print_binary_loop:
	beq	$s2, $s3, print_binary_done
	sllv	$a0, $s0, $s2
	srlv	$a0, $a0, $s1
	li	$v0, 1		# PRINT_INT
	syscall
	addi	$s2, $s2, 1
	j	print_binary_loop
print_binary_done:
	lw	$ra, 4($sp)
	addi	$sp, $sp, 8
	jr	$ra


##########################################################################################

Exit:				li 		$v0, 10
					syscall				#au revoir...