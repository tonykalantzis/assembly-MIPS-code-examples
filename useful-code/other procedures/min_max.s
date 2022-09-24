minmax:   #as procedure
#max    
        move $v0, $a0    #v0 -> max
        first_comp : 
                        ble $a1,$v0,second_comp
                        move $v0,$a1
        second_comp : 
                        ble $a2,$v0,third_comp
                        move $v0,$a2
        third_comp : 
                        ble $a3,$v0, first
                        move $v0,$a3
#min
        first :
                		move $v1, $a0 
                        bge $a1,$v1,second
                        move $v1,$a1
        second : 
                        bge $a2,$v1,third
                        move $v1,$a2
        third : 
                        bge $a3,$v1, exit
                        move $v1,$a3                        
        exit:
                    jr $ra    

				