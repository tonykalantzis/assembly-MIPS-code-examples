.data 
    prompt:.asciiz "Enter an integer:\n " 
    addsh: .asciiz " The sum in decimal is: \n"
    binar: .asciiz " The sum in binary is:\n "
    sgt: .asciiz " The second integer is greater than the first. n\n"
    fgt: .asciiz " The first integer is greater than the second.\n"
    equal: .asciiz "The two entered values are equal: \n"

.text
.globl __start	
main:

li $v0, 4 #print string code
la $a0, prompt #argument
syscall #execute, service print stri

li $v0, 5 # read integer
syscall #v0 gets the returned value
move $s0, $v0 #set v0 -> s0

li $v0, 4 
la $a0, prompt
syscall

li $v0, 5
syscall
move $s1, $v0 #set v0 -> s1
add  $s2, $s1, $s0 #s2 -> s0 + s1

li $v0, 4 #print string
la $a0, add #argument
syscall 

move $a0, $s2
li $v0, 1 #print int
syscall

# Output "sum in binary is:".  
la $a0, bin
li $v0, 4
syscall


# Output the binary number.  (This is done by isolating one bit
# at a time, adding it to the ASCII code for '0', and outputting
# the character.  It is important that the bits are output in
# most-to-least significant bit order.
move $t2, $a0
li $s1, 32         # Set up a loop counter
Loop:
    rol $t2, $t2, 1    # Roll the bits left by one bit - wraps highest bit to lowest bit.
    and $t0, $t2, 1    # Mask off low bit (logical AND with 000...0001)
    add $t0, $t0, 48   # Combine it with ASCII code for '0', becomes 0 or 1 

    move $a0, $t0      # Output the ASCII character
    li $v0, 11
    syscall

    subi $s1, $s1, 1   # Decrement loop counter
    bne $s1, $zero, Loop  # Keep looping if loop counter is not zero

slt $t0, $s0, $s1
beq $t0, $0, else
li $v0, 4 
la $a0, sgt
syscall
j jump
else: 
li $v0, 4 
la $a0, fgt 
syscall 

jump:
li $v0, 10 #system call for exit
syscall