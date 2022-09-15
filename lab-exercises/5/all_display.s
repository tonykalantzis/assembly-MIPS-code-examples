#################################################
#			 									#
#     	 	      data segment				    #
#												#
#################################################

	.data
endl: 	.asciiz 	"\n"
zero:   .asciiz     "Zero:"
inf_m:  .asciiz     "Minus infinite:"
inf_p:  .asciiz     "Plus infinite:"
mess_nan:   .asciiz    "NaN:"
mess_not_def:   .asciiz "Not defined:"

zer_f:  .float 0.0
m_inf:  .word 0xff800000
p_inf:  .word 0x7f800000
nan:    .word 0x7fffffff
not_defined:    .word 0xffc00000
x:      .float   55.0
y:      .float  -55.0 

#################################################
#												#
#				  text segment					#
#												#
#################################################

	.text
	.globl __start	
__start:
#-------------start of main program-------------#
print_zero_mess:        la $a0,zero 
                        jal print_string

print_zero:             l.s $f12,zer_f
                        jal print_float
                        jal printEndl

print_m_inf_mess:       la $a0,inf_m 
                        jal print_string

print_m_inf:            l.s $f12,m_inf 
                        jal print_float
                        jal printEndl

print_p_inf_mes:        la $a0,inf_p
                        jal print_string

print_p_inf:            l.s $f12,p_inf       #load single
                        jal print_float
                        jal printEndl

print_NaN_mess:         la $a0,mess_nan
                        jal print_string

print_NaN:              l.s $f12,nan 
                        jal print_float
                        jal printEndl

print_mess_not_def:     la $a0,mess_not_def
                        jal print_string

print_not_def:          l.s $f12, not_defined
                        jal print_float
                        jal printEndl



Exit:   li 	$v0, 10
		syscall				#au revoir...
#-------------end of main program--------------#

#-------------start of procedures--------------#
print_float:	    li $v0, 2
					syscall
					jr $ra

printEndl:		    la	$a0,endl 			 
					li	$v0, 4 				 
					syscall
					jr $ra

print_string:		li $v0, 4
					syscall
					jr $ra

#-------------end of procedures---------------#

