#System Calls

|Service|System Call codes|Arguments|Results|
|:---|:---:|:---:|---:|
|print_int|1|$a0=integer| |
|print_float|2|$f12 = float| |
|print_double|3|$f12 = double| | 
|print_string|4|$a0 = string| | 
|read_int|5| |integer (in $v0)| 
|read_float|6| |float (in $f0)| 
|read_double|7| |double (in $f0)| 
|read_string|8|$a0 = buffer, $a1 = length| | 
|sbrk|9|$a0 = amount|address (in $v0)|
|exit|10| | | 
|print_char|11|$a0 = char| | 
|read_char |12| |char (in $v0)| 
|open|13|$a0 = filename (string), $a1 = flags, $a2 = mode|file descriptor (in $v0)|
|read|14|$a0 = file descriptor, $a1 = buffer, $a2 = length|num chars read (in $v0)|
|write|15|$a0 = file descriptor, $a1 = buffer, $a2 = length|num chars written (in $v0)| 
|close|16|$a0 = file descriptor| | 
|exit2|17|$a0 = result| 
  






