#################################################
#			 									#
#     	 	      data segment				    #
#												#
#################################################

	.data
endl: 	.asciiz 	"\n"
str1:   .space 11
str2:   .space 11
mess: .asciiz  "Give a string of 10 characters: "
position1:	.asciiz  "Position of character in the first string: "
position2:	.asciiz  "Position of character in the second string: "

#################################################
#												#
#				  text segment					#
#												#
#################################################
	.text
	.globl __start	
__start:
#-------------start of main program-------------#
					la $a0, mess
					jal print_string
					
read_string1:		li $v0, 8					 #code to read a string
					la $a0,str1					 #??? --> label with string
					li $a1,11					 #n chars --> $a1=n+1 eg: (20+1)--> li $a1, 21
					syscall
					
print_string1:		li $v0, 4
					la $a0, str1				#str1--> label with string1
					syscall
					
					jal print_endl
					
					la $a0, mess
					jal print_string
					
read_string2:		li $v0, 8					 #code to read a string
					la $a0,str2					 #??? --> label with string
					li $a1,11					 #n chars --> $a1=n+1 eg: (20+1)--> li $a1, 21
					syscall

print_string2:		li $v0, 4
					la $a0, str2				#str2 --> label with string2
					syscall
					
					jal print_endl
					
					li $t1,0				#counter of str1--
					la $s0, str1			#$s0-> string
					li $t5, 10 				#constant
					
isolation:			lbu $t0, 0($s0)			#$t0 has the char of str1
					li $t2, 0 				#counter of str2
					la $s1, str2			#$s1-> string
					search_str2:	lbu $t3,0($s1)			#$t3 has the char of str2
									bne $t3,$t0,next_char
									
									move $a0,$t3			#print the mutual char
									jal print_char	
									jal print_endl
									
									la $a0, position1		#print message
									jal print_string
									
									move $a0, $t1
									jal print_int			#print position 
									jal print_endl
									
									la $a0,position2		#print message
									jal print_string
									move $a0, $t2
									jal print_int			#print position 
									jal print_endl
									
									next_char:	addi $s1,$s1,1
												addi $t2, $t2, 1
												beq $t2,$t5,next_str1
												j search_str2
								
				next_str1:	add $s0, $s0,1
							addi $t1,$t1,1
							beq $t1,$t5,exit		#if $t1==10 exit
							j isolation				#next char of str1

exit:   li 	$v0, 10
		syscall				#au revoir...
#-------------end of main program--------------#

#-------------start of procedures--------------#
print_endl:			la	$a0,endl 			 
					li $v0, 4 				#system call to print
					syscall
					jr $ra
		
print_string:		li $v0, 4
					syscall
					jr $ra

print_char:			li $v0,11
					syscall 
					jr $ra
					
print_int:			li $v0, 1
					syscall
					jr $ra

#-------------end of procedures---------------#


