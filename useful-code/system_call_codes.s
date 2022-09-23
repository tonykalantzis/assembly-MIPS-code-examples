print_int 	-> 	1       $a0=integer
print_float -> 	2 		$f12 = float 
print_string -> 4 		$a0 = string (load the address with command la(load address))
read_int 	-> 	5		(integer in $v0)
read_float 	->	6		(float in $f0)
read_double ->	7 		(double in $f0)
read_string ->  8 		$a0 = buffer / $a1 = length
exit		->  10 		
print_char  -> 11 		$a0 = char