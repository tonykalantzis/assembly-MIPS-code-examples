------------------------ STRINGS -------------------------								
print_endl:			la	$a0,endl 			 
					li	$v0, 4 				#system call to print
					syscall
					jr $ra

read_string:		li $v0, 8				#code to read a string
					la $a0, ???				#??? --> label with string
					li $a1, ?n?				#n chars --> $a1=n+1 eg: (20+1)--> li $a1, 21
					syscall
					jr $ra

print_string:		li $v0, 4
					la $a0, ???				#??? --> label with string
					syscall
					jr $ra

----------------------- INTEGERS ---------------------------

read_int:			li	$v0, 5				 #$v0 <--- integer
					syscall
					jr $ra

print_int:			move $a0, ???			 #???  --> register with integer
					li $v0, 1
					syscall
					jr $ra

print_immidiate:	li $v0, 1
					li $a0, ???				#???  --> immediate
					syscall
					jr $ra

------------------------ FLOATS ----------------------------

- SINGLE PRECISION

read_float:			li	$v0, 6				# $f0 <--- float
					syscall
					jr $ra

print_float_from_reg:	mov.s	$f12, ???	# ???  --> FP register with float
						li $v0, 2
						syscall
						jr $ra

print_float_immidiate:	li $v0, 2
						li.s $f12, ???		# ???  --> immediate, e.g -1.2345678
						syscall
						jr $ra


- DOUBLE PRECISION

read_double:		li	$v0, 7			# $f0 <--- double
					syscall
					jr $ra

print_double_from_reg:	mov.d	$f12, ???	# ???  --> FP register with float
						li $v0, 3
						syscall
						jr $ra

print_double_immidiate:	li $v0, 3
						li.d $f12, ???		# ???  --> immediate, e.g -1.2345678
						syscall
						jr $ra

- CONVERSIONS

convert_int_to_float:	mtc1 $t2,$f2       #from integer to float $f2 register destination
            			cvt.s.w $f2, $f2    #$f2->1.0 

convert_float_to_int:	cvt.w.s $f2,$f2
						mfc1 $t2,$f2

*** If you want to transfer the binary number as is(without conversion to an integer) from a float register to an integer register 
(and vice versa) you can just use mtc1(move to coprocessor1) without the command cvt.w.s.(or in the other case cvt.s.w)