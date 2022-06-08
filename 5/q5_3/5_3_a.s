#################################################
#                                               #
# lab5_3a.s                                     #
# Integer factorial                             #
#                                               # 
################################################# 
    .text
                .globl __start
__start:
        la $a0,n
        lw $t0,0($a0) # $t0 = n
        li $t2,1 # $t2 index i=1..n
        li $t1,1 # $t1 contains i!
loop:   mul $t1,$t1,$t2
        move $a0,$t2
        li $v0,1
        syscall # display i
        la $a0,msg1
        li $v0,4
        syscall # display "! is :"
        move $a0,$t1
        li $v0,1
        syscall # display i!
        la $a0,endl
        li $v0,4
        syscall # print end of line
        addi $t2,$t2,1 # i=i+1
        ble $t2,$t0,loop # repeat if i<=n
        li $v0,10 # exit
        syscall
 .data
n: .word 25
msg1: .asciiz "! is :"
endl: .asciiz "\n"
#################################################
# #
# End of program #
# #
#################################################