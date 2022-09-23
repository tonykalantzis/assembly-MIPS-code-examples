->Print the first five chars of the string
	move $a0,$t1
    sb $zero, str2 + 5     #store byte 
    syscall

char_isolation: li $t0,0			#counter
                la $s0, string
                isolation_of_char_in_string:	lbu $t1,0($s0)
                                                addi $s0,$s0,1
                                                addi $t0,$t0,1
                                                beq $t0, $XX, exit 			#XX register with length of the string
                                                j isolation_of_char_in_string	#next char
