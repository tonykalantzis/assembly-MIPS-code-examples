#################################################
#                                               #
#                  lab4_1a.s                    #
#      stack exercise 1 (to be completed)       #
#                                               #
#################################################
#################################################
#		        			#
#     	          data segment		     	#
#						#
#################################################
.data
max: .asciiz "Max is : "
min: .asciiz "Min is : "
endl: .asciiz "\n"
#################################################
#						#
#               text segment			#
#       					#
#################################################
 .text
 .globl __start
__start:
# start of main program
 li $a0,-10 # Initialize variables
 li $a1,-30 
 li $a2,120 
 li $a3,200 
 
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
minmax: addi $sp,$sp,-8
        sw $s0,0($sp)
        sw $s1,4($sp)

min1:   move $s0,$a0   #hold min value

cont4:  bge $s0,$a1,cont5
        move $s0,$a1

cont5:  bge $s0,$a2,cont6
        move $s0,$a2

cont6:  bge $s0,$a3,resMin
        move $s0,$a3

resMin: move $v0,$s0

max1:   move $s1,$a0    #hold max value

        ble $s1,$a1,cont2
        move $s1,$a2

cont2:  ble $s1,$a2,cont3
        move $s1,$a2

cont3:  ble $s1,$a3,resMax
        move $s1,$a3

resMax: move $v1,$s1

        lw $s0,0($sp)
        lw $s1,4($sp)
        addi $sp,$sp,8

        jr $ra
# end of procedure
 
#################################################
#                                               #
#               End of program                  #
#                                               #
#################################################