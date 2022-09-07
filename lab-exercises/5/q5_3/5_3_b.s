#################################################
#                                               #
# lab5_3a.s                                     #
# Integer factorial                             #
#                                               # 
################################################# 
 .data
n: .word 25
msg1: .asciiz "! is: "
endl: .asciiz "\n"   
   
    .text
                .globl __start
__start:
        la $a0,n
        lw $t0,0($a0) # $t0 = n
        li.s $f1, 1.0 # $t2 index i=1..n
        li $t2, 1 # $t1 contains i!

loop:   mtc1 $t2, $f2 
        cvt.s.w $f2, $f2
        mul.s $f1, $f1, $f2
         
        move $a0,$t2        #display i
        jal print_int

        la $a0,msg1         #display ! is:
        jal print_string

        mov.s $f12, $f1
        jal print_float
           
        jal print_endl

        addi $t2,$t2,1          # i=i+1
        ble $t2,$t0,loop        # repeat if i<=n
        
        
li $v0,10 # exit
syscall
######## procedures ############
print_string:		li $v0, 4
					syscall
					jr $ra

print_int:	        li $v0, 1
					syscall
					jr $ra

print_endl:		    la  $a0,endl 			 
					li	$v0, 4 				 #system call to print
					syscall
					jr $ra

print_float:	    li $v0, 2
					syscall
					jr $ra
#################################################
# #
# End of program #
# #
#################################################