#################################################
# #
# lab4_1a.s #
# stack exercise 1 (to be completed) #
# #
#################################################
 .text
 .globl __start
__start:
# start of main program
 li $a0,-10 # Initialize variables
 li $a1,-30 #
 li $a2,120 #
 li $a3,200 #
 
 jal minmax

 move $t0,$v0
 move $t1,$v1
 la $a0,max
 li $v0,4
 syscall # display "Max is :"
 move $a0,$t0
 li $v0,1
 syscall # display max
 la $a0,endl
 li $v0,4
 syscall # display end of line
 la $a0,min
 li $v0,4
 syscall # display "Min is :"
 move $a0,$t1
 li $v0,1
 syscall # display min
 la $a0,endl
 li $v0,4
 syscall # display end of line
 li $v0,10
 syscall # exit
# end of main program
# start of procedure
minmax:  
#max    
        move $v0, $a0    #v0 -> max
        first_comp: 
                        ble $a1,$v0,second_comp
                        move $v0,$a1
        second_comp: 
                        ble $a2,$v0,third_comp
                        move $v0,$a2
        third_comp: 
                        ble $a3,$v0, first
                        move $v0,$a3
#min
        first:
                move $v1, $a0 
                        bge $a1,$v1,second
                        move $v1,$a1
        second: 
                        bge $a2,$v1,third
                        move $v1,$a2
        third: 
                        bge $a3,$v1, exit
                        move $v1,$a3                        
        exit:
                    jr $ra    
# end of procedure
 .data
max: .asciiz "Max is : "
min: .asciiz "Min is : "
endl: .asciiz "\n"
#################################################
#                                               #
#               End of program                  #
#                                               #
#################################################