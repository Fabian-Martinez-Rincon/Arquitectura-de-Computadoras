.data
    TABLA:    .word 1,2,3,4,5,6,7
    BUSCAR:   .word 3
    LONG:     .word 7
.code
    LD $s0, LONG($0)
    DADDI $s1,$s1, TABLA
    LD $s2, BUSCAR($0)

    LOOP: LD $t0, 0($s1)
        BEQ $t0, $s2, IGUAL
        DADDI $s1, $s1, 8
        DADDI $s0, $s0, -1
    BNEZ $s0, LOOP
    DADDI R10,$0,0
    J FIN
    IGUAL: R10,$0,1

FIN: HALT