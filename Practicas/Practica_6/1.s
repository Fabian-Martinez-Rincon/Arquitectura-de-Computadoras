.data
    CONTROL:  .word 0x10000
    DATA:     .word 0x10008
    TEXTO:    .asciiz "Hola, Mundo!" 

.code
    LD $s0, CONTROL($0)  
    LD $s1, DATA($0)      
     

    DADDI $t0, $0, TEXTO  
    SD $t0, 0($s1)        
    
    DADDI $t0, $0, 4      
    SD $t0, 0($s0)        
HALT

;(1) $t0 = 4 -> función 4: salida de una cadena ASCII
;(2) CONTROL recibe 4 y produce la salida del mensaje

