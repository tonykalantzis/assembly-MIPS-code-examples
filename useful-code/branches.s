---------------------- SWITCH CASE  ----------------------------	

switch_case_no_break:   
						move $XY, $zero     	 #initialize flag register $XY
		case01:			bXX $YY,$ZZ, case02 	 #this condition/case is not valid, check next case 	
		if_case01:		
						addi $XY, $XY, 1
						
		case02:			bXX $YY,$ZZ, case?? 	 #this condition/case is not valid, check next case 	
		if_case02:		
						addi $XY, $XY, 1						

						
						
		case0n:			bXX $YY,$ZZ, case03 	 #this condition/case is not valid, check next case 	
		if_case0n:		
						addi $XY, $XY, 1
						
		else_case:		bne $XY,$zero, Exit	 #non of previous conditions/cases exit, exit 	
		if_non_case:	


						
switch_case_with_break:
		case001:		bXX $YY,$ZZ, case02 	 #this condition/case is not valid, check next case 	
		if_case001:		
						j Exit_switch_case
						
		case002:		bXX $YY,$ZZ, case?? 	 #this condition/case is not valid, check next case 	
		if_case002:		
						j Exit_switch_case						

					
						
		case00n:		bXX $YY,$ZZ, else_case 	 #this condition/case is not valid, check next case 	
		if_case00n:		
						j Exit_switch_case
						
		else_case_:			 		 #non of previous conditions/cases exit 	
		if_non_case_:	


---------------------------- WHILE  ----------------------------	
		
while_do_1_condition:   
						bXX $YY,$ZZ, exit_while

						
						addi counter, counter, 1  		#possible approach
						
						j while_do_1_condition
		
while_do_a_AND_b:   					 #when !a OR !b, exit while
						bXX $RR,$ZZ, exit_while     if a is not valid exit while
						bYY $WW,$TT, exit_while     if b is not valid exit while

						
						addi counter, counter, 1  	#possible approach
						
						j while_do_a_AND_b
		
while_do_a_OR_b_2:   					 #when !a AND !b exit wile
			check_a:	bXX $RR,$ZZ, check_b    	 #if a is not valid check b
						
			do:			
						addi counter, counter, 1  #possible approach
						j while_do_a_OR_b_2
			
			check_b:	bYY $WW,$TT, exit_while     #if b is not valid exit while
						
						j do

------------------------ IF ----------------------------	
$s1 --> a     , $s2 --> b

if_a_equals_b_else:			bne $s1, $s2,else
                            ..... 	#instructions that will run if $s2=$s3
                            j exit
			else:	.....	#instructions that will run if $s2<>$s3
			exit:	.....

General instructions about branches and their logic. Below work for if-commands mostly.

$s0 == $s1 		----->	bne $s0,$s1,label
$s0 <> $s1 		----->	beq $s0,$s1,label
$s0	>= $s1 		----->	blt $s0,$s1,label
$s0	<= $s1		----->  bgt $s0,$s1,label
$s0  > $s1 		----->  ble $s0,$s1,label
$s0  < $s1		----->	bge $s0,$s1,label

In branches we put the opposite condition from the one that we want to apply(e.g. if we want $s1<>$s2 the branch command is 
beq $$s1,$s2,else). Below the branch command , we put all the commands that we want to run if the condition($s1<>$s2)
is true(last command is always jump - j label so as to skip the label of the branch) and below them is the label(e.g. else). This 
label has all the commands that will run if the condition is false(the case of branch is valid).
