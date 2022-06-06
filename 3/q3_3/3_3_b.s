#################################################
#			 									#
#     	 	data segment						#
#												#
#################################################

	.data
endl: 					.asciiz 	"\n"
string: .asciiz "This is string is to be read:)\n"
copy: .space 80
#################################################
#												#
#				text segment					#
#												#
#################################################

	.text
	.globl __start	
												#read first int and move it to a temp reg
__start:
        li $t1,0 # counter for string
        li $t9, 13 #n is max values read ###################change ###############
        li $s0,'g' # character to end copy

while:  lbu $t0,string($t1) # load a character
        beq $t0,$s0,condition # if character to end copy then exit loop
        
continue:sb $t0,copy($t1) # copy character 
        addi $t1,$t1,1 # increment counter
        j while # repeat while loop
end:    li $t2,0
        sb $t2,copy($t1) # append end character to copied string
        la $a0,copy # display copy
        li $v0,4
        syscall
        j Exit

condition: bgt $t1, $t9, continue
           j end

Exit:				li 		$v0, 10
					syscall				#au revoir...
