#################################################
#			 									#
#     	 	data segment						#
#												#
#################################################

	.data
endl: 					.asciiz 	"\n"
vector1: .float 1.0,2.0,3.0, 4.0, 5.0, 9.0 
vector2: .float 1.0,1.0,2.0, 1.0, 3.0, 1.0
n: .word 6 #number of elements in the vectors
vector3: .space 40
parenthesi1: .asciiz "[ "
parenthesi2: .asciiz " ]"
sin: .asciiz " + "
space: .asciiz " "
equal: .asciiz " = "
#################################################
#												#
#				text segment					#
#												#
#################################################

	.text
	.globl __start	
												#read first int and move it to a temp reg
__start:
    lbu $t0, n
    
    la $a0, parenthesi1
    jal print_str
    la $t1, vector1 #address
loop1:  
        l.s $f0, 0($t1)
        mov.s $f12, $f0			
		li $v0, 2 #print float
		syscall
        addi $t1, $t1, 4 #next element in vector
        addi $t2, $t2, 1
        beq $t2, $t0, exit1 #if counter equals to number of elements in vector
        la $a0, space #print space
        jal print_str
j loop1        
exit1:   la $a0, parenthesi2
        jal print_str
#---------------------------------------------------
la $a0, sin
jal print_str
#---------------------------------------------------
    la $a0, parenthesi1
    jal print_str
    la $t3, vector2 #address
    li $t2, 0
loop2:  
        l.s $f0, 0($t3)
        mov.s $f12, $f0			
		li $v0, 2 #print float
		syscall
        addi $t3, $t3, 4 #next element in vector
        addi $t2, $t2, 1
        beq $t2, $t0, exit2 #if counter equals to number of elements in vector
        la $a0, space #print space
        jal print_str
j loop2        
exit2:   la $a0, parenthesi2
        jal print_str
#---------------------------------------------------
la $a0, equal
jal print_str
#---------------------------------------------------
    la $a0, parenthesi1 
    jal print_str
    la $t1, vector1
    li $t2, 0
    la $t3, vector2

loop3:  l.s $f0, 0($t1)
        l.s $f1, 0($t3)
        add.s $f3, $f0, $f1
        mov.s $f12, $f3
        li $v0, 2 #print float
		syscall 
        addi $t1, $t1, 4 #next element in vector1
        addi $t3, $t3, 4 #next element in vector2
        addi $t2, $t2, 1
        beq $t2, $t0, exit3 #if counter equals to number of elements in vector
        la $a0, space #print space
        jal print_str
j loop3
exit3: la $a0, parenthesi2
       jal print_str

Exit:				li 		$v0, 10
					syscall				#au revoir...




print_str:			li $v0, 4
					syscall
					jr $ra