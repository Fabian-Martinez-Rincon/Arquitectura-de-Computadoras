.data
    CONTROL: .word 0x10000
    DATA:    .word 0x10008
    PIXEL:   .byte 0, 185, 135, 0, 23, 10, 0, 0
    
    MATRIZ: .byte 1, 1, 1, 1, 1, 1, 1
            .byte 1, 1, 1, 1, 1, 1, 1
            .byte 1, 1, 1, 1, 1, 1, 1
            .byte 1, 1, 1, 1, 1, 1, 1
            .byte 1, 1, 1, 1, 1, 1, 1
            .byte 1, 1, 1, 1, 1, 1, 1
            .byte 1, 1, 1, 1, 1, 1, 1
            .byte 1, 1, 1, 1, 1, 1, 1
            .byte 1, 1, 1, 1, 1, 1, 1
    COLUMNAS: .word 7
    FILAS:    .word 9
.code
    LD $s0, CONTROL ($0)     
    LD $s1, DATA ($0)        

    LD $t5, COLUMNAS ($0)
    DADDI $t1, $t1, 0
    
    LOOP: beqz $t5, TERMINO
        LD $t0, MATRIZ ($1)
        SD $t0, 0 ($s1)  

        DADDI $t0, $0, 5
        SD $t0, 0 ($s0) 
        DADDI $t1, $t1, 1
        DADDI $t5, $t5, -1
    J LOOP

TERMINO: HALT