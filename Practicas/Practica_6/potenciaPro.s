.data
    BASE: .word 2
    EXPONENTE: .word 2
.code
    LD $t0, BASE($0)
    LD $t1, EXPONENTE($0)
    DADDI $t2, $t2 , 1
    LOOP: BEQZ $t1, TERMINO
        dmul $t2, $t2, $t0  
        DADDI $t1, $t1, -1        
    J LOOP
TERMINO: HALT