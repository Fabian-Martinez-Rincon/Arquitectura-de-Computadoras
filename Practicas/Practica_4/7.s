.data
    TABLA: .word 1,2,3,4,5,6,7,8,9,10
    NUM: .word 7
    LONG: .word 10
    CANT: .word 0
    RES: .word 0,0,0,0,0,0,0,0,0,0
.code
    ld R1, LONG(R0)         ; R1  = 10
    ld R2, NUM(R0)          ; R2 = 7
    ld R3, CANT(R0)
    ld R6, RES(R0)
    dadd R4, R0, R0         ; R4 = R0 + R0 (INICIALIZO R4)
    dadd R10, R0, R0        ; R10 = R0 + R0 (INICIALIZO R10)
    DADDI R8, R0, 1
    loop: ld R5, TABLA(R4)  ; R5 = TABLA + R4(POS) RECORRO LA TABLA
        slt R7, R2, R5
        BNE R7, R8, continuar
        daddi R3, R3, 1
        SD R6, RES(R4)
        continuar: daddi R1, R1, -1    ; DECREMENTO EL CONTADOR DE TABLA
        daddi R4, R4, 8     ; R4 = R4 + 8 (CADA NRO EN LA TABLA OCUPA 1 BYTE QUE SON 8 BITS)
        bnez R1, loop       ; MIENTRAS NO LLEGUE AL FINAL, CONTINUO

    j fin                   ; TERMINO
    listo: daddi R10, R0, 1 ; R10 = 0 + 1 ; QUIERO ENTENDER QUE ES PARA AVISAR QUE ENCONTRE EL NRO
fin: halt




 