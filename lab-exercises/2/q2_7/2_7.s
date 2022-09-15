#################################################
#			 									#
#     	 	data segment						#
#												#
#################################################

	.data
endl: 					.asciiz 	"\n"
num1:   .word 0x80000000  #p1->0xa, p2->0x2        , p3-> 0x8000000
num2:   .word 0x80000000  #p1->0x8, p2->0xffffffff , p3-> 0x8000000
result: .space 16
#################################################
#												#
#				text segment					#
#												#
#################################################

	.text
	.globl __start	
												#read first int and move it to a temp reg
__start:
    
    lw $t0, num1
    lw $t1, num2

####multiplication 
    mult $t0 , $t1
    mflo $t2  #low register has the product of the multiplication
    sw $t2, result          #store result 
    mfhi $t3  #high register has the high-order word(extra result)
    sw $t3, result + 4

####multiplication unsigned
    multu $t0 , $t1
    mflo $t4
    sw $t4, result + 8
    mfhi $t5
    sw $t5, result + 12

Exit:				li 		$v0, 10
					syscall				#au revoir...