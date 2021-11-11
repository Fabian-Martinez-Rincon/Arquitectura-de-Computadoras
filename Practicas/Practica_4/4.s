.data
    tabla: .word 20, 1, 14, 3, 2, 58, 18, 7, 12, 11
    num: .word 7
    long: .word 10
.code
    ld R1, long(R0)         ; R1  = 10
    ld R2, num(R0)          ; R2 = 7
    dadd R3, R0, R0         ; R3 = R0 + R0 (INICIALIZO R3)
    dadd R10, R0, R0        ; R10 = R0 + R0 (INICIALIZO R10)

    loop: ld R4, tabla(R3)  ; R4 = TABLA + R3(POS) RECORRO LA TABLA
        beq R4, R2, listo   ; SI EL NRO DE LA TABLA ACTUAL ES IGUAL AL NRO QUE ESTOY BUSCANDO, TERMINO
        daddi R1, R1, -1    ; DECREMENTO EL CONTADOR DE TABLA
        daddi R3, R3, 8     ; R3 = R3 + 8 (CADA NRO EN LA TABLA OCUPA 1 BYTE QUE SON 8 BITS)
        bnez R1, loop       ; MIENTRAS NO LLEGUE AL FINAL, CONTINUO

    j fin                   ; TERMINO
    listo: daddi R10, R0, 1 ; R10 = 0 + 1 ; QUIERO ENTENDER QUE ES PARA AVISAR QUE ENCONTRE EL NRO
fin: halt
